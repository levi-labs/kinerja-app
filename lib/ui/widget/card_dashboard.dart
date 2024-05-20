import 'package:flutter/material.dart';
import 'package:kinerja_app/shared/theme.dart';

class CardDashboard extends StatelessWidget {
  final String title;
  final Widget icon;

  const CardDashboard({
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 176,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.5,
            offset: Offset(0, 1),
            blurStyle: BlurStyle.normal,
          )
        ],
        color: whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                20,
              )),
              child: Center(child: icon)),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Text(
              title.toString(),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
