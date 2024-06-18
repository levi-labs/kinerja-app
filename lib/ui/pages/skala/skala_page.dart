import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/skala/skala_bloc.dart';
import 'package:kinerja_app/models/skala_from_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/skala/skala_form_add.dart';
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
      appBar: AppBar(
        title: const Text('Skala'),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          const BannerSkala(),
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
              (route) => false);
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
                onTap: () {},
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
                          data[index].nama,
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(data[index].keterangan,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(data[index].interval,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ));
        });
  }
}

class BannerSkala extends StatelessWidget {
  const BannerSkala({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: primaryColor,
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
            Image.asset(
              'assets/scales.png',
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
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
    );
  }
}
