import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oneHour/Widgets/special_offer_widget.dart';

import '../Models/special_offer.dart';

typedef SpecialOffersOnTapSeeAll = void Function();

class SpecialOffers extends StatefulWidget {

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  late final List<SpecialOffer> specials = homeSpecialOffers;

  int selectIndex = 0;
  final PageController controller = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer to animate the PageView
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (!controller.hasClients) return;
      if (selectIndex == specials.length - 1) {
        selectIndex = 0;
      } else {
        selectIndex++;
      }
      controller.animateToPage(
        selectIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Stack(
            children: [
          Container(
            height: 131,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: PageView.builder(
                    controller: controller,
                     itemBuilder: (context, index) {
                     final data = specials[index];
                     return SpecialOfferWidget(context, data: data, index: index);},
                            itemCount: specials.length,
                            allowImplicitScrolling: true,
                             onPageChanged: (value) {
                             setState(() => selectIndex = value);},),),
          _buildPageIndicator()
        ]
        ),
      ],
    );
  }


  Widget _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < specials.length; i++) {
      list.add(i == selectIndex ? _indicator(true) : _indicator(false));
    }
    return Container(
      height: 120,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 4.0,
        width: isActive ? 16 : 4.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(2)),
          color: isActive ? const Color(0XFF101010) : const Color(0xFFBDBDBD),
        ),
      ),
    );
  }
}
