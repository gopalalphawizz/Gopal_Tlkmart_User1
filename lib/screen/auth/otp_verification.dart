import 'package:alpha_ecommerce_18oct/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../helper/color.dart';
import '../../helper/images.dart';
import '../../helper/routes.dart';
import '../../widgets/commonBackground.dart';
import '../../widgets/toast_message.dart';

class OTPVerification extends StatefulWidget {
  final bool signIn;
  const OTPVerification({Key? key, required this.signIn}) : super(key: key);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const CommonBackgroundPatternAuthWidget(),
          const CommonBackgroundAuthWidget(),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.only(top: 35),
                    height: 80,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: InkWell(
                                onTap: () {
                                  Routes.navigateToPreviousScreen(context);
                                },
                                child: const Icon(Icons.arrow_back_ios)),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.1),
                              child: const Text(
                                "OTP Verification",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: colors.textColor, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Image.asset(
                    Images.greenTopLogo,
                    height: 90,
                    width: 110,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    otp1,
                    style: TextStyle(
                        color: colors.textColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    otp2,
                    style: TextStyle(
                      color: colors.lightTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (index) {
                            return Container(
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                              child: TextField(
                                controller: otpControllers[index],
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors.textFieldColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors.textFieldColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors.textFieldColor),
                                  ),
                                  counterStyle:
                                      TextStyle(color: colors.textFieldColor),
                                ),
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: colors.textColor),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ], // Limit to one character
                              ),
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          children: [
                            // CommonButton(
                            //   text: "Verify",
                            //   onClick: () {
                            //     if (_formKey.currentState!.validate()) {
                            //       widget.signIn
                            //           ? Routes.navigateToSignUpScreen(context)
                            //           : Routes.navigateToResetPasswordScreen(
                            //               context);
                            //     }
                            //   },
                            // ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    widget.signIn
                                        ? Routes.navigateToSignUpScreen(context)
                                        : Routes.navigateToResetPasswordScreen(
                                            context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: colors.buttonColor,
                                  onPrimary: colors.textColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text('Verify',
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 30, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    otp3,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: colors.lightTextColor),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showToastMessage(
                                          "Verification code was sent successfully");
                                    },
                                    child: const Text(
                                      "Resend OTP",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: colors.buttonColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.signIn ? signIn5 : signIn4,
                        style:
                            const TextStyle(fontSize: 14, color: colors.textColor),
                      ),
                      InkWell(
                        onTap: () {
                          widget.signIn
                              ? Routes.navigateToSignInScreen(context)
                              : Routes.navigateToVerifyNumberScreen(
                                  context, false);
                        },
                        child: Text(
                          widget.signIn ? 'Sign In' : 'Sign Up',
                          style: const TextStyle(
                            fontSize: 14,
                            color: colors.buttonColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}