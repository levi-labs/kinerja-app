import 'package:flutter/material.dart';
import 'package:kinerja_app/blocs/auth/auth_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/ui/pages/home_page.dart';
import 'package:kinerja_app/ui/pages/sign_in_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthLoginSuccess) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return HomePage();
            }), (route) => false);
          }

          if (state is AuthFailed) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-in', (route) => false);
          }
        },
        child: Center(
          child: Container(
            width: 155,
            height: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image_ocbc.png'),
              ),
            ),

            // child: Image.asset('assets/image_ocbc.png'),
          ),
        ),
      ),
    );
  }
}
