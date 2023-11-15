import 'package:flutter/material.dart';

import '../Models/special_offer.dart';

class SpecialOfferWidget extends StatelessWidget {
  const SpecialOfferWidget(
      this.context, {
        Key? key,
        required this.data,
        required this.index,
      }) : super(key: key);

  final SpecialOffer data;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:8),
          child: SizedBox(
            height: 80,
            width: 80,
            child: Image.asset(
              data.icon,
              fit: BoxFit.contain,
            ),
          ),
        ),


      ],
    );
  }
}