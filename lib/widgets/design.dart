import 'package:flutter/material.dart';
import '../utils/color.dart';
import '../utils/constant.dart';
import '../view/language/language_settings.dart';

class DesignConfiguration {
  static setSvgPath(String name) {
    return 'assets/images/svg/$name.svg';
  }

  static setPngPath(String name) {
    return 'assets/images/png/$name.png';
  }

  static setLottiePath(String name) {
    return 'assets/animation/$name.json';
  }

  static placeHolder(double height) {
    return AssetImage(
      DesignConfiguration.setPngPath('placeholder'),
    );
  }

  static errorWidget(double size) {
    return Image.asset(
      DesignConfiguration.setPngPath('placeholder'),
      height: size,
      width: size,
    );
  }

  static shadow() {
    return const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color(0x1a0400ff),
          offset: Offset(0, 0),
          blurRadius: 30,
        )
      ],
    );
  }

  static back() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [colors.grad2Color, colors.grad1Color, colors.grad2Color],
        // stops: [0, 1],
      ),
    );
  }

  static imagePlaceHolder(double size, BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Icon(
        Icons.account_circle,
        color: Theme.of(context).colorScheme.black,
        size: size,
      ),
    );
  }

  static getProgress() {
    return const Center(child: CircularProgressIndicator());
  }

  static getNoItem(BuildContext context) {
    return Center(
      child: Text(
        getTranslated(context, 'noItem')!,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontFamily: 'ubuntu',
            color: Theme.of(context).colorScheme.fontColor),
      ),
    );
  }

  static Widget showCircularProgress(bool isProgress, Color color) {
    if (isProgress) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }
    return const SizedBox(
      height: 0.0,
      width: 0.0,
    );
  }

  static dialogAnimate(BuildContext context, Widget dialge) {
    return showGeneralDialog(
      barrierColor: Theme.of(context).colorScheme.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(opacity: a1.value, child: dialge),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox();
      },
    );
  }

  static getCacheNotworkImage({
    required String imageurlString,
    required BuildContext context,
    required BoxFit? boxFit,
    required double? heightvalue,
    required double? widthvalue,
    required double? placeHolderSize,
  }) {
    return FadeInImage.assetNetwork(
      image: imageurlString,
      placeholder: DesignConfiguration.setPngPath('placeholder'),
      width: widthvalue,
      height: heightvalue,
      fit: boxFit,
      fadeInDuration: const Duration(
        milliseconds: 150,
      ),
      fadeOutDuration: const Duration(
        milliseconds: 150,
      ),
      fadeInCurve: Curves.linear,
      fadeOutCurve: Curves.linear,
      imageErrorBuilder: (context, error, stackTrace) {
        return Container(
          child: DesignConfiguration.errorWidget(placeHolderSize ?? 50),
        );
      },
    );
  }
}

class GetDiscountLabel extends StatelessWidget {
  final double discount;
  const GetDiscountLabel({Key? key, required this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colors.red,
          borderRadius: BorderRadius.circular(circularBorderRadius1)),
      margin: const EdgeInsets.only(left: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
        child: Text(
          '${discount.round().toStringAsFixed(2)}%',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: colors.whiteTemp,
                fontWeight: FontWeight.bold,
                fontFamily: 'ubuntu',
                fontSize: textFontSize10,
              ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget glowingOverscrollIndicator(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
