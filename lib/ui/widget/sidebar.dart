import 'package:flutter/material.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/home_page.dart';
import 'package:kinerja_app/ui/pages/kriteria_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                onTap: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }), (route) => false);
                }),
            ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {}),
            ListTile(
                leading: const Icon(Icons.format_list_bulleted),
                title: const Text('Kriteria'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const KriteriaPage();
                  }), (route) => false);
                }),
            ListTile(
                leading: const Icon(Icons.point_of_sale),
                title: const Text('Indikator'),
                onTap: () {}),
            ListTile(
                leading: const Icon(Icons.scale),
                title: const Text('Skala'),
                onTap: () {}),
            ListTile(
                leading: const Icon(Icons.person_4),
                title: const Text('User'),
                onTap: () {}),
            ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Sign Out'),
                onTap: () {}),
          ],
        ));
  }
}
