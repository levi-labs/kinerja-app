import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/pegawai/pegawai_bloc.dart';
import 'package:kinerja_app/models/pegawai_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/pegawai/pegawai_form_edit.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({super.key});

  @override
  State<PegawaiPage> createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  List<PegawaiFormModel> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Pegawai'),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 300,
            child: BannerPegawai(),
          ),
          Expanded(
            child: BlocBuilder<PegawaiBloc, PegawaiState>(
              builder: (context, state) {
                if (state is PegawaiLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PegawaiErrorState) {
                  showCustomSnackBar(context, state.error);
                }
                if (state is PegawaiDeletedSuccessState) {
                  context.read<PegawaiBloc>().add(PegawaiLoadedEvent());

                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PegawaiLoadedState) {
                  data = state.data;
                }
                return PegawaiCard(data: data);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/pegawai-add', (route) => true);
        },
        backgroundColor: Colors.blue, // Customize the background color
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PegawaiCard extends StatelessWidget {
  const PegawaiCard({
    required this.data,
    super.key,
  });

  final List<PegawaiFormModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: primaryColor,
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PegawaiEditPage(),
                    ),
                    (route) => true, // Remove all previous routes
                  );
                  context
                      .read<PegawaiBloc>()
                      .add(PegawaiShowByIdEvent(data[index].id.toString()));
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        title: const Text('Delete Pegawai'),
                        content: const Text(
                            'Are you sure you want to delete this Pegawai?'),
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
                              context.read<PegawaiBloc>().add(
                                    PegawaiDeletedEvent(
                                      data[index].id.toString(),
                                    ),
                                  );
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: ListTile(
                  title: Text(
                    data[index].namaLengkap,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Text(
                            'Jabatan : ' + data[index].jabatan,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Text(
                            'NIP : ' + data[index].nip,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BannerPegawai extends StatelessWidget {
  const BannerPegawai({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor, // Light blue
            const Color(0xFF1A237E), // Deep blue
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(
            80,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Transform.scale(
                scale: 1.8,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/Team work-rafiki.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Daftar List Pegawai ',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
