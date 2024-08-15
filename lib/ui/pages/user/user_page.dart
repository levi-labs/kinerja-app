import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinerja_app/blocs/user/user_bloc.dart';
import 'package:kinerja_app/models/user_form_model.dart';
import 'package:kinerja_app/shared/shared_methods.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/user/user_form_edit.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class UserPage extends StatelessWidget {
  List<UserModel> data = [];
  UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('User'),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 300,
            child: BannerUser(),
          ),
          Expanded(
            child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserResetPasswordSuccessState) {
                  context.read<UserBloc>().add(GetUserEvent());
                }
              },
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is UserLoadedState) {
                  data = state.data;
                }
                if (state is UserDeleteSuccessState) {
                  context.read<UserBloc>().add(GetUserEvent());
                  return const Center(child: CircularProgressIndicator());
                }

                return UserCard(data: data);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/user-add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final List<UserModel> data;
  const UserCard({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserErrorState) {
                  showCustomSnackBar(context, state.error);
                }
                // if (state is UserResetPasswordSuccessState) {
                //   context.read<UserBloc>().add(GetUserEvent());
                // }
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserEditPage(),
                            ),
                            (route) => true, // Remove all previous routes
                          );
                          context
                              .read<UserBloc>()
                              .add(GetUserByIdEvent(data[index].id.toString()));
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: const Text('Delete User'),
                                content: const Text(
                                    'Are you sure you want to delete this User?'),
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
                                      context.read<UserBloc>().add(
                                            DeleteUserEvent(
                                              data[index].id.toString(),
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
                        child: ListTile(
                          title: Text(
                            data[index].nama.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Text(
                                    'Username :  ${data[index].username}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Text(
                                    'Akses Level :  ${data[index].aksesLevel}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Text(
                                    'Email :  ${data[index].email}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: const Text('Reset Password'),
                                      content: const Text(
                                          'Are you sure you want to reset password this User?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Oke'),
                                          onPressed: () {
                                            context.read<UserBloc>().add(
                                                  UpdateUserPasswordEvent(
                                                    data[index].id.toString(),
                                                  ),
                                                );
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Icon(Icons.refresh_sharp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: -10,
                      right: -20,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.transparent),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BannerUser extends StatelessWidget {
  const BannerUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Transform.scale(
                scale: 1.8,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/user.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Daftar List Pegawai ',
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
