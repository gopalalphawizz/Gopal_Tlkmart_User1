import 'package:alpha_ecommerce_18oct/repository/FaqRepository.dart';
import 'package:alpha_ecommerce_18oct/repository/couponRepository.dart';
import 'package:alpha_ecommerce_18oct/utils/appUrls.dart';
import 'package:alpha_ecommerce_18oct/utils/shared_pref..dart';
import 'package:alpha_ecommerce_18oct/view/profile/coupon/model/couponListModel.dart';
import 'package:alpha_ecommerce_18oct/view/profile/faqs/model/faqsModel.dart';
import 'package:flutter/material.dart';

class FaqViewModel with ChangeNotifier {
  List<DatumFAQ> faqList = [];
  bool isLoading = false;
  bool get loading => isLoading;
  final _myRepo = FAQRepository();

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getFaqListItem(BuildContext context) async {
    setLoading(true);
    var token = SharedPref.shared.pref!.getString(PrefKeys.jwtToken)!;
    print(token);

    await _myRepo.faqListRequest(AppUrl.faq, token).then((value) {
      faqList = value.data;
      notifyListeners();
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
      print(stackTrace.toString());
    });
  }
}
