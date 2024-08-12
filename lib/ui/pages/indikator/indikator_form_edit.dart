import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/indikator/indikator_bloc.dart';
import 'package:kinerja_app/blocs/kriteria/kriteria_bloc.dart';
import 'package:kinerja_app/models/indikator_form_model.dart';
import 'package:kinerja_app/models/kriteria_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/indikator/indikator_group.dart';

class IndikatorEditPage extends StatefulWidget {
  const IndikatorEditPage({super.key});

  @override
  State<IndikatorEditPage> createState() => _IndikatorEditPageState();
}

class _IndikatorEditPageState extends State<IndikatorEditPage> {
  late List<KriteriaFormModel> kriterias = [];
  late IndikatorFormModel indikator;
  late String idIndikator;
  TextEditingController kriteriaController = TextEditingController(text: '');
  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController bobotController = TextEditingController(text: '');
  TextEditingController nilaiController = TextEditingController(text: '');
  Map<String, dynamic> data = {};
  KriteriaFormModel? selectedKriteria;

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
          title: const Text('Edit Indikator'),
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
            if (state is IndikatorStateUpdated) {
              context.read<IndikatorBloc>().add(GetEventIndikatorByKriteria(
                  int.parse(kriteriaController.text.toString())));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IndikatorGroup(
                            idKriteria: int.parse(kriteriaController.text),
                          )));
              // context.read<IndikatorBloc>().add(GetEventIndikatorByKriteria(
              //     int.parse(selectedKriteria.toString())));

              showCustomSnackBar(context, 'Indikator Success diupdate');
            }
          },
          builder: (context, state) {
            if (state is IndikatorStateLoadedById) {
              indikator = state.indikator;
              idIndikator = indikator.id.toString();
              kriteriaController.text = indikator.kriteriaId.toString();
              namaController.text = indikator.nama;
              bobotController.text = indikator.bobot.toString();
              nilaiController.text = indikator.nilaiPembanding.toString();
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
                                // TODO: implement listener
                                if (state is KriteriaFailed) {
                                  showCustomSnackBar(context, state.e);
                                }
                              },
                              builder: (context, state) {
                                if (state is KriteriaLoaded) {
                                  kriterias = state.kriteria;

                                  return DropdownMenu(
                                    label: const Text(
                                      'Pilih Kriteria',
                                    ),
                                    width: 360,
                                    initialSelection: kriteriaController.text,
                                    inputDecorationTheme:
                                        const InputDecorationTheme(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    onSelected: (value) {
                                      kriteriaController.text =
                                          value.toString();
                                    },
                                    dropdownMenuEntries: kriterias
                                        .map((e) => DropdownMenuEntry(
                                            value: e.id.toString(),
                                            label: e.nama.toString()))
                                        .toList(),
                                  );
                                }
                                return const DropdownMenu(
                                  dropdownMenuEntries: [],
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
                              print([
                                idIndikator.toString(),
                                kriteriaController.text,
                                namaController.text,
                                bobotController.text,
                                nilaiController.text
                              ]);
                              context.read<IndikatorBloc>().add(
                                  UpdateEventIndikator(IndikatorFormModel(
                                      id: int.parse(idIndikator.toString()),
                                      kriteriaId: int.parse(kriteriaController
                                          .text), // kriteriaController.text,
                                      nama: namaController.text,
                                      bobot: bobotController.text,
                                      nilaiPembanding: nilaiController.text)));
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
                  )
                  // Container(
                  //   color: primaryColor,
                  //   // margin: EdgeInsets.only(top: 50),
                  // ),
                ],
              );
            }

            return Container();
          },
        ));
  }
}
