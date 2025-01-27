// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool status;
  String message;
  List<Datum> data;
  int latest_order;
  int unread_notification;
  int whishlisted;

  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
    required this.latest_order,
    required this.unread_notification,
    required this.whishlisted,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(
          json["data"].map((x) => Datum.fromJson(x)),
        ),
        latest_order: json["latest_order"] ?? 0,
        unread_notification: json["unread_notification"] ?? 0,
        whishlisted: json["whishlisted"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "latest_order": latest_order,
        "unread_notification": unread_notification,
        "whishlisted": whishlisted,
      };
}

class Datum {
  int id;
  String name;
  String fName;
  String lName;
  String phone;
  String image;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String streetAddress;
  String country;
  String state;
  String city;
  String zip;
  String houseNo;
  String apartmentNo;
  String cmFirebaseToken;
  int isActive;
  String paymentCardLastFour;
  String paymentCardBrand;
  String paymentCardFawryToken;
  String loginMedium;
  String socialId;
  int isPhoneVerified;
  String temporaryToken;
  int isEmailVerified;
  dynamic walletBalance;
  String loyaltyPoint;
  int loginHitCount;
  int isTempBlocked;
  String tempBlockTime;
  int isLoggedIn;
  int isSubscribed;
  String referralCode;
  int languageId;
  int currencyId;
  String gender;

  Datum(
      {required this.id,
      required this.name,
      required this.fName,
      required this.lName,
      required this.phone,
      required this.image,
      required this.email,
      required this.emailVerifiedAt,
      required this.createdAt,
      required this.updatedAt,
      required this.streetAddress,
      required this.country,
      required this.state,
      required this.city,
      required this.zip,
      required this.houseNo,
      required this.apartmentNo,
      required this.cmFirebaseToken,
      required this.isActive,
      required this.paymentCardLastFour,
      required this.paymentCardBrand,
      required this.paymentCardFawryToken,
      required this.loginMedium,
      required this.socialId,
      required this.isPhoneVerified,
      required this.temporaryToken,
      required this.isEmailVerified,
      required this.walletBalance,
      required this.loyaltyPoint,
      required this.loginHitCount,
      required this.isTempBlocked,
      required this.tempBlockTime,
      required this.isLoggedIn,
      required this.isSubscribed,
      required this.referralCode,
      required this.languageId,
      required this.currencyId,
      required this.gender});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"],
      name: json["name"],
      fName: json["f_name"],
      lName: json["l_name"],
      phone: json["phone"],
      image: json["image"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      streetAddress: json["street_address"],
      country: json["country"],
      state: json["state"],
      city: json["city"],
      zip: json["zip"],
      houseNo: json["house_no"],
      apartmentNo: json["apartment_no"],
      cmFirebaseToken: json["cm_firebase_token"],
      isActive: json["is_active"],
      paymentCardLastFour: json["payment_card_last_four"],
      paymentCardBrand: json["payment_card_brand"],
      paymentCardFawryToken: json["payment_card_fawry_token"],
      loginMedium: json["login_medium"],
      socialId: json["social_id"],
      isPhoneVerified: json["is_phone_verified"],
      temporaryToken: json["temporary_token"],
      isEmailVerified: json["is_email_verified"],
      walletBalance: json["wallet_balance"],
      loyaltyPoint: json["loyalty_point"],
      loginHitCount: json["login_hit_count"],
      isTempBlocked: json["is_temp_blocked"],
      tempBlockTime: json["temp_block_time"],
      isLoggedIn: json["is_logged_in"],
      isSubscribed: json["is_subscribed"],
      referralCode: json["referral_code"],
      languageId: json["language_id"],
      currencyId: json["currency_id"],
      gender: json["gender"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "image": image,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "street_address": streetAddress,
        "country": country,
        "state": state,
        "city": city,
        "zip": zip,
        "house_no": houseNo,
        "apartment_no": apartmentNo,
        "cm_firebase_token": cmFirebaseToken,
        "is_active": isActive,
        "payment_card_last_four": paymentCardLastFour,
        "payment_card_brand": paymentCardBrand,
        "payment_card_fawry_token": paymentCardFawryToken,
        "login_medium": loginMedium,
        "social_id": socialId,
        "is_phone_verified": isPhoneVerified,
        "temporary_token": temporaryToken,
        "is_email_verified": isEmailVerified,
        "wallet_balance": walletBalance,
        "loyalty_point": loyaltyPoint,
        "login_hit_count": loginHitCount,
        "is_temp_blocked": isTempBlocked,
        "temp_block_time": tempBlockTime,
        "is_logged_in": isLoggedIn,
        "is_subscribed": isSubscribed,
        "referral_code": referralCode,
        "language_id": languageId,
        "currency_id": currencyId,
        "gender": gender
      };
}
