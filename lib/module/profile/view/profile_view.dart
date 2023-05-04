import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/core.dart';
import '../controller/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  Widget build(context, ProfileController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: OldGet.width / 6,
                backgroundImage: NetworkImage(
                  "https://i.ibb.co/PGv8ZzG/me.jpg",
                ),
              ),
              Text(
                "Dhaniswaw",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                "email@email.com",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "programmer",
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  title: const Text("Settings"),
                  subtitle: const Text("App Settings"),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text("Tos"),
                  subtitle: const Text("Terms of service"),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text("Privacy Policy"),
                  subtitle: const Text("-"),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}
