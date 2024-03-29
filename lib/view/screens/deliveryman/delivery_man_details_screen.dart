import 'package:efood_multivendor_restaurant/controller/auth_controller.dart';
import 'package:efood_multivendor_restaurant/controller/delivery_man_controller.dart';
import 'package:efood_multivendor_restaurant/controller/splash_controller.dart';
import 'package:efood_multivendor_restaurant/data/model/response/delivery_man_model.dart';
import 'package:efood_multivendor_restaurant/helper/price_converter.dart';
import 'package:efood_multivendor_restaurant/util/dimensions.dart';
import 'package:efood_multivendor_restaurant/util/images.dart';
import 'package:efood_multivendor_restaurant/util/styles.dart';
import 'package:efood_multivendor_restaurant/view/base/confirmation_dialog.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_button.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_image.dart';
import 'package:efood_multivendor_restaurant/view/screens/deliveryman/widget/amount_card_widget.dart';
import 'package:efood_multivendor_restaurant/view/screens/restaurant/widget/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryManDetailsScreen extends StatelessWidget {
  final DeliveryManModel deliveryMan;
  const DeliveryManDetailsScreen({Key? key, required this.deliveryMan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<DeliveryManController>().setSuspended(!deliveryMan.status!);
    Get.find<DeliveryManController>().getDeliveryManReviewList(deliveryMan.id);
    bool haveSubscription;
    if(Get.find<AuthController>().profileModel!.restaurants![0].restaurantModel == 'subscription'){
      haveSubscription = Get.find<AuthController>().profileModel!.subscription!.review == 1;
    }else{
      haveSubscription = true;
    }

    return Scaffold(
      appBar: CustomAppBar(title: 'delivery_man_details'.tr),
      body: GetBuilder<DeliveryManController>(builder: (dmController) {
        return Column(children: [

          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            physics: const BouncingScrollPhysics(),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Row(children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: deliveryMan.active == 1 ? Colors.green : Colors.red, width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(child: CustomImage(
                    image: '${Get.find<SplashController>().configModel!.baseUrls!.deliveryManImageUrl}/${deliveryMan.image}',
                    height: 70, width: 70, fit: BoxFit.cover,
                  )),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '${deliveryMan.fName} ${deliveryMan.lName}', style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(
                    deliveryMan.active == 1 ? 'online'.tr : 'offline'.tr,
                    style: IBMPlexSansArabicRegular.copyWith(
                      color: deliveryMan.active == 1 ? Colors.green : Colors.red, fontSize: Dimensions.fontSizeExtraSmall,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Row(children: [
                    Icon(Icons.star, color: Theme.of(context).primaryColor, size: 20),
                    Text(deliveryMan.avgRating!.toStringAsFixed(1), style: IBMPlexSansArabicRegular),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(
                      '${deliveryMan.ratingCount} ${'ratings'.tr}',
                      style: IBMPlexSansArabicRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                    ),
                  ]),
                ])),
              ]),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Row(children: [
                AmountCardWidget(
                  title: 'total_delivered_order'.tr,
                  value: deliveryMan.ordersCount.toString(),
                  color: const Color(0xFF377DFF),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                AmountCardWidget(
                  title: 'cash_in_hand'.tr,
                  value: PriceConverter.convertPrice(deliveryMan.cashInHands),
                  color: const Color(0xFF132144),
                ),
              ]),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('reviews'.tr, style: IBMPlexSansArabicMedium),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  haveSubscription ? dmController.dmReviewList != null ? dmController.dmReviewList!.isNotEmpty ? ListView.builder(
                    itemCount: dmController.dmReviewList!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ReviewWidget(
                        review: dmController.dmReviewList![index], fromRestaurant: false,
                        hasDivider: index != dmController.dmReviewList!.length-1,
                      );
                    },
                  ) : Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                    child: Center(child: Text(
                      'no_review_found'.tr, style: IBMPlexSansArabicRegular.copyWith(color: Theme.of(context).disabledColor),
                    )),
                  ) : const Padding(
                    padding: EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                    child: Center(child: CircularProgressIndicator()),
                  ) : Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(child: Text('you_have_no_available_subscription'.tr, style: IBMPlexSansArabicRegular.copyWith(color: Theme.of(context).disabledColor))),
                  ),
                ],
              ),

            ]),
          )),

          CustomButton(
            onPressed: () {
              Get.dialog(ConfirmationDialog(
                icon: Images.warning,
                description: dmController.isSuspended ? 'are_you_sure_want_to_un_suspend_this_delivery_man'.tr
                    : 'are_you_sure_want_to_suspend_this_delivery_man'.tr,
                onYesPressed: () => dmController.toggleSuspension(deliveryMan.id),
              ));
            },
            buttonText: dmController.isSuspended ? 'un_suspend_this_delivery_man'.tr : 'suspend_this_delivery_man'.tr,
            margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            color: dmController.isSuspended ? Colors.green : Colors.red,
          ),

        ]);
      }),
    );
  }
}
