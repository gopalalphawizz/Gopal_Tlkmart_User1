import 'dart:io';

import 'package:alpha_ecommerce_18oct/utils/app_dimens/app_dimens.dart';
import 'package:alpha_ecommerce_18oct/view/home/models/productsModel.dart';
import 'package:alpha_ecommerce_18oct/view/widget_common/imageErrorWidget.dart';
import 'package:alpha_ecommerce_18oct/viewModel/homeViewModel.dart';
import 'package:alpha_ecommerce_18oct/viewModel/searchViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../../utils/color.dart';
import '../../../utils/routes.dart';

productForYouCardSearch(ProductList model, BuildContext context,
    HomeViewModel homeProvider, SearchViewModel searchProvider) {
  return Column(
    children: [
      InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          Routes.navigateToProductDetailPageScreen(context, model.slug);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.31,
          width: MediaQuery.of(context).size.width * 0.44,
          decoration: BoxDecoration(
              // image: DecorationImage(image: NetworkImage(model.images.first)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              gradient: Theme.of(context).brightness == Brightness.dark
                  ? LinearGradient(
                      colors: [
                        colors.boxGradient1.withOpacity(1),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : LinearGradient(
                      colors: [
                        Color(0xFFE4E2ED),
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
              border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? colors.boxBorder
                      : colors.lightBorder)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Routes.navigateToProductDetailPageScreen(
                        context, model.slug);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(model.thumbnail),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${model.discount_string}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: Platform.isAndroid
                                          ? size_10
                                          : size_12,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w600)),
                          LikeButton(
                            onTap: (isLiked) async {
                              Map data = {'product_id': model.id.toString()};
                              if (isLiked) {
                                searchProvider.isHome = false;

                                return homeProvider.removeFromWishlist(
                                    data, context);
                              } else {
                                return homeProvider.addToWishlist(
                                    data, context);
                              }
                            },
                            size: size_20,
                            isLiked: model.isFavorite,
                            circleColor: const CircleColor(
                                start: Colors.red, end: Colors.red),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Colors.red,
                              dotSecondaryColor: Colors.red,
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked ? Colors.pink : Colors.grey,
                                size: 20,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(model.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          Text(model.specialPrice,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: Platform.isAndroid
                                          ? size_10
                                          : size_12,
                                      color: Colors.cyan,
                                      fontWeight: FontWeight.w600)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(model.unitPrice,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize:
                                          Platform.isAndroid ? size_9 : size_11,
                                      decoration: TextDecoration.lineThrough,
                                      color: colors.lightTextColor,
                                      fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Map<String, String> data;
                          if (!model.isCart) {
                            try {
                              for (int i = 0;
                                  i < model.choiceOptions.length;
                                  i++) {
                                Map<String, String> map = {
                                  model.choiceOptions[i].name:
                                      model.choiceOptions[i].options[0]
                                };

                                homeProvider.selectedVariationMap.add(map);
                              }
                            } catch (stacktrace) {}

                            data = {
                              'id': model.id.toString(),
                              'quantity': "1",
                              'color': model.colorsFormatted.isNotEmpty
                                  ? model.colorsFormatted[0].code
                                  : "",
                            };
                          } else {
                            data = {
                              'key': model.cart_id.toString(),
                            };
                          }
                          model.isCart
                              ? homeProvider.removeFromCart(data, context)
                              : homeProvider.addToCart(data, context);
                        },
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: colors.boxBorder)),
                          child: Text(
                            model.isCart ? "Remove From Cart" : "Add to Cart",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize:
                                        Platform.isAndroid ? size_10 : size_12,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? colors.textColor
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //  spaceOfHeight(),
    ],
  );
}


// GridView.builder(
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 3, // number of items in each row
//     mainAxisSpacing: 8.0, // spacing between rows
//     crossAxisSpacing: 8.0, // spacing between columns
//   ),
//   padding: EdgeInsets.all(8.0), // padding around the grid
//   itemCount: items.length, // total number of items
//   itemBuilder: (context, index) {
//     return Container(
//       color: Colors.blue, // color of grid items
//       child: Center(
//         child: Text(
//           items[index],
//           style: Theme.of(context)
                                                    // .textTheme
                                                    // .titleSmall!
                                                    // .copyWith(
                                                    //   fontSize: Platform.isAndroid
                                                  // ? size_16
                                                  // : size_18.0, color: Colors.white),
//         ),
//       ),
//     );
//   },
// )
