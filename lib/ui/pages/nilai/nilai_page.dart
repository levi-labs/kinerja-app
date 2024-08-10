import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kinerja_app/blocs/nilai/nilai_bloc.dart';
import 'package:kinerja_app/models/nilai_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/widget/banner_page.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class NilaiPage extends StatefulWidget {
  const NilaiPage({super.key});

  @override
  State<NilaiPage> createState() => _NilaiPageState();
}

class _NilaiPageState extends State<NilaiPage> {
  List<NilaiFormModel> data = [];
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Nilai'),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 300,
            child: BannerWidgetPage(
              title: 'Daftar Penilaian Kinerja',
              image: 'assets/nilai.png',
            ),
          ),
          Expanded(
            child: BlocConsumer<NilaiBloc, NilaiState>(
              listener: (context, state) {
                if (state is NilaiErrorState) {
                  showCustomSnackBar(context, state.e);
                }
              },
              builder: (context, state) {
                if (state is NilaiLoadedState) {
                  data = state.data;
                }

                return GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Material(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          context.read<NilaiBloc>().add(NilaiShowByDateEvent(
                              data[index]
                                  .tanggalNilai
                                  .toString()
                                  .substring(0, 7)));

                          Navigator.pushNamed(context, '/nilai-by-date');
                        },
                        onLongPress: () {},
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0.1),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 101, 170, 244),
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
                                  data[index]
                                      .tanggalNilai
                                      .toString()
                                      .substring(5, 7),
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                data[index]
                                    .tanggalNilai
                                    .toString()
                                    .substring(0, 4),
                                style: TextStyle(
                                  color: darkColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var jakarta = DateTime.now().toUtc().add(const Duration(hours: 7));
          var format = DateFormat('yyyy-MM-dd');
          var formattedDate = format.format(jakarta);

          context
              .read<NilaiBloc>()
              .add(NilaiCreateByDateEvent(formattedDate.toString()));
          Navigator.pushNamed(context, '/nilai-add');
        },
        backgroundColor: Colors.blue, // Customize the background color
        child: const Icon(Icons.add),
      ),
    );
  }
}
