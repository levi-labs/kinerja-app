import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/auth/auth_bloc_bloc.dart';
import 'package:kinerja_app/blocs/kriteria/kriteria_bloc.dart';
import 'package:kinerja_app/models/kriteria_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/auth/sign_in_page.dart';
import 'package:kinerja_app/ui/pages/kriteria/kriteria_form_edit.dart';
import 'package:kinerja_app/ui/widget/floating_add_button.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class KriteriaPage extends StatefulWidget {
  const KriteriaPage({super.key});

  @override
  State<KriteriaPage> createState() => _KriteriaPageState();
}

class _KriteriaPageState extends State<KriteriaPage> {
  List<KriteriaFormModel> kriteria = [];

  @override
  void initState() {
    super.initState();
    // context.read<KriteriaBloc>().add(KriteriaGet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Kriteria'),
        backgroundColor: primaryColor,
      ),
      body: BlocBuilder<KriteriaBloc, KriteriaState>(
        builder: (context, state) {
          var x = context.read<AuthBloc>().state;
          if (x is AuthFailed) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SignInPage();
            }));
            showCustomSnackBar(context, x.e);
          }

          if (state is KriteriaLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is KriteriaDeleteSuccess) {
            context.read<KriteriaBloc>().add(KriteriaGet());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is KriteriaLoaded) {
            kriteria = state.kriteria;

            return Stack(
              children: [
                ListView.builder(
                  itemCount: kriteria.length,
                  itemBuilder: (context, index) {
                    return Material(
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          context.read<KriteriaBloc>().add(KriteriaGetById(
                              int.parse(kriteria[index].id.toString())));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KriteriaEditPage(
                                kriteria:
                                    int.parse(kriteria[index].id.toString()),
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
                                      context.read<KriteriaBloc>().add(
                                            KriteriaDelete(int.parse(
                                              kriteria[index].id.toString(),
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
                              kriteria[index].nama.toString(),
                              style: TextStyle(
                                color: darkColor,
                                fontSize: 20,
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                // Delete logic here
                                context.read<KriteriaBloc>().add(
                                      KriteriaDelete(int.parse(
                                        kriteria[index].id.toString(),
                                      )),
                                    );
                                // showCustomSnackBar(context, 'Kriteria deleted');
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
                        context, '/kriteria-add', (route) => true);
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
