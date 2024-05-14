import 'package:flutter/material.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: primaryColor,
      ),
      body: const Center(child: Text('Home Page')),
    );
  }
}
