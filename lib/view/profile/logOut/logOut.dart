import 'dart:io';

import 'package:alpha_ecommerce_18oct/provider/home_provider.dart';
import 'package:alpha_ecommerce_18oct/utils/app_dimens/app_dimens.dart';
import 'package:alpha_ecommerce_18oct/utils/shared_pref..dart';
import 'package:alpha_ecommerce_18oct/viewModel/homeViewModel.dart';
import 'package:flutter/material.dart';

import '../../../utils/color.dart';
import '../../../utils/images.dart';
import '../../../utils/routes.dart';

Future<void> logOut(context) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? colors.overlayBG
              : Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        height: MediaQuery.of(context).size.height * .35,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  Images.iconBG,
                  width: 80,
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    Images.logOutSystem,
                    width: 60,
                    height: 60,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Logout',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: Platform.isAndroid ? size_18 : size_20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Are you sure, that you want to logout?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black54,
                  fontSize: Platform.isAndroid ? size_14 : size_14),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.hovered) ||
                            states.contains(MaterialState.pressed)) {
                          return colors.buttonColor;
                        }
                        return Theme.of(context).brightness == Brightness.dark
                            ? colors.overlayBG
                            : Colors.white; // Default color
                      }),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      side: MaterialStateProperty.all(BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : colors.lightBorder,
                          width: 1)),
                    ),
                    onPressed: () {
                      Routes.navigateToPreviousScreen(context);
                    },
                    child: Text(
                      'CANCEL',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: Platform.isAndroid ? size_10 : size_12,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.hovered) ||
                            states.contains(MaterialState.pressed)) {
                          return colors.buttonColor;
                        }
                        return colors.buttonColor;
                      }),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      SharedPref.shared.pref?.setString(PrefKeys.mobile, "");
                      SharedPref.shared.pref
                          ?.setString(PrefKeys.isLoggedIn, "0");
                      SharedPref.shared.pref?.setString(PrefKeys.jwtToken, "");
                      SharedPref.shared.removeUserPRef();

                      Routes.navigateToSignInScreen(context);
                    },
                    child: Text(
                      'LOGOUT',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontSize: Platform.isAndroid ? size_10 : size_12,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<void> deleteAccount(context, HomeViewModel provider) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? colors.overlayBG
              : Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        height: MediaQuery.of(context).size.height * .35,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  Images.iconBG,
                  width: size_70,
                  height: size_70,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    Images.logOutSystem,
                    width: 60,
                    height: 60,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Delete',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: Platform.isAndroid ? size_18 : size_20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Are you sure, that you want to delete your account?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black54,
                  fontSize: Platform.isAndroid ? size_14 : size_14),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.hovered) ||
                            states.contains(MaterialState.pressed)) {
                          return colors.buttonColor;
                        }
                        return Theme.of(context).brightness == Brightness.dark
                            ? colors.overlayBG
                            : Colors.white; // Default color
                      }),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      side: MaterialStateProperty.all(BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : colors.lightBorder,
                          width: 1)),
                    ),
                    onPressed: () {
                      Routes.navigateToPreviousScreen(context);
                    },
                    child: Text(
                      'CANCEL',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: Platform.isAndroid ? size_10 : size_12,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.hovered) ||
                            states.contains(MaterialState.pressed)) {
                          return colors.red;
                        }
                        return colors.red;
                      }),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Routes.navigateToPreviousScreen(context);

                      provider.deleteAccount(context);
                    },
                    child: Text(
                      'Delete',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontSize: Platform.isAndroid ? size_10 : size_12,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
