import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/kriteria/kriteria_bloc.dart';
import 'package:kinerja_app/models/kriteria_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/kriteria_page.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class KriteriaEditPage extends StatefulWidget {
  final int kriteria;

  const KriteriaEditPage({required this.kriteria, super.key});

  @override
  State<KriteriaEditPage> createState() => _KriteriaEditPageState();
}

class _KriteriaEditPageState extends State<KriteriaEditPage> {
  final kriteriaController = TextEditingController(text: '');

  bool validate() {
    if (kriteriaController.text.isEmpty) {
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
      ),
      body: BlocConsumer<KriteriaBloc, KriteriaState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is KriteriaUpdateSuccess) {
            context.read<KriteriaBloc>().add(KriteriaGet());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const KriteriaPage()));
            showCustomSnackBar(context, 'Kriteria Success');
          }

          if (state is KriteriaFailed) {
            showCustomSnackBar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is KriteriaLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is KriteriaLoadedById) {
            kriteriaController.text = state.kriteria.nama!;
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        controller: kriteriaController,
                        decoration: InputDecoration(
                          // hintText: state.kriteria.nama,
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
                              context.read<KriteriaBloc>().add(KriteriaUpdate(
                                    KriteriaFormModel(
                                      id: widget.kriteria,
                                      nama: kriteriaController.text,
                                    ),
                                  ));
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
