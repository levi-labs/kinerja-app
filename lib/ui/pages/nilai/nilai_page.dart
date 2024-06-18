import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/nilai/nilai_bloc.dart';
import 'package:kinerja_app/models/nilai_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/widget/banner_page.dart';
import 'package:kinerja_app/ui/widget/card_list.dart';

class NilaiPage extends StatefulWidget {
  const NilaiPage({super.key});

  @override
  State<NilaiPage> createState() => _NilaiPageState();
}

class _NilaiPageState extends State<NilaiPage> {
  List<NilaiFormModel> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nilai'),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          const BannerWidgetPage(
            title: 'Daftar Penilaian Kinerja',
            image: 'assets/nilai.png',
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
                return CardWidget(data: data);
              },
            ),
          )
        ],
      ),
    );
  }
}
