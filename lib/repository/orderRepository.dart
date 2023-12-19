import 'dart:convert';

import 'package:alpha_ecommerce_18oct/view/order/model/orderDetailModel.dart';
import 'package:alpha_ecommerce_18oct/view/order/model/ordersModel.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  Future<OrdersModel> orderListRequest(String api, String bearerToken) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $bearerToken',
    });

    print(api);

    print(res.body);

    var asn = await json.decode(res.body);

    return OrdersModel.fromJson(asn);
  }

  Future<OrderDetailsModel> orderDetailRequest(
      String api, String bearerToken, String order_id) async {
    final url = Uri.parse(api).replace(queryParameters: {
      'status': '',
      'categories': '',
      'order_id': order_id,
    });

    final http.Response res;
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $bearerToken',
    });

    print(api);
    print(order_id);
    var asn = await json.decode(res.body);
    return OrderDetailsModel.fromJson(asn);
  }
}
