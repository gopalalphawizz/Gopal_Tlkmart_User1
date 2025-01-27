import 'dart:io';

import 'package:alpha_ecommerce_18oct/utils/app_dimens/app_dimens.dart';
import 'package:alpha_ecommerce_18oct/utils/routes.dart';
import 'package:alpha_ecommerce_18oct/view/home/models/productsModel.dart';
import 'package:alpha_ecommerce_18oct/viewModel/productViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../utils/color.dart';
import '../../utils/images.dart';

productRatingAndFollowersCard(
    Shop shop, BuildContext ctx, ProductDetailViewModel model) {
  bool isFollowing = shop.isFollowing == "0" ? false : true;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
        color: Theme.of(ctx).brightness == Brightness.dark
            ? Colors.transparent
            : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0x14E9E9E9),
        )),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: shop.image,
                  height: size_55,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => Image.asset(
                    Images.defaultProductImg,
                    height: size_55,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  shop.name,
                  style: Theme.of(ctx).textTheme.titleSmall!.copyWith(
                      color: Theme.of(ctx).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                )
              ],
            ),
            Image.asset(
              Images.trusted,
              height: 40,
              width: 60,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          shop.rating,
                          style: Theme.of(ctx).textTheme.titleSmall!.copyWith(
                                color: Colors.orange,
                                fontSize:
                                    Platform.isAndroid ? size_12 : size_14,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Rating",
                      style: Theme.of(ctx).textTheme.titleSmall!.copyWith(
                          color: Theme.of(ctx).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black),
                    )
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          shop.followers,
                          style: Theme.of(ctx).textTheme.titleSmall!.copyWith(
                                color:
                                    Theme.of(ctx).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                fontSize:
                                    Platform.isAndroid ? size_12 : size_14,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Followers",
                      style: Theme.of(ctx).textTheme.titleSmall!.copyWith(
                          color: Theme.of(ctx).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black),
                    )
                  ],
                ),
              ],
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Map data = {'shop_id': shop.id.toString()};
                isFollowing = !isFollowing;
                model.followVendor(data, ctx);
              },
              child: Container(
                  height: 40,
                  width: 70,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: colors.buttonColor,
                      shape: BoxShape.rectangle),
                  child: Text(isFollowing ? "Unfollow" : "Follow",
                      style: Theme.of(ctx).textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                          fontSize: Platform.isAndroid ? size_10 : size_12))),
              //  Icon(
              //   Icons.arrow_forward_ios_outlined,
              //   color: colors.textColor,
              // )),
            ),
          ],
        )
      ],
    ),
  );
}
