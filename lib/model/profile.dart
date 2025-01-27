import 'package:alpha_ecommerce_18oct/view/profile/address/addressList.dart';
import 'package:alpha_ecommerce_18oct/view/profile/followingVendor/view/followingVendorScreen.dart';
import '../utils/images.dart';
import '../view/profile/aboutUs/aboutUs.dart';
import '../view/profile/contactUs/contactUs.dart';
import '../view/profile/coupon/couponScreen.dart';
import '../view/profile/customerSupport/customerSupport.dart';
import '../view/profile/faqs/faqs.dart';
import '../view/profile/payment/profile_payment.dart';
import '../view/profile/privacyPolicy/privacyPolicy.dart';
import '../view/profile/referEarn/referEarn.dart';
import '../view/profile/setting/setting.dart';
import '../view/profile/shippingPolicy/shippingPolicy.dart';
import '../view/profile/subscribe/subscribe.dart';

class ProfileList {
  String profileIcon;
  String profileText;
  dynamic navigationScreen;
  ProfileList(
      {required this.profileIcon,
      required this.profileText,
      required this.navigationScreen});
}

List<ProfileList> profile = [
  ProfileList(
      profileIcon: Images.locationProfile,
      profileText: 'Manage Address',
      navigationScreen: const AddressListScreen(
        isComingForSelection: false,
      )),
  ProfileList(
      profileIcon: Images.walletProfile,
      profileText: 'Payment',
      navigationScreen: const ProfilePayment()),
  ProfileList(
      profileIcon: Images.discountProfile,
      profileText: 'Coupons',
      navigationScreen: const CouponScreen()),
  ProfileList(
      profileIcon: "assets/images/Group 448.png",
      profileText: 'Following Vendors',
      navigationScreen: const FollowingVendorList()),
  ProfileList(
      profileIcon: Images.setting,
      profileText: 'Settings',
      navigationScreen: const Setting()),
  // ProfileList(
  //     profileIcon: Images.subscribe,
  //     profileText: 'Subscribe',
  //     navigationScreen: const Subscribe()),
  // ProfileList(
  //     profileIcon: Images.referAndEarn,
  //     profileText: 'Refer and Earn',
  //     navigationScreen: const ReferAndEarn()),
  ProfileList(
      profileIcon: Images.support,
      profileText: 'Customer Support',
      navigationScreen: const CustomerSupport()),
  ProfileList(
      profileIcon: Images.calling,
      profileText: 'Contact Us',
      navigationScreen: const ContactUs()),
  ProfileList(
      profileIcon: Images.faq,
      profileText: 'Faqs',
      navigationScreen: const FAQs()),
  ProfileList(
      profileIcon: Images.privacyPolicy,
      profileText: 'Privacy Policy',
      navigationScreen: const PrivacyPolicy()),
  ProfileList(
      profileIcon: Images.shipping,
      profileText: 'Shipping & Delivery policy',
      navigationScreen: const ShippingPolicy()),
  ProfileList(
      profileIcon: Images.aboutUs,
      profileText: 'About Us',
      navigationScreen: const AboutUs()),
  ProfileList(
      profileIcon: Images.logOut,
      profileText: 'Logout',
      navigationScreen: "functionOpen"),
  ProfileList(
      profileIcon: Images.logOut,
      profileText: 'Delete Account',
      navigationScreen: "functionOpen2"),
];
