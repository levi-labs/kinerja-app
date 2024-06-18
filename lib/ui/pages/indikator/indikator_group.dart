import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/indikator/indikator_bloc.dart';
import 'package:kinerja_app/blocs/kriteria/kriteria_bloc.dart';
import 'package:kinerja_app/models/indikator_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/indikator/indikator_form_edit.dart';
import 'package:kinerja_app/ui/pages/indikator/indikator_page.dart';
import 'package:kinerja_app/ui/widget/floating_add_button.dart';

class IndikatorGroup extends StatefulWidget {
  final int idKriteria;
  const IndikatorGroup({required this.idKriteria, super.key});

  @override
  State<IndikatorGroup> createState() => _IndikatorGroupState();
}

class _IndikatorGroupState extends State<IndikatorGroup> {
  List<IndikatorFormModel> indikator = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Indikator Group'),
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<KriteriaBloc>().add(KriteriaGet());
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const IndikatorPage();
              }));
            },
          ),
        ),
        body: BlocConsumer<IndikatorBloc, IndikatorState>(
          listener: (context, state) {
            if (state is IndikatorStateFailed) {
              showCustomSnackBar(context, state.e);
            }
          },
          builder: (context, state) {
            return BlocBuilder<IndikatorBloc, IndikatorState>(
              builder: (context, state) {
                if (state is IndikatorStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is IndikatorStateDeleted) {
                  context
                      .read<IndikatorBloc>()
                      .add(GetEventIndikatorByKriteria(widget.idKriteria));
                }

                if (state is IndikatorStateLoadedByKriteriaId) {
                  indikator = state.indikator;
                }

                return Stack(
                  children: [
                    ListView.builder(
                      itemCount: indikator.length,
                      itemBuilder: (context, index) {
                        return Material(
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            onTap: () {
                              context.read<IndikatorBloc>().add(
                                  GetEventIndikatorById(int.parse(
                                      indikator[index].id.toString())));
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const IndikatorEditPage(
                                      // indikator: int.parse(indikator[index].id.toString()),
                                      ),
                                ),
                                (route) => true, // Remove all previous routes
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
                                          context.read<IndikatorBloc>().add(
                                                DeleteEventIndikator(int.parse(
                                                  indikator[index]
                                                      .id
                                                      .toString(),
                                                )),
                                              );
                                          Navigator.of(context).pop();
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
                                title: Text(
                                  indikator[index].nama.toString(),
                                  style: TextStyle(
                                    color: darkColor,
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    // Delete logic here
                                    context.read<IndikatorBloc>().add(
                                          DeleteEventIndikator(int.parse(
                                            indikator[index].id.toString(),
                                          )),
                                        );

                                    showCustomSnackBar(context,
                                        'Indikator deleted successfully');
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/indikator-add', (route) => true);
                      },
                    )
                  ],
                );
              },
            );
          },
        ));
  }
}
