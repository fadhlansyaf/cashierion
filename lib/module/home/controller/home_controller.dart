import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/module/register/view/register_page.dart';

import '../../../api/api_manager.dart';
import '../../../model/database/database_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/preferences.dart';
import '../../category_list/controller/category_list_dao.dart';
import '../../product_list/controller/product_list_dao.dart';
import '../../register/controller/register_binding.dart';

class HomeLogic extends GetxController {
  ///Index untuk bottomnavbar
  var selectedIndex = 0.obs;
  var categoryList = <CategoryModel>[].obs;
  var productList = <ProductModel>[].obs;
  Rx<PaymentTypeModel> selectedPaymentType =
      PaymentTypeModel(paymentName: '').obs;
  var paymentTypeList = <PaymentTypeModel>[].obs;
  Rx<PaymentDetailModel?> selectedPaymentDetail = Rx<PaymentDetailModel?>(null);
  ///Digunakan pada transaction detail
  var specificPaymentDetail = <PaymentDetailModel>[].obs;
  ///Digunakan pada edit payment detail di profile
  var allPaymentDetail = <PaymentDetailModel>[].obs;
  ///% tax
  var tax = 0.obs;
  ///Total tax setelah dihitung
  var taxTotal = 0.0.obs;
  ///Total semua item dan tax
  var totalAmount = 0.0.obs;
  ///Untuk cek tipe transaksi order/restock
  var isOrder = true.obs;
  ///Index untuk transaction
  var pageIndex = 0.obs;
  ///Hasil prediksi image dari api
  Rx<Uint8List?> predictionImage = Rx<Uint8List?>(null);
  var canPredict = true.obs;
  ///Indikasi jika tidak ada internet
  var noInternet = false.obs;
  var sales = 0.0.obs;
  var expenditure = 0.0.obs;
  var todayTransaction = 0.obs;
  var todaySoldProducts = 0.obs;
  var storeName = ''.obs;
  var phoneNumber = ''.obs;
  var address = ''.obs;
  var description = ''.obs;

  //variabel untuk bottomsheet
  ///Panggil jika butuh setstate pada bottomsheet
  Rx<StateSetter?> setStatePaymentType = Rx<StateSetter?>(null);
  Rx<StateSetter?> setStatePaymentDetail = Rx<StateSetter?>(null);

  final paymentTypeController = TextEditingController();
  final paymentDetailController = [
    TextEditingController(),
    TextEditingController()
  ];

  @override
  Future<void> onInit() async {
    var categoryDao = Get.find<CategoryListDao>();
    var productDao = Get.find<ProductListDao>();
    var homeDao = Get.find<HomeDao>();
    //reset semua list
    paymentTypeController.clear();
    specificPaymentDetail.clear();
    allPaymentDetail.clear();
    for (var e in paymentDetailController) {
      e.clear();
    }
    tax.value = Preferences.getInstance().getInt(SharedPreferenceKey.TAX) ?? 0;
    sales.value = await homeDao.getFinanceSales();
    expenditure.value = await homeDao.getFinanceExpenditure();
    var result = await homeDao.getTodayTransaction();
    todayTransaction.value = result.first as int;
    todaySoldProducts.value = result.last as int;
    categoryList = await categoryDao.getCategoryList();
    productList = await productDao.getAllProducts();
    checkEmptyCategory();
    paymentTypeList.value = await homeDao.getAllPaymentType();
    //set initial payment yang dipilih menjadi paymenttypelist yang pertama
    selectedPaymentType = paymentTypeList.first.obs;
    allPaymentDetail.value = await homeDao.getAllPaymentDetail();
    specificPaymentDetail.value = await homeDao
        .getPaymentDetailUsingPaymentType(selectedPaymentType.value);
    //jika paymentdetaillist tidak kosong set initial payment yang dipilih menjadi paymentdetaillist yang pertama
    if (specificPaymentDetail.isNotEmpty) {
      selectedPaymentDetail = specificPaymentDetail.first.obs;
    } else {
      selectedPaymentDetail.value = null;
    }
    //manipulasi data prediksi
    var prediction = await homeDao.manipulateData();
    if (prediction["data"] != null) {
      //hit api prediksi
      predictionImage.value =
          await ApiManager.getPrediction(prediction: prediction);
      //jika kosong maka tidak ada internet
      if (predictionImage.value!.isEmpty) {
        noInternet.value = true;
      }
    } else {
      //jika kosong maka tidak bisa melakukan prediksi
      canPredict.value = false;
    }

    var prefs = Preferences.getInstance();
    await prefs.reload();
    //initialize profil toko
    storeName.value = prefs.getString(SharedPreferenceKey.STORE_NAME) ?? '';
    phoneNumber.value = prefs.getString(SharedPreferenceKey.PHONE_NUMBER) ?? '';
    address.value = prefs.getString(SharedPreferenceKey.STORE_ADDRESS) ?? '';
    description.value = prefs.getString(SharedPreferenceKey.DESCRIPTION) ?? '';
    super.onInit();
  }

