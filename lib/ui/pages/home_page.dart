import 'package:flutter/material.dart';
import 'package:kinerja_app/shared/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          backgroundColor: secondaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                accountName: const Text(
                  'Lucius Levi',
                  style: TextStyle(fontSize: 20),
                ),
                accountEmail: const Text('lucius@ocbc',
                    style: TextStyle(
                      fontSize: 15,
                    )),
                currentAccountPicture: CircleAvatar(
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      child: Image.asset('assets/image_ocbc.png')),
                ),
              ),
              ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {}),
              ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {}),
            ],
          )),
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: primaryColor,
      ),
      body: const Center(child: Text('Home Page')),
    );
  }
}
