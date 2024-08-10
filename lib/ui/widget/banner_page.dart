import 'package:flutter/material.dart';
import 'package:kinerja_app/shared/theme.dart';

class BannerWidgetPage extends StatelessWidget {
  final String title;
  final String image;
  const BannerWidgetPage({
    required this.title,
    required this.image,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Transform.scale(
                scale: 1.8,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(title,
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