  ///Menghitung total
  void countTotal(List<ProductModel> products) {
    double total = 0;
    for (var e in products) {
      if (isOrder.value) {
        total += e.sellingPrice * e.quantity.value;
      } else {
        total += e.price * e.quantity.value;
      }
    }
    taxTotal.value = total * (tax / 100);
    totalAmount.value = total;
  }

  ///Dipanggil ketika mengganti tax di halaman profil
  void setTax(int newTax) {
    Preferences.getInstance().setInt(SharedPreferenceKey.TAX, newTax);
    tax.value = newTax;
  }

  ///Dipanggil ketika user menambahkan payment type/detail baru
  Future<void> initPayments() async {
    paymentTypeController.clear();
    specificPaymentDetail.clear();
    allPaymentDetail.clear();
    for (var e in paymentDetailController) {
      e.clear();
    }
    var homeDao = Get.find<HomeDao>();
    paymentTypeList.value = await homeDao.getAllPaymentType();
    specificPaymentDetail.value = await homeDao
        .getPaymentDetailUsingPaymentType(selectedPaymentType.value);
    allPaymentDetail.value = await homeDao.getAllPaymentDetail();
  }

  ///Dipanggil ketika user mengubah tipe pembayaran
  Future<void> reinitializeSelectedPaymentDetail() async {
    var homeDao = Get.find<HomeDao>();
    specificPaymentDetail.value = await homeDao
        .getPaymentDetailUsingPaymentType(selectedPaymentType.value);
    if (specificPaymentDetail.isNotEmpty) {
      selectedPaymentDetail = specificPaymentDetail.first.obs;
    } else {
      selectedPaymentDetail.value = null;
    }
  }

  Future<PaymentTypeModel> getPaymentDetailUsingId(
      PaymentDetailModel paymentDetail) async {
    var homeDao = Get.find<HomeDao>();
    return await homeDao.getPaymentTypeUsingPaymentDetailId(paymentDetail);
  }

  Future<void> insertPaymentType() async {
    var homeDao = Get.find<HomeDao>();
    await homeDao.insertPaymentType(
        PaymentTypeModel(paymentName: paymentTypeController.text));
    Get.back();
  }

  Future<void> insertPaymentDetail(PaymentTypeModel paymentType) async {
    var homeDao = Get.find<HomeDao>();
    await homeDao.insertPaymentDetail(PaymentDetailModel(
        paymentTypeId: paymentType.id,
        description: paymentDetailController[0].text));
    Get.back();
  }

  Future<void> deletePaymentDetail(PaymentDetailModel paymentDetail) async {
    var homeDao = Get.find<HomeDao>();
    await homeDao.deletePaymentDetail(paymentDetail);
    Get.back();
  }

