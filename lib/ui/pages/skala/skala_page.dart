import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/skala/skala_bloc.dart';
import 'package:kinerja_app/models/skala_from_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/skala/skala_form_add.dart';
import 'package:kinerja_app/ui/pages/skala/skala_form_edit.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class SkalaPage extends StatefulWidget {
  const SkalaPage({super.key});

  @override
  State<SkalaPage> createState() => _SkalaPageState();
}

class _SkalaPageState extends State<SkalaPage> {
  List<SkalaFormModel> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      drawer: const SideBar(),
      // appBar: AppBar(
      //   title: const Text('Skala'),
      //   backgroundColor: primaryColor,
      // ),
      body: Column(
        children: [
          const SizedBox(
            height: 350,
            child: BannerSkala(),
          ),
          Expanded(
            child: BlocConsumer<SkalaBloc, SkalaState>(
              listener: (context, state) {
                if (state is SkalaStateError) {
                  showCustomSnackBar(context, state.e);
                }
              },
              builder: (context, state) {
                if (state is SkalaStateLoaded) {
                  data = state.data;
                }
                if (state is SkalaStateDeleted) {
                  context.read<SkalaBloc>().add(SkalaEventGet());
                  return const Center(child: CircularProgressIndicator());
                }
                return CardSkala(data: data);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SkalaAddPage(),
              ),
              (route) => true);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CardSkala extends StatelessWidget {
  const CardSkala({
    super.key,
    required this.data,
  });

  final List<SkalaFormModel> data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          childAspectRatio: 1,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0.5,
                    offset: Offset(0, 3),
                  ),
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: primaryColor,
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  context.read<SkalaBloc>().add(
                      SkalaEventGetById(int.parse(data[index].id.toString())));
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SkalaEditPage(
                        id: data[index].id.toString(),
                      ),
                    ),
                    (route) => true,
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        title: const Text('Delete Skala'),
                        content: const Text(
                            'Are you sure you want to delete this Skala?'),
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
                              context.read<SkalaBloc>().add(
                                    SkalaEventDelete(
                                      int.parse(data[index].id.toString()),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
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
                        data[index].nama,
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(data[index].keterangan,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(data[index].interval,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class BannerSkala extends StatelessWidget {
  const BannerSkala({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.zero,
      top: false,
      bottom: false,
      child: Container(
        width: double.infinity,
        height: 300,
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
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Transform.scale(
                      scale: 1.8,
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.05,
                          top: MediaQuery.of(context).size.height * 0.1,
                        ),
                        width: 200,
                        height: 130,
                        child: Image.asset(
                          'assets/scales.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text('Skala Penilaian Kinerja Kerja',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.01,
                child: TextButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: whiteColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
