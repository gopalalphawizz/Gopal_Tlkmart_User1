import 'dart:io';

import 'package:alpha_ecommerce_18oct/utils/app_dimens/app_dimens.dart';
import 'package:alpha_ecommerce_18oct/utils/images.dart';
import 'package:alpha_ecommerce_18oct/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../utils/color.dart';
import '../widget_common/common_button.dart';

class RateUs extends StatefulWidget {
  @override
  _RateUsState createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  double rating = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: colors.overlayBG,
      ),
      height: 300,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Images.rateUs,
            width: 80,
            height: 80,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Rate Us!',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                  fontSize: Platform.isAndroid ? size_18 : size_20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'How would you love this app?',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: colors.greyText),
          ),
          SizedBox(
            height: 20,
          ),
          RatingBar.builder(
            initialRating: rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 30,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: colors.buttonColor,
            ),
            onRatingUpdate: (newRating) {
              setState(() {
                rating = newRating;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 150,
            child: CommonButton(
                text: "RATE US",
                fontSize: Platform.isAndroid ? size_14 : size_14,
                onClick: () {
                  Routes.navigateToPreviousScreen(context);
                }),
          ),
        ],
      ),
    );
  }
}
