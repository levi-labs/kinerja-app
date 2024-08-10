import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/indikator/indikator_bloc.dart';
import 'package:kinerja_app/blocs/kriteria/kriteria_bloc.dart';
import 'package:kinerja_app/models/indikator_form_model.dart';
import 'package:kinerja_app/models/kriteria_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/indikator/indikator_group.dart';

class IndikatorAddPage extends StatefulWidget {
  const IndikatorAddPage({super.key});

  @override
  State<IndikatorAddPage> createState() => _IndikatorAddPageState();
}

class _IndikatorAddPageState extends State<IndikatorAddPage> {
  List<KriteriaFormModel> kriterias = [];
  TextEditingController kriteriaController = TextEditingController(text: '');
  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController bobotController = TextEditingController(text: '');
  TextEditingController nilaiController = TextEditingController(text: '');
  String? selectedKriteria;

  bool validate() {
    if (kriteriaController.text.isEmpty ||
        namaController.text.isEmpty ||
        bobotController.text.isEmpty ||
        nilaiController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Indikator'),
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<IndikatorBloc>().add(GetEventIndikator());
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocConsumer<IndikatorBloc, IndikatorState>(
          listener: (context, state) {
            if (state is IndikatorStateFailed) {
              showCustomSnackBar(context, state.e);
            }
            if (state is IndikatorStateAdded) {
              context.read<IndikatorBloc>().add(GetEventIndikatorByKriteria(
                  int.parse(selectedKriteria.toString())));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IndikatorGroup(
                            idKriteria: int.parse(selectedKriteria.toString()),
                          )));
              showCustomSnackBar(context, 'Indikator Success Added');
            }
          },
          builder: (context, state) {
            return Stack(
              alignment: Alignment.topLeft,
              children: [
                const SizedBox(
                  height: 20,
                ),
                ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      color: whiteColor,
                      child: const Text('Form Indikator',
                          style: TextStyle(fontSize: 25)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 25, bottom: 25, left: 10, right: 10),
                      width: 600,
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
                          BlocConsumer<KriteriaBloc, KriteriaState>(
                            listener: (context, state) {
                              if (state is KriteriaFailed) {
                                showCustomSnackBar(context, state.e);
                              }
                            },
                            builder: (context, state) {
                              if (state is KriteriaLoaded) {
                                kriterias = state.kriteria;
                              }

                              return DropdownMenu(
                                width: 360,
                                label: Text('Pilih Kriteria',
                                    style: TextStyle(
                                      color: darkColor,
                                      fontSize: 16,
                                    )),
                                onSelected: (value) {
                                  if (value != null) {
                                    selectedKriteria = value;
                                    kriteriaController.text = value;
                                  }
                                },
                                inputDecorationTheme: InputDecorationTheme(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: darkColor,
                                    fontSize: 16,
                                  ),
                                ),
                                dropdownMenuEntries: kriterias
                                    .map((e) => DropdownMenuEntry(
                                          value: e.id.toString(),
                                          label: e.nama.toString(),
                                        ))
                                    .toList(),
                              );
                            },
                          ),
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
                              labelText: 'Nama Indikator',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: bobotController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              labelText: 'Bobot Indikator',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: nilaiController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              labelText: 'Nilai Pembanding',
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 240,
                      child: TextButton(
                        onPressed: () {
                          if (!validate()) {
                            showCustomSnackBar(
                                context, 'Field Tidak Boleh Kosong');
                          } else {
                            // print([
                            //   selectedKriteria,
                            //   namaController.text,
                            //   bobotController.text,
                            //   nilaiController.text
                            // ]);
                            context.read<IndikatorBloc>().add(AddEventIndikator(
                                IndikatorFormModel(
                                    kriteriaId:
                                        int.parse(selectedKriteria.toString()),
                                    nama: namaController.text,
                                    bobot: bobotController.text,
                                    nilaiPembanding: nilaiController.text)));
                          }
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
                )
                // Container(
                //   color: primaryColor,
                //   // margin: EdgeInsets.only(top: 50),
                // ),
              ],
            );
          },
        ));
  }
}
