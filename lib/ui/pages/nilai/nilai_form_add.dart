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

  var _controller = <TextEditingController>[];
  var _controllerId = <int>[];
  var tanggalNilaiController = TextEditingController(text: '');
  TextEditingController idPegawaiController = TextEditingController(text: '');

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
            // print(state.e);
          }
          if (state is NilaiCreateSuccessState) {
            Navigator.pop(context);
            context.read<NilaiBloc>().add(NilaiLoadedEvent());
            showCustomSnackBar(context, 'Data Nilai Berhasil');
          }
        },
        builder: (context, state) {
          if (state is NilaiLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NilaiShowByDateState) {
            listIndikator = state.data[0].indikator;
            listPegawai = state.data[0].pegawai;
            tanggalNilaiController.text = state.data[0].tanggalNilai.toString();

            // print(tanggalNilaiController.text);
            if (listIndikator.isEmpty) {
              return const Center(
                  child: Text(
                      'Tidak Ada Indikator')); // Show message for empty list
            }

            if (listIndikator.isNotEmpty) {
              _controller = List.generate(listIndikator.length,
                  (_) => TextEditingController(text: '0'));

              _controllerId = List.generate(
                  listIndikator.length, (_) => listIndikator[_].id!);
            }
            // print(_controllerId);

            return Column(
              children: [
                const SizedBox(height: 20),
                DropdownMenu(
                    width: 400,
                    label: const Text('Daftar Pegawai'),
                    onSelected: (value) {
                      idPegawaiController.text = value.toString();
                    },
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
            List<int> controllerValues =
                _controller.map((c) => int.parse(c.text)).toList();

            // print([idPegawaiController.text.to, _controllerId, controllerValues]);
            context.read<NilaiBloc>().add(NilaiCreateDataEvent(
                idPegawaiController.text.toString(),
                _controllerId,
                controllerValues,
                tanggalNilaiController.text.toString()));
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
