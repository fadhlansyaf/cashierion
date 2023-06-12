import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_app_skripsi/core.dart';

import '../../../api/api_manager.dart';
import '../../../model/database/database_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/preferences.dart';
import '../../category_list/controller/category_list_dao.dart';
import '../../product_list/controller/product_list_dao.dart';

class HomeLogic extends GetxController {
  var selectedIndex = 0.obs;
  var categoryList = <CategoryModel>[].obs;
  var productList = <ProductModel>[].obs;
  late Rx<PaymentTypeModel> selectedPaymentType;
  var paymentType = <PaymentTypeModel>[].obs;
  Rx<PaymentDetailModel?> selectedPaymentDetail = Rx<PaymentDetailModel?>(null);
  var specificPaymentDetail = <PaymentDetailModel>[].obs;
  var allPaymentDetail = <PaymentDetailModel>[].obs;
  var tax = 0.obs;
  var taxTotal = 0.0.obs;
  var isOrder = true.obs;
  var totalAmount = 0.0.obs;
  var pageIndex = 0.obs;
  Rx<Uint8List?> predictionImage = Rx<Uint8List?>(null);
  var canPredict = true.obs;

  //variabel untuk bottomsheet
  ///Panggil jika butuh setstate pada bottomsheet
  Rx<StateSetter?> setStatePaymentType = Rx<StateSetter?>(null);
  Rx<StateSetter?> setStatePaymentDetail = Rx<StateSetter?>(null);

  final paymentTypeController = TextEditingController();
  final paymentDetailController = [TextEditingController(), TextEditingController()];
  // final paymentDetailController = TextEditingController();


  @override
  Future<void> onInit() async {
    var categoryDao = Get.find<CategoryListDao>();
    var productDao = Get.find<ProductListDao>();
    var homeDao = Get.find<HomeDao>();
    paymentTypeController.clear();
    specificPaymentDetail.clear();
    allPaymentDetail.clear();
    for(var e in paymentDetailController){
      e.clear();
    }
    tax.value = Preferences.getInstance().getInt(SharedPreferenceKey.TAX) ?? 0;
    categoryList = await categoryDao.getCategoryList();
    productList = await productDao.getAllProducts();
    checkEmptyCategory();
    paymentType.value = await homeDao.getAllPaymentType();
    selectedPaymentType = paymentType.first.obs;
    allPaymentDetail.value = await homeDao.getAllPaymentDetail();
    specificPaymentDetail.value = await homeDao.getPaymentDetailUsingPaymentType(selectedPaymentType.value);
    if (specificPaymentDetail.isNotEmpty) {
      selectedPaymentDetail = specificPaymentDetail.first.obs;
    }
    var prediction = await homeDao.manipulateData();
    if(prediction["data"] != null) {
      predictionImage.value =
          await ApiManager.getPrediction(prediction: prediction);
    }else{
      //TODO(dhanis): kasih note buat user kalo ga bisa predict (data belum 30 hari), notenya tampilin di ui prediction aja
      canPredict.value = false;
    }
    super.onInit();
  }

  void countTotal(List<ProductModel> products) {
    double total = 0;
    for (var e in products) {
      if (isOrder.value) {
        total += e.sellingPrice * e.quantity.value;
      }else{
        total += e.price * e.quantity.value;
      }
    }
    taxTotal.value = total * (tax/100);
    totalAmount.value = total;
  }

  ///Dipanggil ketika user menambahkan payment type/detail baru
  Future<void> initPayments() async {
    paymentTypeController.clear();
    specificPaymentDetail.clear();
    allPaymentDetail.clear();
    for(var e in paymentDetailController){
      e.clear();
    }
    var homeDao = Get.find<HomeDao>();
    paymentType.value = await homeDao.getAllPaymentType();
    specificPaymentDetail.value = await homeDao.getPaymentDetailUsingPaymentType(selectedPaymentType.value);
    allPaymentDetail.value = await homeDao.getAllPaymentDetail();
  }

  ///Dipanggil ketika user mengubah tipe pembayaran
  Future<void> reinitializeSelectedPaymentDetail() async {
    var homeDao = Get.find<HomeDao>();
    specificPaymentDetail = await homeDao.getPaymentDetailUsingPaymentType(selectedPaymentType.value);
    if (specificPaymentDetail.isNotEmpty) {
      selectedPaymentDetail = specificPaymentDetail.first.obs;
    }
  }

  Future<PaymentTypeModel> getPaymentDetailUsingId(PaymentDetailModel paymentDetail) async {
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
        paymentTypeId: paymentType.id, description: paymentDetailController[0].text));
    Get.back();
  }

  Future<void> deletePaymentDetail(PaymentDetailModel paymentDetail) async {
    var homeDao = Get.find<HomeDao>();
    await homeDao.deletePaymentDetail(paymentDetail);
    Get.back();
  }

  Future<void> deletePaymentType(PaymentTypeModel paymentType) async {
    var homeDao = Get.find<HomeDao>();
    await homeDao.deletePaymentType(paymentType);
    Get.back();
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

  //untuk mengecek category yg empty
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

  Future<String> generateInvoiceNumber()  async {
    await Preferences.getInstance().reload();
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    var lastReset = Preferences.getInstance()
        .getString(SharedPreferenceKey.INVOICE_DAY_RESET);
    DateTime lastResetDate;
    if(lastReset == null){
      Preferences.getInstance().setString(SharedPreferenceKey.INVOICE_DAY_RESET, DateFormat('yyyy-MM-dd').format(todayStart));
      lastResetDate = todayStart;
    }else{
      lastResetDate = DateTime.parse(lastReset);
    }
    final bool isNewDay =
        lastResetDate.millisecondsSinceEpoch < todayStart.millisecondsSinceEpoch;

    int counter = 1;
    // Reset the counter if it's a new day
    if (!isNewDay) {
      var prefsCounter = Preferences.getInstance().getInt(SharedPreferenceKey.INVOICE_COUNTER);
      if(prefsCounter != null){
        counter = prefsCounter;
      }else{
        Preferences.getInstance().setInt(SharedPreferenceKey.INVOICE_COUNTER, 1);
      }
    }else{
      Preferences.getInstance().setInt(SharedPreferenceKey.INVOICE_COUNTER, 1);
    }

    String transactionType = isOrder.value ? 'O' : 'S';

    // Generate the invoice number
    final invoiceNumber =
        'C$transactionType-${now.day.toString().padLeft(2, '0')}${now.month.toString().padLeft(2, '0')}${now.year.toString().substring(2)}-${counter.toString().padLeft(4, '0')}';
    Preferences.getInstance().setInt(SharedPreferenceKey.INVOICE_COUNTER, counter+=1);
    return invoiceNumber;
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
              sales: totalAmount.value),
          productList.where((p0) => p0.quantity.value > 0).toList(), isOrder.value);

      for(var e in productList){
        if(e.quantity.value > 0){
          e.quantity.value = 0;
        }
      }
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
}
