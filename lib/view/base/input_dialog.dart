import 'package:efood_multivendor_restaurant/controller/order_controller.dart';
import 'package:efood_multivendor_restaurant/util/dimensions.dart';
import 'package:efood_multivendor_restaurant/util/styles.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_button.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_restaurant/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputDialog extends StatefulWidget {
  final String icon;
  final String? title;
  final String description;
  final Function(String? value) onPressed;
  const InputDialog({Key? key, required this.icon, this.title, required this.description, required this.onPressed}) : super(key: key);

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [

            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Image.asset(widget.icon, width: 50, height: 50),
            ),

            widget.title != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Text(
                widget.title!, textAlign: TextAlign.center,
                style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
              ),
            ) : const SizedBox(),

            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Text(widget.description, style: IBMPlexSansArabicMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            CustomTextField(
              maxLines: 1,
              controller: _textEditingController,
              hintText: 'enter_processing_time'.tr,
              isEnabled: true,
              inputType: TextInputType.number,
              inputAction: TextInputAction.done,

            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            GetBuilder<OrderController>(builder: (orderController) {
              return (orderController.isLoading) ? const Center(child: CircularProgressIndicator()) : Row(children: [

                Expanded(child: CustomButton(
                  buttonText: 'submit'.tr,
                  onPressed: () {
                    if(_textEditingController.text.trim().isEmpty) {
                      showCustomSnackBar('please_provide_processing_time'.tr);
                    }else {
                      widget.onPressed(_textEditingController.text.trim());
                    }
                  },
                  height: 40,
                )),

                const SizedBox(width: Dimensions.paddingSizeLarge),

                Expanded(child: TextButton(
                  onPressed: ()  => widget.onPressed(null),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: const Size(1170, 40), padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                  ),
                  child: Text(
                    'cancel'.tr, textAlign: TextAlign.center,
                    style: IBMPlexSansArabicBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                )),

              ]);
            }),

          ]),
        ),
      )),
    );
  }
}