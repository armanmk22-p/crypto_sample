import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';



class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),() => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen())),);
    //or
    //Future.delayed(Duration(seconds: 3),() => null,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(image: AssetImage('assets/images/splash.png')),
          ),
          Text('Crypto App',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
