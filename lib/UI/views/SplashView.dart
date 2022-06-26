import 'dart:async';

import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebus/core/viewmodels/SplashViewmodel.dart';
import 'package:ebus/helpers/AnimationHandler.dart';
import 'package:ebus/helpers/Constants.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashViewmodel? splashViewmodel;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () async {
      bool isLoggedIn = await getLoggedIn();
      isLoggedIn
          ? Navigator.of(context).pushNamedAndRemoveUntil(
              '/MainView', (Route<dynamic> route) => false)
          : Navigator.of(context).pushNamedAndRemoveUntil(
              '/LoginView', (Route<dynamic> route) => false);
    });
    splashViewmodel = Provider.of<SplashViewmodel>(context, listen: false);
    splashViewmodel!.initSplash(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            stops: [0.1, 0.3, 0.8],
            radius: 2,
            colors: splashGradient,
          ),
        ),
        alignment: Alignment.center,
        child: Center(
          child: 
          // AnimationHandler().popUp(
              Container(
                alignment: Alignment.center,
                child: Hero(
                  tag: 'ebusLogo',
                  child: Image(
                    image: AssetImage('images/icon.png'),
                    color: Colors.white,
                  ),
                ),
              ),
              // Curves.ease,
              // 700.0,
              // duration: 500),
        ),
      ),
    );
  }
}
