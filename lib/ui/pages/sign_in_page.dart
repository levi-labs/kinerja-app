import 'package:flutter/material.dart';
import 'package:kinerja_app/blocs/auth/auth_bloc_bloc.dart';
import 'package:kinerja_app/models/login_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  bool validate() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthFailed) {
            showCustomSnackBar(context, state.e);
          }
          if (state is AuthLoginSuccess) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return HomePage();
            }), (route) => false);
            showCustomSnackBar(context, 'Login Success');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100),
                height: 200,
                width: 200,
                alignment: Alignment.center,
                child: Image.asset('assets/image_ocbc.png'),
              ),
              const Text(
                'Sign In \nPerformance System',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        label: const Text('Username'),
                        hintText: 'username',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        label: const Text('Password'),
                        suffixIcon: const Icon(Icons.remove_red_eye),
                        hintText: 'password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14))),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 50,
                    width: 240,
                    child: TextButton(
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(AuthLogin(LoginFormModel(
                                username: usernameController.text,
                                password: passwordController.text,
                              )));
                          // Navigator.pushAndRemoveUntil(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const HomePage();
                          // }), (route) => false);
                        } else {
                          showCustomSnackBar(context,
                              'Gagal, Username atau Password tidak boleh kosong');
                        }
                      },
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(56)),
                        ),
                        backgroundColor: primaryColor,
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
