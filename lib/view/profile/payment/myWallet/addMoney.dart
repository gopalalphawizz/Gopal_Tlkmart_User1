import 'dart:io';

import 'package:alpha_ecommerce_18oct/utils/app_dimens/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utils/color.dart';
import '../../../../utils/routes.dart';
import '../../../widget_common/commonBackground.dart';
import '../../../widget_common/common_button.dart';
import '../../../widget_common/common_header.dart';
import '../../../widget_common/common_textfield.dart';
import '../../../widget_common/textfield_validation.dart';
import '../../common_header.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const LightBackGround(),
        Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          extendBody: true,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.transparent
              : Colors.white,
          body: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.transparent
                      : colors.buttonColor,
                  child:  Stack(
                    children: [
                      ProfileHeader(),
                      InternalPageHeader(text: "Add Money")
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            validator: validateName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? colors.textFieldBG
                                  : Colors.white,
                              labelText: "Amount",
                              hintText: "Amount",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? colors.greyText
                                        : Colors.black,
                                    fontSize:
                                        Platform.isAndroid ? size_12 : size_14,
                                  ),
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? colors.labelColor
                                        : Colors.black,
                                  ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: colors.textFieldColor,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: colors.textFieldColor,
                                  width: 1,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: colors.textFieldColor,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: colors.textFieldColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                            //    commonInputDecoration(
                            //       labelText: 'Amount', context: context),
                            //   style: Theme.of(context).textTheme.titleSmall!.copyWith(color: colors.textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? colors.textFieldBG
                        : colors.white10,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: CommonButton(
                                    text: "CONTINUE",
                                    colorsText: Colors.white,
                                    fontSize:
                                        Platform.isAndroid ? size_12 : size_14,
                                    onClick: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();

                                      if (_formKey.currentState!.validate()) {
                                        Routes.navigateToPaymentScreen(
                                            context,
                                            "",
                                            "",
                                            amountController.text,
                                            false,
                                            "wallet",
                                            "");
                                      }
                                    })),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
