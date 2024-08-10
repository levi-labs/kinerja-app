import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/skala/skala_bloc.dart';
import 'package:kinerja_app/models/skala_from_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class SkalaEditPage extends StatelessWidget {
  final String id;
  final TextEditingController namaController = TextEditingController(text: '');
  final TextEditingController intervalController =
      TextEditingController(text: '');
  final TextEditingController keteranganController =
      TextEditingController(text: '');

  SkalaEditPage({required this.id, super.key});
  bool validate() {
    if (namaController.text.isEmpty ||
        intervalController.text.isEmpty ||
        keteranganController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Edit Skala'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<SkalaBloc, SkalaState>(
        listener: (context, state) {
          if (state is SkalaStateError) {
            showCustomSnackBar(context, state.e);
          }
          if (state is SkalaStateUpdated) {
            context.read<SkalaBloc>().add(SkalaEventGet());
            Navigator.pop(context);
            showCustomSnackBar(context, 'Skala Success Updated');
          }
        },
        builder: (context, state) {
          if (state is SkalaStateGetById) {
            namaController.text = state.data.nama;
            intervalController.text = state.data.interval;
            keteranganController.text = state.data.keterangan;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                color: whiteColor,
                child: const Text('Form Skala', style: TextStyle(fontSize: 25)),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 10, left: 10, right: 10),
                  width: double.infinity,
                  height: 300,
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
              Center(
                child: SizedBox(
                  height: 50,
                  width: 350,
                  child: TextButton(
                    onPressed: () {
                      if (!validate()) {
                        showCustomSnackBar(
                            context, 'Semua field harus diisi terlebih dahulu');
                        return;
                      }
                      context
                          .read<SkalaBloc>()
                          .add(SkalaEventUpdate(SkalaFormModel(
                            id: int.parse(id),
                            nama: namaController.text,
                            interval: intervalController.text,
                            keterangan: keteranganController.text,
                          )));
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
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