  Future<bool?> deletePaymentType(PaymentTypeModel paymentType) async {
    var homeDao = Get.find<HomeDao>();
    var isDeleted = await homeDao.deletePaymentType(paymentType);
    if (isDeleted != null) {
      if (isDeleted) {
        Get.back();
        return true;
      } else {
        Get.snackbar('Error', 'Payment type can\'t be empty',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return false;
      }
    } else {
      //todo(dhanis) error karena masih ada payment detail
      Get.snackbar(
          'Cannot delete payment type!', 'payment type is already in use',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> editPaymentDetail(PaymentDetailModel paymentDetail) async {
    var homeDao = Get.find<HomeDao>();
    await homeDao.editPaymentDetail(paymentDetail);
    Get.back();
  }

  Future<void> editPaymentType(PaymentTypeModel paymentType) async {
    var homeDao = Get.find<HomeDao>();
    await homeDao.editPaymentType(paymentType);
    Get.back();
  }

  ///untuk mengecek category yg empty, jika empty maka hapus dari list
  void checkEmptyCategory() {
    List<int> needToRemoved = [];
    int i = 0;
    for (var e in categoryList) {
      bool remove = true;
      for (var f in productList) {
        if (e.id == f.productCategoryId) {
          remove = false;
          break;
        }
      }
      if (remove) {
        needToRemoved.add(i);
      }
      i++;
    }
    needToRemoved.sort(
      (a, b) => b.compareTo(a),
    );
    for (var e in needToRemoved) {
      categoryList.removeAt(e);
    }
  }

  Future<String> generateInvoiceNumber() async {
    await Preferences.getInstance().reload();
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    var lastReset = Preferences.getInstance()
        .getString(SharedPreferenceKey.INVOICE_DAY_RESET);
    DateTime lastResetDate;
    if (lastReset == null) {
      Preferences.getInstance().setString(SharedPreferenceKey.INVOICE_DAY_RESET,
          DateFormat('yyyy-MM-dd').format(todayStart));
      lastResetDate = todayStart;
    } else {
      lastResetDate = DateTime.parse(lastReset);
    }
    final bool isNewDay = lastResetDate.millisecondsSinceEpoch <
        todayStart.millisecondsSinceEpoch;

    int counter = 1;
    // Reset the counter if it's a new day
    if (!isNewDay) {
      var prefsCounter =
          Preferences.getInstance().getInt(SharedPreferenceKey.INVOICE_COUNTER);
      if (prefsCounter != null) {
        counter = prefsCounter;
      } else {
        Preferences.getInstance()
            .setInt(SharedPreferenceKey.INVOICE_COUNTER, 1);
      }
    } else {
      Preferences.getInstance().setInt(SharedPreferenceKey.INVOICE_COUNTER, 1);
    }

    String transactionType = isOrder.value ? 'O' : 'S';

    // Generate the invoice number
    final invoiceNumber =
        'C$transactionType-${now.day.toString().padLeft(2, '0')}${now.month.toString().padLeft(2, '0')}${now.year.toString().substring(2)}-${counter.toString().padLeft(4, '0')}';
    Preferences.getInstance()
        .setInt(SharedPreferenceKey.INVOICE_COUNTER, counter += 1);
    return invoiceNumber;
  }

  void clearAllItems() {
    for (var e in productList) {
      if (e.quantity.value > 0) {
        e.quantity.value = 0;
      }
    }
  }

  Future<void> insertTransaction(PageController pageController) async {
    try {
      var homeDao = Get.find<HomeDao>();
      await homeDao.insertTransaction(
          TransactionModel(
              paymentTypeId: selectedPaymentType.value.id,
              paymentDetailId: selectedPaymentDetail.value?.id,
              invoice: await generateInvoiceNumber(),
              dates: DateFormat(DateTimeFormat.standard).format(DateTime.now()),
              sales: totalAmount.value + taxTotal.value),
          productList.where((p0) => p0.quantity.value > 0).toList(),
          isOrder.value);

      clearAllItems();
      onInit();
      await pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> clearAllData() async {
    var prefs = Preferences.getInstance();
    prefs.clear();
    var homeDao = Get.find<HomeDao>();
    await homeDao.deleteAllTables();
    prefs.reload();
    Get.until((route) => route.isFirst);
    Get.delete<HomeLogic>();
    Get.off(() => RegisterPage(), binding: RegisterBinding());
  }
}
