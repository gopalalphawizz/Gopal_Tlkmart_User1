import 'dart:io';

import 'package:alpha_ecommerce_18oct/repository/couponRepository.dart';
import 'package:alpha_ecommerce_18oct/repository/orderRepository.dart';
import 'package:alpha_ecommerce_18oct/repository/vendorRepository.dart';
import 'package:alpha_ecommerce_18oct/utils/appUrls.dart';
import 'package:alpha_ecommerce_18oct/utils/routes.dart';
import 'package:alpha_ecommerce_18oct/utils/shared_pref..dart';
import 'package:alpha_ecommerce_18oct/utils/utils.dart';
import 'package:alpha_ecommerce_18oct/view/home/models/productsModel.dart';
import 'package:alpha_ecommerce_18oct/view/order/model/orderDetailModel.dart';
import 'package:alpha_ecommerce_18oct/view/order/model/ordersModel.dart';
import 'package:alpha_ecommerce_18oct/view/order/model/returnOrderModel.dart';
import 'package:alpha_ecommerce_18oct/viewModel/homeViewModel.dart';
import 'package:alpha_ecommerce_18oct/viewModel/networkViewModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:http_parser/http_parser.dart';

class OrderViewModel with ChangeNotifier {
  List<OrdersList> orderList = [];
  late DetailsData detail;
  late ReturnOrderModel returnDetail;
  List<ProductList> RecommendedProducts = [];
  bool isLoading = false;
  Filters filters = Filters();
  var status = "";
  List<Map<String, dynamic>> selectedVariationMap = [];
  File? selectedImage;

  TextEditingController searchText = TextEditingController();
  var categorie = "";

  bool get loading => isLoading;
  final _myRepo = OrderRepository();

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getOrderList(
    BuildContext context,
  ) async {
    setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    NetworkViewModel networkProvider =
        Provider.of<NetworkViewModel>(context, listen: false);

    var isInternetAvailable = await networkProvider.checkInternetAvailability();
    if (!isInternetAvailable) {
      setLoading(false);

      Utils.showFlushBarWithMessage("", "No Internet Connection", context);
    } else {
      await _myRepo
          .orderListRequest(
              AppUrl.orderList +
                  "?status=" +
                  status +
                  "&categorie=" +
                  categorie +
                  "&search_text=" +
                  searchText.text,
              token)
          .then((value) {
        try {
          orderList = value.data!;
          filters = value.filters!;
          print(orderList.length.toString() + "OORDER LENTH");
        } catch (stackTrace) {
          print(stackTrace.toString() + "ORder Error");
        }

        setLoading(false);

        notifyListeners();
      }).onError((error, stackTrace) {
        setLoading(false);
        notifyListeners();
        print(stackTrace.toString() + "ORder Error");
      });
    }
  }

  Future<void> getOrderDetail(
      BuildContext context, String order_id, bool showLoader) async {
    if (showLoader) {
      setLoading(true);
    }
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    print(token);
    print(order_id + "ID");
    NetworkViewModel networkProvider =
        Provider.of<NetworkViewModel>(context, listen: false);

    var isInternetAvailable = await networkProvider.checkInternetAvailability();
    if (!isInternetAvailable) {
      setLoading(false);

      Utils.showFlushBarWithMessage("", "No Internet Connection", context);
    } else {
      await _myRepo
          .orderDetailRequest(AppUrl.orderDetail, token, order_id)
          .then((value) {
        detail = value.data!;
        RecommendedProducts = value.recommendedProducts;
        // print("detail ${detail.shippingAddress!.address!}");

        setLoading(false);
        notifyListeners();
      }).onError((error, stackTrace) {
        setLoading(false);
        print(stackTrace.toString() + "API ERRORR ORDER DETAIL");
      });
    }
  }

  Future<void> getRetuurnOrderDetail(
      BuildContext context, String order_id) async {
    setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    print(token);
    print(order_id + "ID");
    NetworkViewModel networkProvider =
        Provider.of<NetworkViewModel>(context, listen: false);

    var isInternetAvailable = await networkProvider.checkInternetAvailability();
    if (!isInternetAvailable) {
      setLoading(false);

      Utils.showFlushBarWithMessage("", "No Internet Connection", context);
    } else {
      await _myRepo
          .orderDetailReturnRequest(
        AppUrl.orderReturnDetail + order_id,
        token,
      )
          .then((value) {
        returnDetail = value;

        setLoading(false);
        notifyListeners();
      }).onError((error, stackTrace) {
        setLoading(false);
        print(stackTrace.toString() + "API ERRORR ORDER DETAIL");
      });
    }
  }

