import 'package:efood_multivendor_restaurant/controller/auth_controller.dart';
import 'package:efood_multivendor_restaurant/util/dimensions.dart';
import 'package:efood_multivendor_restaurant/util/images.dart';
import 'package:efood_multivendor_restaurant/util/styles.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_button.dart';
import 'package:efood_multivendor_restaurant/view/screens/bank/widget/add_bank_bottom_sheet.dart';
import 'package:efood_multivendor_restaurant/view/screens/bank/widget/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankInfoScreen extends StatelessWidget {
  const BankInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Get.find<AuthController>().profileModel == null) {
      Get.find<AuthController>().getProfile();
    }
    return Scaffold(
      appBar: CustomAppBar(title: 'bank_info'.tr),
      body: GetBuilder<AuthController>(builder: (authController) {
        return Center(child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: authController.profileModel != null ? authController.profileModel!.bankName != null ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              InfoWidget(icon: Images.bank, title: 'bank_name'.tr, data: authController.profileModel!.bankName),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              InfoWidget(icon: Images.branch, title: 'branch_name'.tr, data: authController.profileModel!.branch),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              InfoWidget(icon: Images.user, title: 'holder_name'.tr, data: authController.profileModel!.holderName),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              InfoWidget(icon: Images.creditCard, title: 'account_no'.tr, data: authController.profileModel!.accountNo),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),

              CustomButton(
                buttonText: 'edit'.tr,
                onPressed: () => Get.bottomSheet(AddBankBottomSheet(
                  bankName: authController.profileModel!.bankName, branchName: authController.profileModel!.branch,
                  holderName: authController.profileModel!.holderName, accountNo: authController.profileModel!.accountNo,
                ), isScrollControlled: true, backgroundColor: Colors.transparent),
              ),

            ],
          ) : Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            Image.asset(Images.bankInfo, width: context.width-100),
            const SizedBox(height: 30),

            Text(
              'currently_no_bank_account_added'.tr, textAlign: TextAlign.center,
              style: IBMPlexSansArabicRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
            ),
            const SizedBox(height: 30),

            CustomButton(
              buttonText: 'add_bank'.tr,
              onPressed: () => Get.bottomSheet(AddBankBottomSheet(), isScrollControlled: true, backgroundColor: Colors.transparent),
            ),

          ]) : const Center(child: CircularProgressIndicator()),
        ));
      }),
    );
  }
}
