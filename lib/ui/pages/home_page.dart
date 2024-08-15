import 'package:flutter/material.dart';
import 'package:kinerja_app/blocs/auth/auth_bloc_bloc.dart';
import 'package:kinerja_app/blocs/dashboard/dashboard_bloc.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/widget/card_dashboard.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  // final DashboardFormModel dashboard = DashboardFormModel();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: primaryColor,
        shadowColor: Colors.transparent,
      ),
      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthFailed) {
            showCustomSnackBar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AuthLoginSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(DashboardGet());
                return Future<void>.value();
              },
              color: primaryColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(
                          80,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 40),
                          title: Text(
                            'Selamat Datang',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            state.user.nama.toString(),
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            state.user.aksesLevel.toString() == 'admin'
                                ? Icons.admin_panel_settings
                                : Icons.people,
                            color: whiteColor,
                            size: 50,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      color: primaryColor,
                      child: Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                              100,
                            ),
                          ),
                        ),
                        child: buildDashboardCard(context),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  // buildDashboardCard(context),
                ],
              ),
            );
          }

          return Container();
        },
      ),
      backgroundColor: whiteColor,
    );
  }

  Widget buildDashboardCard(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is AuthLoginSuccess) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DashboardLoaded) {
          return Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Wrap(
                    spacing: 30,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children: [
                      CardDashboard(
                        title:
                            'Kriteria : ${state.dashboard.jumlahKriteria.toString()}',
                        icon: Icon(
                          Icons.format_list_bulleted,
                          color: primaryColor,
                          size: 60,
                        ),
                      ),
                      CardDashboard(
                        title:
                            'Indikator : ${state.dashboard.jumlahIndikator.toString()}',
                        icon: Icon(
                          Icons.point_of_sale,
                          color: primaryColor,
                          size: 60,
                        ),
                      ),
                      CardDashboard(
                        title:
                            'Skala : ${state.dashboard.jumlahUser.toString()}',
                        icon: Icon(
                          Icons.scale,
                          color: primaryColor,
                          size: 60,
                        ),
                      ),
                      CardDashboard(
                        title:
                            'Pegawai : ${state.dashboard.jumlahPegawai.toString()}',
                        icon: Icon(
                          Icons.people,
                          color: primaryColor,
                          size: 60,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ]),
          );
        }
        return Container();
      },
    );
  }

  Widget buildUserInformation(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: 155,
      height: 156,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.1,
            offset: Offset(0, 1),
            blurStyle: BlurStyle.normal,
          )
        ],
        color: whiteColor,
      ),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(
                  20,
                ),
              ),
              child: Image.asset(
                'assets/image_ocbc.png',
                width: 100,
                height: 100,
              )),
        ],
      ),
    );
  }
}