  Future<void> postOrderReturnRequest(
      {required String order_id,
      required String reason,
      required String amount,
      required BuildContext context}) async {
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    NetworkViewModel networkProvider =
        Provider.of<NetworkViewModel>(context, listen: false);

    var isInternetAvailable = await networkProvider.checkInternetAvailability();
    if (!isInternetAvailable) {
      setLoading(false);

      Utils.showFlushBarWithMessage("", "No Internet Connection", context);
    } else {
      await _myRepo
          .orderReturnRequest(
              api: AppUrl.orderReturn,
              bearerToken: token,
              order_id: order_id,
              amount: amount,
              refund_reason: reason)
          .then((value) {
        getOrderList(context);
        Routes.navigateToPreviousScreen(context);
        Routes.navigateToPreviousScreen(context);
        Routes.navigateToPreviousScreen(context);
        Utils.showFlushBarWithMessage("", value.message, context);
      });
    }
  }

  Future<void> getOrderCancelRequest(
      {required String order_id,
      required String reason,
      required BuildContext context}) async {
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    NetworkViewModel networkProvider =
        Provider.of<NetworkViewModel>(context, listen: false);

    var isInternetAvailable = await networkProvider.checkInternetAvailability();
    if (!isInternetAvailable) {
      setLoading(false);

      Utils.showFlushBarWithMessage("", "No Internet Connection", context);
    } else {
      await _myRepo
          .orderCancelRequest(
              api: AppUrl.orderCancel +
                  "?order_id=" +
                  order_id +
                  "&remarks=" +
                  reason,
              bearerToken: token,
              order_id: order_id,
              cancel_reason: reason)
          .then((value) {
        if (value.status) {
          Navigator.pop(context);
          Routes.navigateToOrderCancelledScreen(context, order_id);
        } else {
          Navigator.pop(context);
        }
        Utils.showFlushBarWithMessage("", value.message, context);
      });
    }
  }

  Future<bool> cancelOrder(
      {required String order_id,
      required String reason,
      required BuildContext context}) async {
    setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;

    _myRepo
        .cancelOrder(
            AppUrl.orderCancel + "?order_id=" + order_id + "&remarks=" + reason,
            token)
        .then((value) {
      setLoading(false);
      Navigator.pop(context);
      Navigator.pop(context);
      Utils.showFlushBarWithMessage("Alert", value.message, context);
      getOrderList(context);

      print(value.message);

      return true;
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
      Utils.showFlushBarWithMessage("Alert", error.toString(), context);
      return false;
    });
    return false;
  }

//Funcation to submit order review
  Future<void> postOrderReviewRequest(
      {required String order_id,
      required String comment,
      required String rating,
      required String product_id,
      required BuildContext context}) async {
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    NetworkViewModel networkProvider =
        Provider.of<NetworkViewModel>(context, listen: false);

    var isInternetAvailable = await networkProvider.checkInternetAvailability();
    if (!isInternetAvailable) {
      setLoading(false);

      Utils.showFlushBarWithMessage("", "No Internet Connection", context);
    } else {
      await _myRepo
          .orderReviewRequest(
              api: AppUrl.writeReview,
              bearerToken: token,
              order_id: order_id,
              product_id: product_id,
              comment: comment,
              rating: rating)
          .then((value) async {
        Routes.navigateToPreviousScreen(
          context,
        );
        Utils.showFlushBarWithMessage("", value.message, context);
        await getOrderDetail(context, order_id, true);
      });
    }
  }

  Future<void> deleteReviewRequest(
      {required String order_id,
      required String id,
      required BuildContext context}) async {
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    NetworkViewModel networkProvider =
        Provider.of<NetworkViewModel>(context, listen: false);

    var isInternetAvailable = await networkProvider.checkInternetAvailability();
    if (!isInternetAvailable) {
      setLoading(false);

      Utils.showFlushBarWithMessage("", "No Internet Connection", context);
    } else {
      await _myRepo
          .deleteReviewRequest(
        api: AppUrl.deleteReview,
        bearerToken: token,
        order_id: order_id,
      )
          .then((value) async {
        Utils.showFlushBarWithMessage("", value.message, context);
        await getOrderDetail(context, order_id, true);
      });
    }
  }

