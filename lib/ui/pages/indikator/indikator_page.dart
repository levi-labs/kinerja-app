import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/indikator/indikator_bloc.dart';
import 'package:kinerja_app/blocs/kriteria/kriteria_bloc.dart';
import 'package:kinerja_app/models/kriteria_form_model.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/indikator/indikator_group.dart';
import 'package:kinerja_app/ui/widget/card_dashboard.dart';
import 'package:kinerja_app/ui/widget/floating_add_button.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class IndikatorPage extends StatefulWidget {
  const IndikatorPage({super.key});

  @override
  State<IndikatorPage> createState() => _IndikatorPageState();
}

class _IndikatorPageState extends State<IndikatorPage> {
  List<KriteriaFormModel> kriteria = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideBar(),
        appBar: AppBar(
          title: const Text('Indikator'),
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        body: BlocBuilder<KriteriaBloc, KriteriaState>(
          builder: (context, state) {
            if (state is IndikatorStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is KriteriaLoaded) {
              kriteria = state.kriteria;

              return Stack(
                children: [
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      childAspectRatio: 2 / 2.5,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: kriteria.length,
                    itemBuilder: (context, index) {
                      return Material(
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                            onTap: () {
                              context.read<IndikatorBloc>().add(
                                  GetEventIndikatorByKriteria(int.parse(
                                      kriteria[index].id.toString())));
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndikatorGroup(
                                    idKriteria: int.parse(
                                        kriteria[index].id.toString()),
                                  ),
                                ),
                                (route) => false, // Remove all previous routes
                              );
                            },
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
                                          // context.read<IndikatorBloc>().add(
                                          //       IndikatorDelete(int.parse(
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
                              margin: const EdgeInsets.all(20),
                              width: 60,
                              height: 200,
                              child: CardDashboard(
                                title: kriteria[index].nama.toString(),
                              ),
                            )),
                      );
                    },
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 100),
                  FloatingAddButton(
                    onPress: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/kriteria-add', (route) => true);
                    },
                  )
                ],
              );
            }

            return Container();
          },
        ));
  }
}
