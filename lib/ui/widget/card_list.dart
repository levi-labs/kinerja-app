import 'package:flutter/material.dart';
import 'package:kinerja_app/blocs/nilai/nilai_bloc.dart';
import 'package:kinerja_app/models/nilai_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.data,
  });

  final List<NilaiFormModel> data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Material(
              color: Colors.grey,
              child: InkWell(
                onTap: () {
                  // showCustomSnackBar(context,
                  //     data[index].tanggalNilai.toString().substring(0, 10));
                  // Navigator.pushNamed(context, '/detail-nilai',
                  //     arguments: data[index]);

                  context.read<NilaiBloc>().add(NilaiCreateByDateEvent(
                      data[index].tanggalNilai.toString().substring(0, 10)));
                  // context.read<NilaiBloc>().add(NilaiCreateByDateEvent(
                  //     data[index].tanggalNilai.toString().substring(0, 10)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.5,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 101, 170, 244),
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          data[index].tanggalNilai.toString().substring(8, 10),
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(data[index].tanggalNilai.toString().substring(0, 10),
                          style: TextStyle(
                              color: darkColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ));
        });
  }
}
