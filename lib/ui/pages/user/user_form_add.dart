import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/user/user_bloc.dart';
import 'package:kinerja_app/models/user_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class UserAddPage extends StatelessWidget {
  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController levelController = TextEditingController(text: '');
  List<Map<String, dynamic>> level = [
    {
      'id': '0',
      'value': 'admin',
    },
    {
      'id': '1',
      'value': 'staf',
    },
  ];
  UserAddPage({super.key});

  bool validateEmail() {
    final bool isValidEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);

    if (!isValidEmail) {
      return false;
    }

    return true;
  }

  bool validate() {
    if (namaController.text.isEmpty ||
        emailController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        levelController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          const SizedBox(
            height: 20,
          ),
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                color: whiteColor,
                child: const Text('Form User', style: TextStyle(fontSize: 25)),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 25, left: 10, right: 10),
                width: 600,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 114, 110, 110),
                      blurRadius: 0.1,
                      offset: Offset(0, 2),
                      blurStyle: BlurStyle.normal,
                    )
                  ],
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: namaController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        labelText: 'Nama User',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: 'Email',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r"[^a-zA-Z0-9@._-]")),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownMenu(
                      controller: levelController,
                      width: 360,
                      label: Text('Pilih Level',
                          style: TextStyle(
                            color: darkColor,
                            fontSize: 16,
                          )),
                      onSelected: (value) {
                        if (value != null) {
                          levelController.text = value;
                        }
                      },
                      inputDecorationTheme: InputDecorationTheme(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: darkColor,
                          fontSize: 16,
                        ),
                      ),
                      dropdownMenuEntries: level
                          .map((e) => DropdownMenuEntry(
                                value: e['value'],
                                label: e['value'],
                              ))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        labelText: 'Password',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 240,
                child: BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserSuccessState) {
                      Navigator.pop(context);
                      context.read<UserBloc>().add(GetUserEvent());
                      showCustomSnackBar(context, 'User Success di Tambahkan');
                    }
                    if (state is UserErrorState) {
                      showCustomSnackBar(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        if (!validate()) {
                          showCustomSnackBar(
                              context, 'Field Tidak Boleh Kosong');
                        } else {
                          if (!validateEmail()) {
                            showCustomSnackBar(context, 'Email Tidak Valid');
                          } else {
                            context.read<UserBloc>().add(AddUserEvent(UserModel(
                                nama: namaController.text,
                                username: usernameController.text,
                                email: emailController.text,
                                aksesLevel: levelController.text,
                                password: passwordController.text)));
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(56)),
                        ),
                        backgroundColor: primaryColor,
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
