import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mina_farid/presentation/resources/assets_manger.dart';
import 'package:mina_farid/presentation/resources/color_manager.dart';
import 'package:mina_farid/presentation/resources/constants_manager.dart';
import 'package:mina_farid/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
          child: Image(
        image: AssetImage(ImageAssets.splashLogo),
      )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }
}
