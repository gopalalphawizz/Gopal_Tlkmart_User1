import 'dart:io';

import 'package:alpha_ecommerce_18oct/utils/app_dimens/app_dimens.dart';
import 'package:alpha_ecommerce_18oct/view/home/models/productsModel.dart';
import 'package:alpha_ecommerce_18oct/view/order/orderDetailDelivered.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utils/images.dart';

reviewCard(Review rating, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 212, 212, 212),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: rating.customer.image,
                  height: size_45,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => Image.asset(
                    Images.defaultProductImg,
                    height: size_45,
                  ),
                ),

                //Image.asset(Images.profile),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 220,
                      child: Text(
                        rating.customer.name == ""
                            ? "Anonyms"
                            : rating.customer.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: rating.rating.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 15,
                      itemPadding: const EdgeInsets.only(right: 5),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      onRatingUpdate: (newRating) {
                        //rating = newRating;
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              rating.comment,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: Platform.isAndroid ? size_10 : size_12,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            rating.attachment.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FullImageDialog(
                            image: rating.attachment.first,
                          );
                        },
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: rating.attachment.first,
                      height: size_100,
                      width: size_100,
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) => Image.asset(
                        Images.defaultProductImg,
                        height: size_100,
                        width: size_100,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    ),
  );
}
