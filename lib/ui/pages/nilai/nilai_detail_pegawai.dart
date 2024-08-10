import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/nilai/nilai_bloc.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class NilaiDetailPage extends StatelessWidget {
  final String namaPegawai;
  final String skala;
  final String keterangan;
  final String totalNilai;
  String nilaiAkhir = '0';
  List data = [];
  NilaiDetailPage(
      {required this.namaPegawai,
      required this.keterangan,
      required this.skala,
      required this.totalNilai,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBar(),
        appBar: AppBar(
          title: const Text('Detail Nilai Pegawai'),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Colors.white, // Start color
                        primaryColor, // End color
                      ],
                    ),
                  ),
                  width: 400,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Skala Nilai Pegawai',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: primaryColor,
                            child: Text(
                              skala,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            namaPegawai,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<NilaiBloc, NilaiState>(
                  builder: (context, state) {
                    if (state is NilaiErrorState) {
                      showCustomSnackBar(context, state.e);
                    }
                    if (state is NilaiLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is NilaiLoadedDetailState) {
                      data = state.data[0].listNilai;
                      // final lastindex = data.length - 1;

                      // nilaiAkhir = data[lastindex].nilaiHasil;
                      // print(nilaiAkhir);
                    }
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                        color: whiteColor,
                      ),
                      width: 400,
                      height: 300,
                      child: Column(children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama Indikator',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('Nilai Indikator',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(data[index].indikator),
                                    trailing: Text(data[index].nilaiIndikator),
                                  ),
                                );
                              }),
                        ),
                      ]),
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocConsumer<NilaiBloc, NilaiState>(
                  listener: (context, state) {
                    if (state is NilaiErrorState) {
                      showCustomSnackBar(context, state.e);
                    }
                  },
                  builder: (context, state) {
                    if (state is NilaiLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is NilaiLoadedDetailState) {
                      data = state.data[0].listNilai;

                      // print(nilaiAkhir);
                    }
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              Colors.white, // Start color
                              primaryColor, // End color
                            ],
                          )),
                      width: 400,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Nilai Akhir : $totalNilai',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Keterangan $keterangan',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
