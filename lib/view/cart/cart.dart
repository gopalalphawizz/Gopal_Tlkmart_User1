import 'dart:io';

import 'package:alpha_ecommerce_18oct/utils/app_dimens/app_dimens.dart';
import 'package:alpha_ecommerce_18oct/utils/routes.dart';
import 'package:alpha_ecommerce_18oct/utils/shared_pref..dart';
import 'package:alpha_ecommerce_18oct/utils/utils.dart';
import 'package:alpha_ecommerce_18oct/view/cart/cards/cartCard.dart';
import 'package:alpha_ecommerce_18oct/view/cart/cards/savedItemCard.dart';
import 'package:alpha_ecommerce_18oct/view/widget_common/appLoader.dart';
import 'package:alpha_ecommerce_18oct/viewModel/addressViewModel.dart';
import 'package:alpha_ecommerce_18oct/viewModel/cartViewModel.dart';
import 'package:alpha_ecommerce_18oct/viewModel/homeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/color.dart';
import '../../utils/images.dart';
import '../widget_common/commonBackground.dart';
import '../widget_common/common_button.dart';
import '../widget_common/common_header.dart';
import '../profile/common_header.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late CartViewModel cartProvider;
  late HomeViewModel chomeProvider;
  late AddressViewModel addressProvider;
  bool apiHitted = false;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    cartProvider = Provider.of<CartViewModel>(context, listen: false);
    addressProvider = Provider.of<AddressViewModel>(context, listen: false);
    chomeProvider = Provider.of<HomeViewModel>(context, listen: false);
    chomeProvider.isScrolled = true;

    callAddress();

    SharedPref.shared.pref!.setString(PrefKeys.groupIDForBUY, "");

    if (cartProvider.selectedOption == "Normal Delivery") {
      cartProvider.getCartListItem(context, "", "0", "", "", "");
    } else {
      cartProvider.getCartListItem(context, "", "1", "", "", "");
    }

    handleOptionChange(cartProvider.selectedOption);
    //cartProvider.getSavedListItem(context);
  }

  callAddress() async {
    apiHitted = true;
    await addressProvider.getAddressList(context);
    //  setState(() {});
  }

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    cartProvider = Provider.of<CartViewModel>(context);
    chomeProvider = Provider.of<HomeViewModel>(context);
    addressProvider = Provider.of<AddressViewModel>(context);
    chomeProvider.isScrolled = true;
    print(chomeProvider.isScrolled.toString());
    if (cartProvider.couponController.text == "") {}
    if (addressProvider.addressList.isEmpty && !apiHitted) {
      if (cartProvider.isLoading) {
        Future.delayed(Duration(seconds: 3), () {
          callAddress();
        });
      } else {
        callAddress();
      }
    }
    return Stack(
      children: [
        const LightBackGround(),
        RefreshIndicator(
          color: colors.buttonColor,
          backgroundColor: Colors.white,
          displacement: 40.0,
          strokeWidth: 2.0,
          semanticsLabel: 'Pull to refresh',
          semanticsValue: 'Refresh',
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
            callAddress();
            if (cartProvider.selectedOption == "Normal Delivery") {
              cartProvider.getCartListItem(context, "", "0", "", "", "");
            } else {
              cartProvider.getCartListItem(context, "", "1", "", "", "");
            }

            handleOptionChange(cartProvider.selectedOption);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            extendBody: true,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.transparent
                : Colors.white,
            body: Column(
              children: [
                Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.transparent
                      : colors.buttonColor,
                  child:  Stack(
                    children: [
                      ProfileHeader(),
                      DashboardHeader(),
                    ],
                  ),
                ),
                Expanded(
                  child: cartProvider.isLoading
                      ? appLoader()
                      : SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              cartProvider.cartModel.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text("Shipping Adddress",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? colors.textColor
                                                      : Colors.black,
                                                  fontSize: size_11))),
                              cartProvider.cartModel.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: colors.buttonColor,
// Set your desired border color
                                            width: 2.0, // Set the border width
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ), // Adjust the radius as needed

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      addressProvider
                                                              .addressList
                                                              .isEmpty
                                                          ? const Icon(
                                                              Icons.location_on,
                                                              color: colors
                                                                  .buttonColor,
                                                            )
                                                          : Icon(
                                                              Icons.pin_drop,
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? colors
                                                                      .textColor
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      addressProvider
                                                              .addressList
                                                              .isEmpty
                                                          ? InkWell(
                                                              onTap: () {
                                                                Routes
                                                                    .navigateToManageAddressScreen(
                                                                        context);
                                                              },
                                                              child: Text(
                                                                "Add new address",
                                                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                                    color: Theme.of(context).brightness ==
                                                                            Brightness
                                                                                .dark
                                                                        ? colors
                                                                            .textColor
                                                                        : Colors
                                                                            .black,
                                                                    fontSize: Platform
                                                                            .isAndroid
                                                                        ? size_14
                                                                        : size_16),
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.63,
                                                              child: Text(
                                                                addressProvider
                                                                    .selectedAddress,
                                                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                                    color: Theme.of(context).brightness ==
                                                                            Brightness
                                                                                .dark
                                                                        ? colors
                                                                            .textColor
                                                                        : Colors
                                                                            .black,
                                                                    fontSize: Platform
                                                                            .isAndroid
                                                                        ? size_10
                                                                        : size_12),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                      cartProvider
                                                              .cartModel.isEmpty
                                                          ? Container()
                                                          : addressProvider
                                                                  .addressList
                                                                  .isEmpty
                                                              ? const Icon(Icons
                                                                  .arrow_forward_ios_rounded)
                                                              : InkWell(
                                                                  onTap: () {
                                                                    Routes.navigateToAddressListScreen(
                                                                        context,
                                                                        true);
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    child: Text(
                                                                      "(Change)",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .copyWith(
                                                                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : colors.buttonColor,
                                                                              fontSize: Platform.isAndroid ? size_12 : size_15),
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              // cartProvider.cartModel.isEmpty
                              //     ? Container()
                              //     : Divider(
                              //         color: Theme.of(context).brightness ==
                              //                 Brightness.dark
                              //             ? colors.textColor
                              //             : Colors.black,
                              //         height: 1,
                              //       ),
                              const SizedBox(height: 10),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Cart List",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontSize: Platform.isAndroid
                                                  ? size_14
                                                  : size_16,
                                              color: colors.buttonColor,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     Routes.navigateToDashboardScreen(
                                    //         context, 2);
                                    //   },
                                    //   child: Text(
                                    //     "Back",
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .titleSmall!
                                    //         .copyWith(
                                    //             fontSize: Platform.isAndroid
                                    //                 ? size_14
                                    //                 : size_16,
                                    //             color: colors.buttonColor,
                                    //             fontWeight: FontWeight.w600),
                                    //     // style: Theme.of(context)
                                    //     // .textTheme
                                    //     // .titleSmall!
                                    //     // .copyWith(

                                    //     //     color: Theme.of(context).brightness ==
                                    //     //             Brightness.dark
                                    //     //         ? colors.textColor
                                    //     //         : Colors.black,
                                    //     //     fontSize: Platform.isAndroid ? size_18 : size_20,
                                    //     //     fontWeight: FontWeight.bold),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              cartProvider.cartModel.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/Cart_empty.png',
                                            height: size_150,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "No item in cart.",
                                            style: TextStyle(
                                              color: colors.greyText,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: cartCardRow(
                                                context,
                                                cartProvider.cartModel,
                                                cartProvider),
                                          ),
                                        ),
                                      ),
                                    ),
                              cartProvider.cartModel.isEmpty
                                  ? Container()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, top: 20),
                                          child: Text(
                                            "Delivery type",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    fontSize: Platform.isAndroid
                                                        ? size_12
                                                        : size_14,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? colors.textColor
                                                        : Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            // style: Theme.of(context)
                                            // .textTheme
                                            // .titleSmall!
                                            // .copyWith(

                                            //     color: Theme.of(context)
                                            //                 .brightness ==
                                            //             Brightness.dark
                                            //         ? colors.textColor
                                            //         : Colors.black,
                                            //     fontSize: Platform.isAndroid ? size_14 : size_14,
                                            //     fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor:
                                                    colors.greyText),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: RadioListTile(
                                                      title: Text(
                                                        'Normal Delivery',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontSize:
                                                                    size_14,
                                                                color: Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        // style: Theme.of(context)
                                                        // .textTheme
                                                        // .titleSmall!
                                                        // .copyWith(

                                                        //   color: Theme.of(context)
                                                        //               .brightness ==
                                                        //           Brightness
                                                        //               .light
                                                        //       ? Colors.black
                                                        //       : Colors.white,
                                                        //   fontSize: Platform.isAndroid ? size_14 : size_14,
                                                        // ),
                                                        softWrap: false,
                                                      ),
                                                      activeColor:
                                                          colors.buttonColor,
                                                      groupValue: cartProvider
                                                          .selectedOption,
                                                      onChanged: (value) {
                                                        handleOptionChange(
                                                            "Normal Delivery");
                                                      },
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 0),
                                                      value: 'Normal Delivery',
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: RadioListTile(
                                                      dense: true,
                                                      title: Text(
                                                        'Alpha Delivery',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontSize:
                                                                    size_14,
                                                                color: Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        softWrap: false,
                                                      ),
                                                      activeColor:
                                                          colors.buttonColor,
                                                      groupValue: cartProvider
                                                          .selectedOption,
                                                      onChanged: (value) {
                                                        handleOptionChange(
                                                            "Alpha Delivery");
                                                      },
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 0),
                                                      value: 'Alpha Delivery',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              cartProvider.cartModel.isEmpty
                                  ? Container()
                                  : Container(
                                      // height:
                                      //     MediaQuery.of(context).size.height *
                                      //         .25,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? const Color(0x14E9E9E9)
                                            : Color(0xFFE3E1EC),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Text(
                                              "Price Detail",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontSize:
                                                          Platform.isAndroid
                                                              ? size_12
                                                              : size_14,
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? colors.textColor
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                              // style: Theme.of(context)
                                              // .textTheme
                                              // .titleSmall!
                                              // .copyWith(

                                              //     color: Theme.of(context)
                                              //                 .brightness ==
                                              //             Brightness.dark
                                              //         ? colors.textColor
                                              //         : Colors.black,
                                              //     fontSize: Platform.isAndroid ? size_14 : size_14),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                int.parse(cartProvider.model
                                                            .data.totalItems) <
                                                        2
                                                    ? Text(
                                                        "MRP (${cartProvider.model.data.totalItems} item)",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                color: Theme.of(
                                                                                context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .dark
                                                                    ? colors
                                                                        .textColor
                                                                    : Colors
                                                                        .black,
                                                                fontSize: Platform
                                                                        .isAndroid
                                                                    ? size_10
                                                                    : size_12),
                                                      )
                                                    : Text(
                                                        "MRP (${cartProvider.model.data.totalItems} items)",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? colors
                                                                      .textColor
                                                                  : Colors
                                                                      .black,
                                                              fontSize: Platform
                                                                      .isAndroid
                                                                  ? size_10
                                                                  : size_12,
                                                            ),
                                                      ),
                                                Text(
                                                  cartProvider.model.data.mrp,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_10
                                                                  : size_12,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.textColor
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Delivery fee",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_10
                                                                  : size_12,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.greyText
                                                              : Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  // style: Theme.of(context)
                                                  // .textTheme
                                                  // .titleSmall!
                                                  // .copyWith(

                                                  //     color: Theme.of(context)
                                                  //                 .brightness ==
                                                  //             Brightness.dark
                                                  //         ? colors.greyText
                                                  //         : Colors.black54,
                                                  //     fontSize: 12),
                                                ),
                                                Text(
                                                  cartProvider.model.data
                                                      .deliveryCharge,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_10
                                                                  : size_12,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.textColor
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Tax",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_10
                                                                  : size_12,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.greyText
                                                              : Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                Text(
                                                  cartProvider.model.data.tax,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_10
                                                                  : size_12,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.textColor
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Discount (Product)",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_10
                                                                  : size_12,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.greyText
                                                              : Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                Text(
                                                  "- " +
                                                      cartProvider
                                                          .model.data.discount,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_10
                                                                  : size_12,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.textColor
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  // style: Theme.of(context)
                                                  // .textTheme
                                                  // .titleSmall!
                                                  // .copyWith(

                                                  //     color: Theme.of(context)
                                                  //                 .brightness ==
                                                  //             Brightness.dark
                                                  //         ? colors.textColor
                                                  //         : Colors.black,
                                                  //     fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Discount (Coupon)",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_10
                                                                  : size_12,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.greyText
                                                              : Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                Text(
                                                  "- " +
                                                      cartProvider.model.data
                                                          .coupon_discount,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_10
                                                                  : size_12,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.textColor
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  // style: Theme.of(context)
                                                  // .textTheme
                                                  // .titleSmall!
                                                  // .copyWith(

                                                  //     color: Theme.of(context)
                                                  //                 .brightness ==
                                                  //             Brightness.dark
                                                  //         ? colors.textColor
                                                  //         : Colors.black,
                                                  //     fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            height: 5,
                                            color: colors.greyText,
                                            thickness: 1,
                                            indent: 10,
                                            endIndent: 10,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Total Amount",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_12
                                                                  : size_14,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.textColor
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                                Text(
                                                  cartProvider.model.data.total,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_12
                                                                  : size_14,
                                                          color: colors
                                                              .buttonColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                  // style: Theme.of(context)
                                                  // .textTheme
                                                  // .titleSmall!
                                                  // .copyWith(

                                                  //     color: colors.buttonColor,
                                                  //     fontSize: Platform.isAndroid ? size_14 : size_14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: size_5,
                                          )
                                        ],
                                      ),
                                    ),
                              cartProvider.cartModel.isEmpty
                                  ? Container()
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Offer & Benefits",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? colors.textColor
                                                        : Colors.black,
                                                    fontSize: Platform.isAndroid
                                                        ? size_12
                                                        : size_14),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.cartOffer,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? colors.textColor
                                                    : Colors.black,
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: () {
                                                  Routes.navigateToCouponScreen(
                                                      context);
                                                },
                                                child: Text(
                                                  "View Offer",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? colors.textColor
                                                              : Colors.black,
                                                          fontSize:
                                                              Platform.isAndroid
                                                                  ? size_12
                                                                  : size_14),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                              cartProvider.cartModel.isEmpty
                                  ? Container()
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 40,
                                              child: TextField(
                                                onTap: () {
                                                  _scrollToBottom();
                                                },
                                                enabled: double.parse(cartProvider
                                                                .model
                                                                .data
                                                                .coupon_discount
                                                                .substring(
                                                                    1,
                                                                    cartProvider
                                                                        .model
                                                                        .data
                                                                        .coupon_discount
                                                                        .length))
                                                            .toInt() ==
                                                        0
                                                    ? true
                                                    : false,
                                                controller: cartProvider
                                                    .couponController,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black),
                                                cursorColor: Colors.white,
                                                textAlign: TextAlign.start,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                  hintText: 'Voucher Number',
                                                  hintStyle: TextStyle(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? colors.greyText
                                                        : Colors.black45,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: colors.boxBorder,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color:
                                                          colors.textFieldColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                              height: 40,
                                              width: 110,
                                              child: CommonButton(
                                                  text: double.parse(cartProvider
                                                                  .model
                                                                  .data
                                                                  .coupon_discount
                                                                  .substring(
                                                                      1,
                                                                      cartProvider
                                                                          .model
                                                                          .data
                                                                          .coupon_discount
                                                                          .length))
                                                              .toInt() ==
                                                          0
                                                      ? "APPLY"
                                                      : "REMOVE",
                                                  fontSize: Platform.isAndroid
                                                      ? size_12
                                                      : size_14,
                                                  colorsText: Colors.white,
                                                  onClick: () {
                                                    if (cartProvider
                                                        .couponController
                                                        .text
                                                        .isNotEmpty) {
                                                      if (double.parse(cartProvider
                                                                  .model
                                                                  .data
                                                                  .coupon_discount
                                                                  .substring(
                                                                      1,
                                                                      cartProvider
                                                                          .model
                                                                          .data
                                                                          .coupon_discount
                                                                          .length))
                                                              .toInt() ==
                                                          0) {
                                                        cartProvider.applyCoupon(
                                                            cartProvider
                                                                .couponController
                                                                .text,
                                                            context);
                                                      } else {
                                                        cartProvider
                                                            .couponController
                                                            .text = "";
                                                        cartProvider
                                                            .applyCoupon(
                                                                '', context);
                                                      }
                                                    } else {
                                                      Utils.showFlushBarWithMessage(
                                                          "",
                                                          "Please enter coupon code.",
                                                          context);
                                                    }
                                                  })),
                                        ],
                                      ),
                                    ),
                              cartProvider.savedModel.isEmpty
                                  ? SizedBox(
                                      height: isKeyboardOpen
                                          ? size_200 * 0.9
                                          : size_10,
                                    )
                                  : Container(),
                              cartProvider.savedModel.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text(
                                        "Saved Items",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? colors.textColor
                                                    : Colors.black,
                                                fontSize: Platform.isAndroid
                                                    ? size_12
                                                    : size_14),
                                      ),
                                    )
                                  : Container(),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: savedCardsRow(
                                            context,
                                            cartProvider.savedModel,
                                            cartProvider)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                cartProvider.isLoading
                    ? Container()
                    : cartProvider.cartModel.isEmpty
                        ? Container()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              //  height: MediaQuery.of(context).size.height * .08,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? colors.textFieldBG
                                  : Colors.white,
                              child: Center(
                                child: Column(
                                  children: [
                                    cartProvider.cartModel.isEmpty
                                        ? Container()
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                            height: 50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  cartProvider.model.data.total,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                        fontSize:
                                                            Platform.isAndroid
                                                                ? size_18
                                                                : size_20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? colors.textColor
                                                            : Colors.black,
                                                      ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0.0),
                                                  child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .2,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .37,
                                                      child: CommonButton(
                                                        text: "PLACE ORDER",
                                                        fontSize:
                                                            Platform.isAndroid
                                                                ? size_11
                                                                : size_13,
                                                        colorsText:
                                                            Colors.white,
                                                        onClick: () async {
                                                          if (!addressProvider
                                                              .addressList
                                                              .isEmpty) {
                                                            var billingId = SharedPref
                                                                    .shared
                                                                    .pref!
                                                                    .getString(
                                                                        PrefKeys
                                                                            .billingAddressID) ??
                                                                addressProvider
                                                                    .addressList[
                                                                        0]
                                                                    .id
                                                                    .toString();
                                                            var paymentMethod =
                                                                "cash_on_delivery";
                                                            String couponCode =
                                                                cartProvider
                                                                    .couponController
                                                                    .text;
                                                            var groupOd = SharedPref
                                                                    .shared
                                                                    .pref!
                                                                    .getString(
                                                                        PrefKeys
                                                                            .groupIDForBUY) ??
                                                                "";
                                                            String data =
                                                                "billing_address_id=$billingId&payment_method=$paymentMethod&transaction_id=${cartProvider.generateRandomTransactionID()}&is_wallet_used=0&wallet_amount=0&order_note=This is a order note.&coupan_code=$couponCode&coupan_amount=&coin_used=0&group_id=$groupOd";

                                                            var res = await cartProvider
                                                                .checkDeliveryStatus(
                                                                    context,
                                                                    billingId
                                                                        .toString());

                                                            print(res
                                                                    .toString() +
                                                                "CHECK AVAILABILITY");

                                                            if (res) {
                                                              Routes.navigateToPaymentScreen(
                                                                  context,
                                                                  data,
                                                                  billingId,
                                                                  couponCode,
                                                                  true,
                                                                  "order",
                                                                  cartProvider
                                                                      .model
                                                                      .data
                                                                      .coupon_discount
                                                                      .substring(
                                                                          1,
                                                                          cartProvider
                                                                              .model
                                                                              .data
                                                                              .coupon_discount
                                                                              .length));
                                                            } else {
                                                              // if (res)
                                                              //   Utils.showFlushBarWithMessage(
                                                              //       "",
                                                              //       "Delivery not available on this pincode.",
                                                              //       context);
                                                            }
                                                          } else {
                                                            Utils.showFlushBarWithMessage(
                                                                "",
                                                                "Please add address first.",
                                                                context);
                                                          }
                                                        },
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
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

  void handleOptionChange(String value) {
    setState(() {
      cartProvider.selectedOption = value;
      if (value == "Alpha Delivery") {
        print(value);
        cartProvider.getCartListItem(
            context, cartProvider.couponController.text, "1", "0", "", "");
      } else {
        cartProvider.getCartListItem(
            context, cartProvider.couponController.text, "0", "0", "", "");
      }
    });
  }
}
