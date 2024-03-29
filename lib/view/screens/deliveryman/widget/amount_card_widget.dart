import 'package:efood_multivendor_restaurant/util/dimensions.dart';
import 'package:efood_multivendor_restaurant/util/styles.dart';
import 'package:flutter/material.dart';

class AmountCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const AmountCardWidget({Key? key, required this.title, required this.value, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        color: color,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

        Text(value, style: IBMPlexSansArabicBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.white)),
        const SizedBox(height: Dimensions.paddingSizeSmall),

        Text(
          title, textAlign: TextAlign.center,
          style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),
        ),

      ]),
    ));
  }
}
