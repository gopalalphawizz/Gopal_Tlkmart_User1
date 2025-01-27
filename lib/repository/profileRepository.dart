import 'dart:convert';
import 'dart:io';
import 'package:alpha_ecommerce_18oct/utils/shared_pref..dart';
import 'package:alpha_ecommerce_18oct/view/profile/address/model/cityModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/address/model/countryModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/address/model/stateModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/customerSupport/customerSupportModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/customerSupport/supportChatModel.dart';
import 'package:http_parser/http_parser.dart';

import 'package:alpha_ecommerce_18oct/view/home/models/successModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/models/privacyPolicyModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/models/referralModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/models/subscriptionModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/payment/myTransaction/model/transactionHistoryModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/payment/myWallet/model/walletModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/payment/refund/model/refundHistoryModel.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  Future<SuccessModel> updateProfileRequest(
      String api, String bearerToken, dynamic data) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.put(url, body: data, headers: {
      'Authorization': 'Bearer $bearerToken',
    });

    return successModelFromJson(res.body);
  }

  Future<PrivacyPolicyModel> getPrivacyPolicyDataRequest(
      {required String api}) async {
    final url = Uri.parse(api);
    print(api);
    final http.Response res;
    res = await http.get(url);
    print(res.body);
    var ans = await jsonDecode(res.body);
    return PrivacyPolicyModel.fromJson(ans);
  }

  Future<TransactionHistoryModel> getTransactionHistoryDataRequest(
      {required String api, required String bearerToken}) async {
    final url = Uri.parse(api);
    print(api);

    print(bearerToken);
    final http.Response res;
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $bearerToken',
    });
    print(res.body);
    var ans = await jsonDecode(res.body);
    return TransactionHistoryModel.fromJson(ans);
  }

  Future<RefundModel> getRefundHistoryDataRequest(
      {required String api, required String bearerToken}) async {
    final url = Uri.parse(api);
    print(api);

    print(bearerToken);
    final http.Response res;
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $bearerToken',
    });
    print(res.body);
    var ans = await jsonDecode(res.body);
    return RefundModel.fromJson(ans);
  }

  Future<WalletHistory> getWalletHistoryDataRequest(
      {required String api, required String bearerToken}) async {
    final url = Uri.parse(api);
    print(api);

    print(bearerToken);
    final http.Response res;
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $bearerToken',
    });
    print(res.body);
    var ans = await jsonDecode(res.body);
    return WalletHistory.fromJson(ans);
  }

  Future<ReferralModel> getReferralDataRequest(
      {required String api, required String bearerToken}) async {
    final url = Uri.parse(api);
    print(api);

    print(bearerToken);
    final http.Response res;
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $bearerToken',
    });
    print(res.body);
    var ans = await jsonDecode(res.body);
    return ReferralModel.fromJson(ans);
  }

  Future<SubscriptionModel> getSubscriptionDataRequest(
      {required String api, required String bearerToken}) async {
    final url = Uri.parse(api);
    print(api);

    print(bearerToken);
    final http.Response res;
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $bearerToken',
    });
    print(res.body);
    var ans = await jsonDecode(res.body);
    return SubscriptionModel.fromJson(ans);
  }

  Future<SuccessModel2> addToWallet(
      String api, String bearerToken, dynamic data) async {
    final url = Uri.parse(api);

    print(api);
    final http.Response res;
    res = await http.post(url, body: data, headers: {
      'Authorization': 'Bearer $bearerToken',
    });

    print(res.body);

    return successModel2FromJson(res.body);
  }

  Future<Map<String, dynamic>> multipartRequest(
    String api,
    File userImage,
    MediaType mediaType,
  ) async {
    final url = Uri.parse(api);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;

    print(
        "========================================================================================================");
    print(
        "-------------------------------------------- URL --------------------------------------------");
    print("$url");
    print(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    print("${userImage.path.split('/').last}");

    final length = await userImage.length();

    final request = http.MultipartRequest(
      "POST",
      url,
    );
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer $token',
    }); // request.headers["apipassword"] = APIs.apipassword;
    // request.headers["Content-type"] = "multipart/form-data";
    // request.headers["uid"] = userid.toString();
    // request.headers["scode"] = sCode.toString();

    request.files.add(http.MultipartFile(
        'image', userImage.readAsBytes().asStream(), length,
        filename: userImage.path.split('/').last, contentType: mediaType));

    final streamRes = await request.send();
    final res = await http.Response.fromStream(streamRes);
    final Map<String, dynamic> json = await jsonDecode(res.body);

    print(res.body);
    return json;
  }

  Future<StateModel> stateList(
    String api,
  ) async {
    final url = Uri.parse(api);

    print(api);
    final http.Response res;
    res = await http.get(
      url,
    );

    print(res.body);
    var asn = await json.decode(res.body);

    return StateModel.fromJson(asn);
  }

  Future<CityModel> cityList(
    String api,
  ) async {
    final url = Uri.parse(api);

    print(api);
    final http.Response res;
    res = await http.get(
      url,
    );

    print(res.body);
    var asn = await json.decode(res.body);

    return CityModel.fromJson(asn);
  }

  Future<CountryModel> countryList(
    String api,
  ) async {
    final url = Uri.parse(api);

    print(api);
    final http.Response res;
    res = await http.get(
      url,
    );

    print(res.body);

    return countryModelFromJson(res.body);
  }

  //Function to get support query Data
  Future<CustomerSupportModel> supportQueryListGetRequest(
      {required api, required String token}) async {
    try {
      var url = Uri.parse(api);
      var res =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var ans = jsonDecode(res.body);
      print(ans);
      if (res.statusCode == 200) {
        print(res);
        return CustomerSupportModel.fromJson(ans);
      } else {
        print(res.reasonPhrase);
        return CustomerSupportModel(status: null, message: null, data: []);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//Function to get Customer Support Chat
  Future<SupportChatModel> supportChatGetRequest({
    required String api,
    required String token,
  }) async {
    try {
      var url = Uri.parse(api);
      http.Response response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      var ans = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(ans);
        return SupportChatModel.fromJson(ans);
      } else {
        print(response.reasonPhrase);
        return SupportChatModel.fromJson(ans);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  supportChatPostRequest(
      {required String api, required String token, required String chat}) {}
}
