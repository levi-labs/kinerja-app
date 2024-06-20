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
        color: primaryColor,
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
            Image.asset(
              image,
              fit: BoxFit.fill,
              width: 350,
              height: 350,
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
