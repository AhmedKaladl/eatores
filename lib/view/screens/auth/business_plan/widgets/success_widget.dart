import 'package:efood_multivendor_restaurant/controller/auth_controller.dart';
import 'package:efood_multivendor_restaurant/util/dimensions.dart';
import 'package:efood_multivendor_restaurant/util/images.dart';
import 'package:efood_multivendor_restaurant/util/styles.dart';
import 'package:efood_multivendor_restaurant/view/screens/auth/business_plan/widgets/registration_stepper_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SuccessWidget extends StatelessWidget {
  const SuccessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [

            authController.businessIndex == 1 ? RegistrationStepperWidget(status: authController.businessPlanStatus) : const SizedBox(height: Dimensions.paddingSizeLarge),
            SizedBox(height: context.height * 0.2),

            Image.asset(Images.checked, height: 90,width: 90),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            Text('congratulations'.tr, style: IBMPlexSansArabicBold.copyWith(fontSize: Dimensions.fontSizeOverLarge)),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            Text(
              'Your Registration Has been Completed Successfully.\n Admin will confirm your registration request / \n provide review within 48 hour',
              style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center, softWrap: true,
            ),

          ]),
        );
      }
    );
  }
}
