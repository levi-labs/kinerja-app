import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/pegawai/pegawai_bloc.dart';
import 'package:kinerja_app/models/pegawai_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';

class PegawaiEditPage extends StatefulWidget {
  PegawaiEditPage({super.key});

  @override
  State<PegawaiEditPage> createState() => _PegawaiEditPageState();
}

class _PegawaiEditPageState extends State<PegawaiEditPage> {
  final namalengkapController = TextEditingController(text: '');

  final emailController = TextEditingController(text: '');

  final nohpController = TextEditingController(text: '');

  final alamatController = TextEditingController(text: '');

  final nipController = TextEditingController(text: '');

  final jabatanController = TextEditingController(text: '');

  List<Map<String, dynamic>> jabatan = [
    {
      'id': '0',
      'value': 'Accounting',
    },
    {
      'id': '1',
      'value': 'Human',
    },
    {
      'id': '2',
      'value': 'Marketing',
    }
  ];

  bool validateEmail() {
    final bool isValidEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);

    if (!isValidEmail) {
      return false;
    }

    return true;
  }

  bool validate() {
    if (namalengkapController.text.isEmpty ||
        emailController.text.isEmpty ||
        nohpController.text.isEmpty ||
        alamatController.text.isEmpty ||
        nipController.text.isEmpty ||
        jabatanController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pegawai'),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<PegawaiBloc>().add(PegawaiLoadedEvent());
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<PegawaiBloc, PegawaiState>(
        listener: (context, state) {
          if (state is PegawaiErrorState) {
            showCustomSnackBar(context, state.error);
          }
          if (state is PegawaiUpdatedSuccessState) {
            Navigator.pop(context);
            context.read<PegawaiBloc>().add(PegawaiLoadedEvent());
            showCustomSnackBar(context, 'Pegawai Success diupdate');
          }
        },
        builder: (context, state) {
          if (state is PegawaiGetByIdSuccessState) {
            namalengkapController.text = state.data.namaLengkap;
            emailController.text = state.data.email;
            nohpController.text = state.data.noHp;
            alamatController.text = state.data.alamat;
            nipController.text = state.data.nip;
            jabatanController.text = state.data.jabatan;

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
                      child: const Text('Form Pegawai',
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: namalengkapController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              labelText: 'Nama Pegawai',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: nipController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              labelText: 'Nomor Induk Pegawai',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: nohpController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              labelText: 'Nomor Handphone',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'Email',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp(r"[^a-zA-Z0-9@._-]")),
                              ]),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownMenu(
                            controller: jabatanController,
                            width: 360,
                            label: Text('Pilih Divisi',
                                style: TextStyle(
                                  color: darkColor,
                                  fontSize: 16,
                                )),
                            onSelected: (value) {
                              if (value != null &&
                                  value != jabatanController.text) {
                                jabatanController.text = value;
                              } else if (value == state.data.jabatan) {
                                jabatanController.text = state.data.jabatan;
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
                            dropdownMenuEntries: jabatan
                                .map((e) => DropdownMenuEntry(
                                      value: e['value'],
                                      label: e['value'],
                                    ))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: alamatController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              labelText: 'Alamat',
                            ),
                          ),
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
                            if (!validateEmail()) {
                              showCustomSnackBar(context, 'Email Tidak Valid');
                            } else {
                              context
                                  .read<PegawaiBloc>()
                                  .add(PegawaiUpdatedEvent(PegawaiFormModel(
                                    id: state.data.id,
                                    namaLengkap: namalengkapController.text,
                                    email: emailController.text,
                                    noHp: nohpController.text,
                                    alamat: alamatController.text,
                                    jabatan: jabatanController.text,
                                    nip: nipController.text,
                                  )));
                            }
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
                    ),
                  ],
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
