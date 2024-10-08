import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/kriteria/kriteria_bloc.dart';
import 'package:kinerja_app/models/kriteria_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/kriteria/kriteria_page.dart';

class KriteriaFormAdd extends StatelessWidget {
  final kriteriController = TextEditingController(text: '');

  KriteriaFormAdd({super.key});

  bool validate() {
    if (kriteriController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Kriteria Add'),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<KriteriaBloc>().add(KriteriaGet());
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<KriteriaBloc, KriteriaState>(
        listener: (context, state) {
          if (state is KriteriaAddSuccess) {
            context.read<KriteriaBloc>().add(KriteriaGet());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => KriteriaPage()));
            showCustomSnackBar(context, 'Kriteria Success ditambahkan');
          }

          if (state is KriteriaFailed) {
            showCustomSnackBar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is KriteriaLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  color: whiteColor,
                  child: const Text('Form Kriteria',
                      style: TextStyle(fontSize: 25)),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                          spreadRadius: 1,
                          blurStyle: BlurStyle.normal,
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: kriteriController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          labelText: 'Nama Kriteria',
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 50,
                        width: 240,
                        child: TextButton(
                          onPressed: () {
                            if (!validate()) {
                              showCustomSnackBar(
                                  context, 'Kriteria Tidak Boleh Kosong');
                            } else {
                              context.read<KriteriaBloc>().add(KriteriaAdd(
                                  KriteriaFormModel(
                                      nama: kriteriController.text)));
                            }
                          },
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(56)),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
