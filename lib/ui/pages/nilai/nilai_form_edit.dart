import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/nilai/nilai_bloc.dart';
import 'package:kinerja_app/models/indikator_form_model.dart';
import 'package:kinerja_app/models/nilai_form_detail_model.dart';

import 'package:kinerja_app/models/pegawai_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';

import 'package:kinerja_app/ui/widget/sidebar.dart';

class NilaiEditPage extends StatefulWidget {
  const NilaiEditPage({Key? key}) : super(key: key);

  @override
  State<NilaiEditPage> createState() => _NilaiEditPageState();
}

class _NilaiEditPageState extends State<NilaiEditPage> {
  List<IndikatorFormModel> listIndikator = [];

  List<PegawaiFormModel> listPegawai = [];
  List<NilaiDetailPegawai> listNilai = [];

  var _nilaiId = <int>[];
  var _nilaiInput = <TextEditingController>[];
  var _controllerId = <int>[];
  var tanggalNilaiController = TextEditingController(text: '');
  var namaPegawaiController = TextEditingController(text: '');

  TextEditingController idPegawaiController = TextEditingController(text: '');

  void _increment(int id) {
    _nilaiInput[id].text = (int.parse(_nilaiInput[id].text) + 1).toString();
  }

  void _decrement(int id) {
    int? currentValue = int.tryParse(_nilaiInput[id].text);
    if (currentValue != null) {
      if (currentValue > 0) {
        _nilaiInput[id].text = (currentValue - 1).toString();
      }
    } else {
      // Handle the case where the text is not a valid number
      print('Invalid number: ${_nilaiInput[id].text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Form Nilai Edit'),
        leading: IconButton(
          onPressed: () {
            context.read<NilaiBloc>().add(NilaiLoadedEvent());
            Navigator.popAndPushNamed(context, '/nilai');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<NilaiBloc, NilaiState>(
        listener: (context, state) {
          if (state is NilaiErrorState) {
            showCustomSnackBar(context, state.e);
            // print(state.e);
          }
          if (state is NilaiUpdateSuccessState) {
            context.read<NilaiBloc>().add(NilaiLoadedEvent());
            Navigator.popAndPushNamed(context, '/nilai');
            showCustomSnackBar(context, 'Data Nilai Berhasil Diupdate');
          }
        },
        builder: (context, state) {
          if (state is NilaiLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NilaiLoadedByIdPegawaiAndDateState) {
            listIndikator = state.data.indikator;
            listNilai = state.data.nilai;
            namaPegawaiController.text = state.data.pegawai.toString();
            // listPegawai = state.data.nilai;
            // tanggalNilaiController.text = state.data[0].tanggalNilai.toString();

            // print(tanggalNilaiController.text);
            if (listIndikator.isEmpty) {
              return const Center(
                  child: Text(
                      'Tidak Ada Indikator')); // Show message for empty list
            }

            if (listIndikator.isNotEmpty) {
              _nilaiInput = List.generate(
                  listIndikator.length,
                  (_) => TextEditingController(
                      text: listNilai[_].nilaiIndikator.toString()));

              _controllerId = List.generate(
                  listIndikator.length, (_) => listIndikator[_].id!);
              _nilaiId =
                  List.generate(listIndikator.length, (_) => listNilai[_].id);
            }
            // print(_controllerId);

            return Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    readOnly: true,
                    controller: namaPegawaiController,
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
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: listIndikator.length,
                    itemBuilder: (context, index) {
                      if (index < listIndikator.length) {
                        return SizedBox(
                          height: 150,
                          child: Card(
                            child: Center(
                              child: ListTile(
                                title: Text(listIndikator[index].nama),
                                subtitle: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(listIndikator[index]
                                          .kriteria!
                                          .nama
                                          .toString()),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Nilai Pembanding :  ${listIndikator[index].nilaiPembanding}'),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Bobot :  ${listIndikator[index].bobot}'),
                                    ],
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 200,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: ElevatedButton(
                                          onPressed: () => _increment(index),
                                          style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder()),
                                          child: const Icon(Icons.add),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: _nilaiInput[index],
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            _nilaiInput[index].text = value;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: ElevatedButton(
                                          onPressed: () => _decrement(index),
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                          ),
                                          child: const Icon(Icons.remove),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                ),
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
                const SizedBox(height: 100),
              ],
            );
          }
          return Container();
        },
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(24),
        width: 120,
        child: FloatingActionButton(
          onPressed: () {
            List<int> nilaiInputList =
                _nilaiInput.map((c) => int.parse(c.text)).toList();

            context.read<NilaiBloc>().add(NilaiUpdateDataEvent(
                  _controllerId,
                  _nilaiId,
                  nilaiInputList,
                ));
          },
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
