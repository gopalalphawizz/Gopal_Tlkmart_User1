import 'dart:ffi';

import 'package:alpha_ecommerce_18oct/repository/profileRepository.dart';
import 'package:alpha_ecommerce_18oct/utils/appUrls.dart';
import 'package:alpha_ecommerce_18oct/utils/shared_pref..dart';
import 'package:alpha_ecommerce_18oct/utils/utils.dart';
import 'package:alpha_ecommerce_18oct/view/profile/models/privacyPolicyModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/models/referralModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/models/subscriptionModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/payment/myTransaction/model/transactionHistoryModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/payment/refund/model/refundHistoryModel.dart';
import 'package:flutter/material.dart';

class ProfileViewModel with ChangeNotifier {
  bool isLoading = false;
  bool get loading => isLoading;
  final _myRepo = ProfileRepository();
  late PrivacyPolicyModel privacyPolicyData;

  List<DatumTrasaction> transactionDatta = [];
  List<DatumRefund> refundData = [];
  List<ReferralData> referralList = [];
  List<SubscriptionData> subscriptionList = [];

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> updateProfile(BuildContext context, dynamic data) async {
    setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    print(token);

    await _myRepo
        .updateProfileRequest(AppUrl.updateProfile, token, data)
        .then((value) {
      setLoading(false);
      Utils.showFlushBarWithMessage("Alert", value.message, context);
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
      print(stackTrace.toString());
    });
  }

//Funcation to fetch All Privacy Policy Data
  Future<void> getPrivacyPolicyData() async {
    setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    await _myRepo
        .getPrivacyPolicyDataRequest(api: AppUrl.privacyPolicyData)
        .then((value) {
      privacyPolicyData = value;
      print(privacyPolicyData.data!.privacyPolicy);
      setLoading(false);
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
      print(stackTrace.toString());
    });
  }

  Future<void> getTransactionHistoryData() async {
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    await _myRepo
        .getTransactionHistoryDataRequest(
            api: AppUrl.transactionHistory, bearerToken: token)
        .then((value) {
      transactionDatta = value.data;
      print("Transacttiion Data");
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
      print(stackTrace.toString());
    });
  }

  Future<void> getRefundHistoryData() async {
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    await _myRepo
        .getRefundHistoryDataRequest(
            api: AppUrl.refundHistory, bearerToken: token)
        .then((value) {
      refundData = value.data;
      print("Transacttiion Data");
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
      print(stackTrace.toString());
    });
  }

//Function to fetch referral data
  Future<void> getReferralData() async {
    setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    await _myRepo
        .getReferralDataRequest(api: AppUrl.referral, bearerToken: token)
        .then((value) {
      referralList = value.data;
      print(referralList.length);
      setLoading(false);
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
      print(stackTrace.toString());
    });
  }

//Function to fetch subscription data
  Future<void> getSubscriptionData() async {
    setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    await _myRepo
        .getSubscriptionDataRequest(
            api: AppUrl.subscription, bearerToken: token)
        .then((value) {
      subscriptionList = value.data;
      print(subscriptionList.length);
      setLoading(false);
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
      print(stackTrace.toString());
    });
  }
}
