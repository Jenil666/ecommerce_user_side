import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Image.asset(
          "assets/images/offer_screen.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
