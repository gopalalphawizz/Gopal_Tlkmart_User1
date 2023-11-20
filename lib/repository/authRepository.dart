import 'package:alpha_ecommerce_18oct/viewModel/responseModel/loginOtpResponseModel.dart';
import 'package:alpha_ecommerce_18oct/viewModel/responseModel/registerUserResponseModel.dart';
import 'package:alpha_ecommerce_18oct/viewModel/responseModel/resetPasswordResponseModel.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  
  Future<LoginOtpResponseModel> loginApiReqzuest(
      String api, dynamic data) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.post(url, body: data);

    return loginOtpResponseModelFromJson(res.body);
  }

  Future<ResetPasswordModel> restPasswordAPI(
      String api, String bearerToken, dynamic data) async {
    final url = Uri.parse(api);

    print(api);
    final http.Response res;
    res = await http.put(url, body: data, headers: {
      'Authorization': 'Bearer $bearerToken',
      "Accept": "application/x-www-form-urlencoded"
    });

    print(res.body);

    return resetPasswordModelFromJson(res.body);
  }
}
