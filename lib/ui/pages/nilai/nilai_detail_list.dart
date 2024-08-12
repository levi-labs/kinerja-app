import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/auth/auth_bloc_bloc.dart';
import 'package:kinerja_app/blocs/nilai/nilai_bloc.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/auth/sign_in_page.dart';
import 'package:kinerja_app/ui/pages/nilai/nilai_detail_pegawai.dart';
import 'package:kinerja_app/ui/widget/floating_add_button.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class NilaiListByDate extends StatefulWidget {
  const NilaiListByDate({super.key});

  @override
  State<NilaiListByDate> createState() => _NilaiListByDateState();
}

class _NilaiListByDateState extends State<NilaiListByDate> {
  List data = [];
  String skala = '';
  String tanggalNilai = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Nilai'),
        backgroundColor: primaryColor,
      ),
      body: BlocBuilder<NilaiBloc, NilaiState>(
        builder: (context, state) {
          var x = context.read<AuthBloc>().state;
          if (x is AuthFailed) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SignInPage();
            }));
            showCustomSnackBar(context, x.e);
          }

          if (state is NilaiErrorState) {
            showCustomSnackBar(context, state.e);
          }
          if (state is NilaiLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NilaiDeleteSuccessState) {
            context.read<NilaiBloc>().add(
                NilaiShowByDateEvent(tanggalNilai.toString().substring(0, 7)));

            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomSnackBar(context, 'Nilai Success Deleted');
            });
          }

          if (state is NilaiLoadedByDateState) {
            data = state.data;
            // for (var i = 0; i < data.length; i++) {
            //   if (data.isNotEmpty) {
            //     if (data[i].totalNilai >= 86) {
            //       skala = 'A';
            //     } else if (data[i].totalNilai > 76 || data[i].totalNilai < 86) {
            //       skala = 'B';
            //     } else if (data[i].totalNilai > 61 ||
            //         data[i].totalNilai <= 76) {
            //       skala = 'C';
            //     } else if (data[i].totalNilai > 46 ||
            //         data[i].totalNilai <= 61) {
            //       skala = 'D';
            //     } else if (data[i].totalNilai > 0 || data[i].totalNilai <= 46) {
            //       skala = 'E';
            //     }
            //   }
            // }
            return Stack(
              children: [
                ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    tanggalNilai = data[index].tanggalNilai.toString();
                    return Material(
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          // context.read<NilaiBloc>().add(
                          //     NIlaiEditByIdAndDateEvent(
                          //         data[index].id.toString(),
                          //         data[index]
                          //             .tanggalNilai
                          //             .toString()
                          //             .substring(0, 7)));
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const NilaiEditPage(),
                          //   ),
                          //   (route) => true, // Remove all previous routes
                          // );

                          context.read<NilaiBloc>().add(
                                NilaiDetailByIdAndDateEvent(
                                  data[index].id.toString(),
                                  data[index]
                                      .tanggalNilai
                                      .toString()
                                      .substring(0, 7),
                                ),
                              );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NilaiDetailPage(
                                namaPegawai: data[index].namaLengkap.toString(),
                                skala: data[index].skala.toString(),
                                keterangan: data[index].keterangan.toString(),
                                totalNilai: data[index]
                                    .totalNilai
                                    .toString()
                                    .substring(0, 2),
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: const Text('Delete Kriteria'),
                                content: const Text(
                                    'Are you sure you want to delete this Kriteria?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      // Delete logic here
                                      // context.read<KriteriaBloc>().add(
                                      //       Nilai(int.parse(
                                      //         kriteria[index].id.toString(),
                                      //       )),
                                      //     );
                                      // Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10), // EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 0.2,
                                  offset: Offset(0, 2),
                                  blurStyle: BlurStyle.normal,
                                ),
                              ]),
                          height: 75,
                          width: double.infinity,
                          child: ListTile(
                            minVerticalPadding: 20,
                            leading: CircleAvatar(
                              backgroundColor: primaryColor,

                              radius:
                                  16, // Adjust the radius to change the size of the circle
                              child: Text(
                                data[index]
                                    .skala, // Replace 'A' with the desired alphabet
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Nama :  ${data[index].namaLengkap.toString()}',
                                style: TextStyle(
                                  color: darkColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            subtitle: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                ' Keterangan : ${data[index].keterangan.toString()}',
                                style: TextStyle(
                                  color: darkColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                // Delete logic here

                                context.read<NilaiBloc>().add(
                                      NilaiDeleteByIdAndDateEvent(
                                        data[index].id.toString(),
                                        data[index]
                                            .tanggalNilai
                                            .toString()
                                            .substring(0, 7),
                                      ),
                                    );
                              },
                              child: Icon(
                                Icons.delete,
                                color: greyColor,
                                shadows: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.2,
                                    offset: Offset(0, 2),
                                    blurStyle: BlurStyle.normal,
                                  ),
                                ],
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(height: 100),
                FloatingAddButton(
                  onPress: () {
                    context.read<NilaiBloc>().add(NilaiCreateByDateEvent(
                        data[0].tanggalNilai.toString()));
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/nilai-add', (route) => true);
                  },
                )
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
