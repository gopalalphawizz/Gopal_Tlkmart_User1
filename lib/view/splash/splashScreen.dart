import 'package:alpha_ecommerce_18oct/viewModel/splashViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashViewModel = Provider.of<SplashViewModel>(context);

    splashViewModel.changeScreen(context);
    return Stack(
      children: [
        //assets/images/splashIconLiight.png
        Theme.of(context).brightness == Brightness.dark
            ? Image.asset(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                "assets/images/splash.png",
                fit: BoxFit.fill,
              )
            : Image.asset(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                "assets/images/splashIconLiight.png",
                fit: BoxFit.fill,
              ),
      ],
    );
  }
}
