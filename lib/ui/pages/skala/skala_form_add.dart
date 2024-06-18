import 'package:flutter/material.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/skala/skala_page.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class SkalaAddPage extends StatelessWidget {
  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController intervalController = TextEditingController(text: '');
  TextEditingController keteranganController = TextEditingController(text: '');

  SkalaAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Add Skala'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SkalaPage()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 25, left: 10, right: 10),
              width: double.infinity,
              height: 350,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 114, 110, 110),
                    blurRadius: 0.1,
                    offset: Offset(0, 2),
                    blurStyle: BlurStyle.normal,
                  )
                ],
                color: whiteColor,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: namaController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      labelText: 'Nama Skala',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: intervalController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      labelText: 'Interval Skala',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: keteranganController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      labelText: 'Keterangan',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 350,
            child: TextButton(
              onPressed: () {
                showCustomSnackBar(context, 'Field Tidak Boleh Kosong');
              },
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(56)),
                ),
                backgroundColor: primaryColor,
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
