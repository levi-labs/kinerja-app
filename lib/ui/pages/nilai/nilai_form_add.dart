import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/nilai/nilai_bloc.dart';
import 'package:kinerja_app/models/indikator_form_model.dart';

import 'package:kinerja_app/models/pegawai_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';

import 'package:kinerja_app/ui/widget/sidebar.dart';

class NilaiAddPage extends StatefulWidget {
  const NilaiAddPage({Key? key}) : super(key: key);

  @override
  State<NilaiAddPage> createState() => _NilaiAddPageState();
}

class _NilaiAddPageState extends State<NilaiAddPage> {
  List<IndikatorFormModel> listIndikator = [];

  List<PegawaiFormModel> listPegawai = [];
  List<TextEditingController> listController = [];

  var _controller = <TextEditingController>[];

  TextEditingController namaController = TextEditingController(text: '');

  TextEditingController intervalController = TextEditingController(text: '');

  TextEditingController keteranganController = TextEditingController(text: '');

  void _increment(int id) {
    _controller[id].text = (int.parse(_controller[id].text) + 1).toString();
  }

  void _decrement(int id) {
    int? currentValue = int.tryParse(_controller[id].text);
    if (currentValue != null) {
      if (currentValue > 0) {
        _controller[id].text = (currentValue - 1).toString();
      }
    } else {
      // Handle the case where the text is not a valid number
      print('Invalid number: ${_controller[id].text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBar(),
        appBar: AppBar(
          title: const Text('Form Nilai'),
          leading: IconButton(
            onPressed: () {
              context.read<NilaiBloc>().add(NilaiLoadedEvent());
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: BlocConsumer<NilaiBloc, NilaiState>(
          listener: (context, state) {
            if (state is NilaiErrorState) {
              showCustomSnackBar(context, state.e);
            }
          },
          builder: (context, state) {
            if (state is NilaiLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NilaiShowByDateState) {
              listIndikator = state.data[0].indikator;
              listPegawai = state.data[0].pegawai;
              if (listIndikator.isEmpty) {
                return const Center(
                    child: Text(
                        'Tidak Ada Indikator')); // Show message for empty list
              }
              // if (listIndikator.isNotEmpty) {
              //   listController = List.generate(
              //       listIndikator.length, (_) => TextEditingController());
              // }
              // if (_controller.isEmpty) {
              //   _controller = List.generate(
              //       listIndikator.length, (_) => TextEditingController());
              // }
              if (_controller.length != listIndikator.length) {
                _controller = List.generate(listIndikator.length,
                    (_) => TextEditingController(text: '0'));
              }

              return Column(children: [
                const SizedBox(height: 20),
                DropdownMenu(
                    width: 400,
                    label: const Text('Daftar Pegawai'),
                    dropdownMenuEntries: listPegawai
                        .map((e) => DropdownMenuEntry(
                            value: e.id.toString(), label: e.namaLengkap))
                        .toList()),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: listIndikator.length,
                    itemBuilder: (context, index) {
                      if (index < listIndikator.length) {
                        return Card(
                          child: ListTile(
                            title: Text(listIndikator[index].nama),
                            subtitle: Text(
                                listIndikator[index].kriteria!.nama.toString()),
                            trailing: SizedBox(
                              width: 200,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _increment(index),
                                    child: const Icon(Icons.add),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _controller[index],
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        _controller[index].text = value;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () => _decrement(index),
                                    child: const Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        // Handle the case where the index is out of range
                        return Container(); // Or any appropriate widget or behavior
                      }
                    },
                  ),
                ),
              ]);
            }
            return Container();
          },
        ));
  }
}
