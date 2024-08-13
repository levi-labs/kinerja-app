import 'package:flutter/material.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/widget/sidebar.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

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
          SizedBox(
            height: 300,
            child: BannerUser(),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => PegawaiEditPage(),
                          //   ),
                          //   (route) => true, // Remove all previous routes
                          // );
                          // context.read<PegawaiBloc>().add(
                          //     PegawaiShowByIdEvent(data[index].id.toString()));
                        },
                        onLongPress: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(15)),
                          //       title: const Text('Delete Pegawai'),
                          //       content: const Text(
                          //           'Are you sure you want to delete this Pegawai?'),
                          //       actions: <Widget>[
                          //         TextButton(
                          //           child: const Text('Cancel'),
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //         ),
                          //         TextButton(
                          //           child: const Text('Delete'),
                          //           onPressed: () {
                          //             // Delete logic here
                          //             context.read<PegawaiBloc>().add(
                          //                   PegawaiDeletedEvent(
                          //                     data[index].id.toString(),
                          //                   ),
                          //                 );
                          //             Navigator.of(context).pop();
                          //           },
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        },
                        child: ListTile(
                          title: Text(
                            '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Text(
                                    'Jabatan : ',
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
                                    'NIP : ' + '',
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
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
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
                    'assets/Team work-rafiki.png',
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
