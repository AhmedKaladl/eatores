import 'package:efood_multivendor_restaurant/controller/coupon_controller.dart';
import 'package:efood_multivendor_restaurant/data/model/response/coupon_body.dart';
import 'package:efood_multivendor_restaurant/helper/price_converter.dart';
import 'package:efood_multivendor_restaurant/util/dimensions.dart';
import 'package:efood_multivendor_restaurant/util/images.dart';
import 'package:efood_multivendor_restaurant/util/styles.dart';
import 'package:efood_multivendor_restaurant/view/base/confirmation_dialog.dart';
import 'package:efood_multivendor_restaurant/view/screens/coupon/add_coupon_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponCardDialogue extends StatelessWidget {
  final CouponBody couponBody;
  final int index;
  const CouponCardDialogue({Key? key, required this.couponBody, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * 0.55,
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.black87 : Colors.transparent,
              image: DecorationImage(image: const AssetImage(Images.couponDetails), fit: BoxFit.fitWidth,
                  colorFilter: Get.isDarkMode ? ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop) : null,
              ),
            ),
            child: Stack(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min, children: [
                  Row(children: [

                    SizedBox(
                      height: 50, width: 50,
                      child: Stack(children: [
                        Image.asset(Images.couponVertical),
                        Positioned(
                          top: 15, left: 15,
                          child: Text(couponBody.couponType == 'free_delivery' ? '' : couponBody.discountType == 'percent' ? ' %' : ' \$',
                            style: IBMPlexSansArabicBold.copyWith(fontSize: 18, color: Theme.of(context).cardColor),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),

                    Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${'${couponBody.couponType == 'free_delivery' ? 'free_delivery'.tr : couponBody.discountType != 'percent' ?
                      PriceConverter.convertPrice(double.parse(couponBody.discount.toString())) :
                      couponBody.discount}'} ${couponBody.couponType == 'free_delivery' ? '' : couponBody.discountType == 'percent' ? ' %' : ''}'
                          '${couponBody.couponType == 'free_delivery' ? '' : 'off'.tr}',
                        style: IBMPlexSansArabicBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge), textDirection: TextDirection.rtl,
                      ),
                      Text('${couponBody.code}', style: IBMPlexSansArabicMedium),
                    ]),
                    const Spacer(),

                    GetBuilder<CouponController>(
                      builder: (couponController) {
                        return Switch(
                          activeColor: Theme.of(context).primaryColor,
                          value: couponController.coupons![index].status == 1 ? true : false,
                          onChanged: (bool status){
                            couponController.changeStatus(couponController.coupons![index].id, status).then((success) {
                              if(success){
                                couponController.getCouponList();
                              }
                            });
                          },
                        );
                      }
                    ),

                  ]),

                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  Text('-  ${'start_date'.tr} : ${couponBody.startDate!}',
                    style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Text('- ${'expire_date'.tr} : ${couponBody.expireDate!}',
                    style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Text('-  ${'total_user'.tr} : ${couponBody.totalUses.toString()}',
                    style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Text('- ${'min_purchase'.tr} : ${couponBody.minPurchase.toString()}',
                    style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Text('- ${'limit'.tr} : ${couponBody.limit.toString()}',
                    style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Text('- ${'coupon_type'.tr} : ${couponBody.couponType!.tr}',
                    style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                ]),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: GetBuilder<CouponController>(
                      builder: (couponController) {
                        return Row(mainAxisSize: MainAxisSize.min, children: [
                          OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(const BorderSide(
                                  color: Colors.blue,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                            ),
                            onPressed: (){
                              Get.back();
                              Get.to(()=> AddCouponScreen(coupon: couponController.coupons![index]));
                            },
                            child: const Icon(Icons.edit, color: Colors.blue),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeExtraLarge),

                          OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(const BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                            ),
                            onPressed: (){
                              Get.back();
                              Get.dialog(ConfirmationDialog(
                                icon: Images.warning, title: 'are_you_sure_to_delete'.tr, description: 'you_want_to_delete_this_coupon'.tr,
                                onYesPressed: () {
                                  couponController.deleteCoupon(couponBody.id);
                                },
                              ), barrierDismissible: false);
                            },
                            child: const Icon(Icons.delete_outline, color: Colors.red),
                          ),
                        ]);
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
