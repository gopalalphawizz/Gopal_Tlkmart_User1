import 'dart:io';

import 'package:alpha_ecommerce_18oct/utils/app_dimens/app_dimens.dart';
import 'package:flutter/material.dart';
import '../../utils/color.dart';

class HeaderText extends StatelessWidget {
  final String text;
  const HeaderText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Colors.white,
          fontSize: Platform.isAndroid ? size_18 : size_20),
    );
  }
}

class Text14 extends StatelessWidget {
  final String text;
  final Color? light;
  final FontWeight? bold;
  const Text14({Key? key, required this.text, this.light, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: Platform.isAndroid ? size_14 : size_14,
          color: light ?? colors.textColor,
          fontWeight: bold ?? FontWeight.normal),
    );
  }
}

class Text16 extends StatelessWidget {
  final String text;
  final Color? light;
  final FontWeight? bold;

  const Text16({Key? key, required this.text, this.light, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: Platform.isAndroid ? size_14 : size_16,
          color: light ?? colors.textColor,
          fontWeight: bold ?? FontWeight.normal),
    );
  }
}

class Text18 extends StatelessWidget {
  final String text;
  final Color? light;
  final FontWeight? bold;
  const Text18({Key? key, required this.text, this.light, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: Platform.isAndroid ? size_17 : size_18,
          color: light ?? colors.textColor,
          fontWeight: bold ?? FontWeight.normal),
    );
  }
}

class Text20 extends StatelessWidget {
  final String text;
  final Color? light;
  final FontWeight? bold;
  const Text20({Key? key, required this.text, this.light, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: Platform.isAndroid ? size_18 : size_20,
          color: light ?? colors.textColor,
          fontWeight: bold ?? FontWeight.normal),
    );
  }
}
