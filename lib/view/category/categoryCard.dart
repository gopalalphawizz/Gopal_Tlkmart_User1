import 'dart:io';

import 'package:alpha_ecommerce_18oct/utils/app_dimens/app_dimens.dart';
import 'package:alpha_ecommerce_18oct/view/home/models/categoryModel.dart';
import 'package:alpha_ecommerce_18oct/view/widget_common/imageErrorWidget.dart';
import 'package:alpha_ecommerce_18oct/viewModel/searchViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/category.dart';
import '../../utils/routes.dart';

categoryCard(
    {required BuildContext context,
    required categoryIndex,
    required categoryListIndex,
    required Childes model,
    required SearchViewModel searchProvider,
    required String categoryId,
    required bool isComingFromHome}) {
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: () {
      // searchProvider.categoryId = categoryId;
      searchProvider.subCategoryId = model.id!.toString();
      searchProvider.brandId = "";
      print("Category Id ${searchProvider.categoryId}");
      print("Sub Category Id ${searchProvider.subCategoryId}");

      searchProvider.isHome = isComingFromHome;
      print(searchProvider.isHome.toString() + "Searchh isHOME");
      if (isComingFromHome) {
        Routes.navigateToPreviousScreen(context);
      } else {
        searchProvider.offerId = "";
        searchProvider.offerPercentage = "";
        searchProvider.brandId = "";
        Routes.navigateToSearchScreen(context, false);
      }
      searchProvider.getProductsListNew(context, "25", "1");
    },
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: model.icon!,
            height: 70,
            width: 90,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => ErrorImageWidget(),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.name!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontSize: Platform.isAndroid ? size_10 : size_12,
                ),
          ),
        ],
      ),
    ),
  );
}
