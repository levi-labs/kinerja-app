import 'package:flutter/material.dart';
import 'package:kinerja_app/shared/theme.dart';
import 'package:kinerja_app/ui/pages/home_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            height: 200,
            width: 200,
            alignment: Alignment.center,
            child: Image.asset('assets/image_ocbc.png'),
          ),
          Text(
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
                decoration: InputDecoration(
                    label: Text('Username'),
                    hintText: 'username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
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
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    }), (route) => false);
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
      ),
    );
  }
}
