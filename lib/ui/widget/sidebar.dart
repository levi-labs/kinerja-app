import 'package:flutter/material.dart';
import 'package:kinerja_app/blocs/auth/auth_bloc_bloc.dart';
import 'package:kinerja_app/blocs/dashboard/dashboard_bloc.dart';
import 'package:kinerja_app/blocs/indikator/indikator_bloc.dart';
import 'package:kinerja_app/blocs/kriteria/kriteria_bloc.dart';
import 'package:kinerja_app/blocs/nilai/nilai_bloc.dart';
import 'package:kinerja_app/blocs/skala/skala_bloc.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/home_page.dart';
import 'package:kinerja_app/ui/pages/indikator/indikator_page.dart';
import 'package:kinerja_app/ui/pages/kriteria/kriteria_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/ui/pages/nilai/nilai_page.dart';
import 'package:kinerja_app/ui/pages/skala/skala_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: secondaryColor,
        child: BlocConsumer<AuthBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthFailed) {
              showCustomSnackBar(context, state.e);
            }
            if (state is AuthInitial) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/sign-in', (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AuthLoginSuccess) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                    accountName: Text(
                      state.user.nama.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    accountEmail: Text(state.user.email.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        )),
                    currentAccountPicture: CircleAvatar(
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50.0)),
                          child: Image.asset('assets/image_ocbc.png')),
                    ),
                  ),
                  ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () {
                        context.read<DashboardBloc>().add(DashboardGet());
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }), (route) => false);
                      }),
                  ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profile'),
                      onTap: () {}),
                  if (state.user.username == 'admin') ...{
                    ListTile(
                        leading: const Icon(Icons.format_list_bulleted),
                        title: const Text('Kriteria'),
                        onTap: () {
                          context.read<KriteriaBloc>().add(KriteriaGet());
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return const KriteriaPage();
                          }), (route) => false);
                        }),
                    ListTile(
                        leading: const Icon(Icons.point_of_sale),
                        title: const Text('Indikator'),
                        onTap: () {
                          context
                              .read<IndikatorBloc>()
                              .add(GetEventIndikator());
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return const IndikatorPage();
                          }), (route) => false);
                        }),
                    ListTile(
                        leading: const Icon(Icons.scale),
                        title: const Text('Skala'),
                        onTap: () {
                          context.read<SkalaBloc>().add(SkalaEventGet());
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return SkalaPage();
                          }), (route) => false);
                        }),
                  } else ...{
                    ListTile(
                        leading: const Icon(Icons.person_4),
                        title: const Text('User'),
                        onTap: () {}),
                  },
                  ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Penilaian Kinerja'),
                      onTap: () {
                        context.read<NilaiBloc>().add(NilaiLoadedEvent());
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return const NilaiPage();
                        }), (route) => false);
                      }),
                  ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Sign Out'),
                      onTap: () {
                        context.read<AuthBloc>().add(AuthLogout());
                      }),
                ],
              );
            }
            return Container();
          },
        ));
  }
}
