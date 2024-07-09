import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/auth/auth_bloc_bloc.dart';
import 'package:kinerja_app/blocs/dashboard/dashboard_bloc.dart';
import 'package:kinerja_app/blocs/indikator/indikator_bloc.dart';
import 'package:kinerja_app/blocs/kriteria/kriteria_bloc.dart';
import 'package:kinerja_app/blocs/nilai/nilai_bloc.dart';
import 'package:kinerja_app/blocs/skala/skala_bloc.dart';
import 'package:kinerja_app/ui/pages/indikator/indikator_form_add.dart';
import 'package:kinerja_app/ui/pages/indikator/indikator_page.dart';
import 'package:kinerja_app/ui/pages/kriteria/kriteria_form_add.dart';
import 'package:kinerja_app/ui/pages/auth/sign_in_page.dart';
import 'package:kinerja_app/ui/pages/loading_screen/splash_screen.dart';
import 'package:kinerja_app/ui/pages/nilai/nilai_detail_list.dart';
import 'package:kinerja_app/ui/pages/nilai/nilai_form_add.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc()..add(DashboardGet()),
        ),
        BlocProvider<KriteriaBloc>(
          create: (context) => KriteriaBloc()..add(KriteriaGet()),
        ),

        BlocProvider<IndikatorBloc>(
          create: (context) => IndikatorBloc()..add(GetEventIndikator()),
        ),

        BlocProvider<SkalaBloc>(
          create: (context) => SkalaBloc()..add(SkalaEventGet()),
        ),

        BlocProvider<NilaiBloc>(
          create: (context) => NilaiBloc()..add(NilaiLoadedEvent()),
        )

        // BlocProvider<KriteriaBloc>(
        //   create: (context) => KriteriaBloc()..add(KriteriaGet()),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/sign-in': (context) => const SignInPage(),
          '/kriteria-add': (context) => KriteriaFormAdd(),
          '/indikator': (context) => const IndikatorPage(),
          '/indikator-add': (context) => const IndikatorAddPage(),
          '/nilai-add': (context) => const NilaiAddPage(),
          '/nilai-by-date': (context) => const NilaiListByDate(),
        },
      ),
    );
  }
}