  Future<bool> addToWishlist(
      dynamic data, BuildContext context, String orderID) async {
    // setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    NetworkViewModel networkProvider =
        Provider.of<NetworkViewModel>(context, listen: false);

    var isInternetAvailable = await networkProvider.checkInternetAvailability();
    if (!isInternetAvailable) {
      // setLoading(false);

      Utils.showFlushBarWithMessage("", "No Internet Connection", context);
    } else {
      if (token == null || token == "") {
        Utils.showFlushBarWithMessage("Alert", "Please login first.", context);

        getOrderDetail(context, orderID, false);
        return false;
      }
      _myRepo.addToWishlist(AppUrl.addToWishlist, token, data).then((value) {
        setLoading(false);

        Utils.showFlushBarWithMessage("Alert", value.message, context);

        print(value.message);

        return true;
      }).onError((error, stackTrace) {
        setLoading(false);
        print(error.toString());
        Utils.showFlushBarWithMessage("Alert", error.toString(), context);
        return false;
      });
    }
    return false;
  }

  Future<bool> removeFromWishlist(
      dynamic data, BuildContext context, String orderID) async {
    //setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    NetworkViewModel networkProvider =
        Provider.of<NetworkViewModel>(context, listen: false);

    var isInternetAvailable = await networkProvider.checkInternetAvailability();
    if (!isInternetAvailable) {
      // setLoading(false);

      Utils.showFlushBarWithMessage("", "No Internet Connection", context);
    } else {
      if (token == null || token == "") {
        Utils.showFlushBarWithMessage("Alert", "Please login first.", context);

        return false;
      }
      _myRepo
          .removeFromWishlist(AppUrl.removeFromWishlist, token, data)
          .then((value) {
        // setLoading(false);

        Utils.showFlushBarWithMessage("Alert", value.message, context);

        getOrderDetail(context, orderID, false);

        print(value.message);

        return true;
      }).onError((error, stackTrace) {
        setLoading(false);
        print(error.toString());
        Utils.showFlushBarWithMessage("Alert", error.toString(), context);
        return false;
      });
    }
    return false;
  }

  Map<String, String> addMapListToData(
      Map<String, String> data, List<Map<String, dynamic>> mapList) {
    for (var map in mapList) {
      map.forEach((key, value) {
        data[key] = value;
      });
    }
    return data;
  }

  Future<bool> addToCart(
      dynamic data, BuildContext context, String orderId) async {
    // setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;

    if (token == null || token == "") {
      Utils.showFlushBarWithMessage("Alert", "Please login first.", context);

      return false;
    }

    var data2 = data;
    data2 = addMapListToData(data2, selectedVariationMap);

    _myRepo.addToCart(AppUrl.addToCart, token, data2).then((value) {
      setLoading(false);

      if (value.message == "Successfully added!") {
        Utils.showFlushBarWithMessage("Alert", value.message, context);
        getOrderDetail(context, orderId, false);
      } else {
        Utils.showFlushBarWithMessage("Alert", value.message, context);
      }

      return true;
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
      Utils.showFlushBarWithMessage("Alert", error.toString(), context);
      return false;
    });
    return false;
  }

  Future<bool> removeFromCart(
      dynamic data, BuildContext context, String orderId) async {
    //setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;

    print(data);
    _myRepo.removeFromCart(AppUrl.removeFromCart, token, data).then((value) {
      setLoading(false);
      Utils.showFlushBarWithMessage("Alert", value.message, context);

      getOrderDetail(context, orderId, false);
      print(value.message);

      return true;
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
      Utils.showFlushBarWithMessage("Alert", error.toString(), context);
      return false;
    });
    return false;
  }

  Future<void> pickFile(BuildContext context,
      {required String order_id,
      required String comment,
      required String rating,
      required String product_id}) async {
    NetworkViewModel networkProvider =
        Provider.of<NetworkViewModel>(context, listen: false);

    var isInternetAvailable = await networkProvider.checkInternetAvailability();
    if (!isInternetAvailable) {
      setLoading(false);

      Utils.showFlushBarWithMessage("", "No Internet Connection", context);
    } else {
      var res = await _myRepo.multipartRequestReview(
          AppUrl.writeReview, selectedImage!, MediaType('image', 'jpeg'),
          order_id: order_id,
          product_id: product_id,
          comment: comment,
          rating: rating);
      print(res["status"]);
      if (res['status'] == true) {
        Routes.navigateToPreviousScreen(
          context,
        );
        Utils.showFlushBarWithMessage("", res['message'], context);
        await getOrderDetail(context, order_id, true);
      }
    }
  }
}
