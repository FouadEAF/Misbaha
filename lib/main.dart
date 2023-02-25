// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:AnimatedSplashScreen(
      splash: 'assests/SplashScreen/eafLogo.png',
      splashIconSize: 400,
      duration: 1500,
      backgroundColor: Colors.white,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: MyHomePage(),
    ),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//=============================Declaration variables============================
  late Future<int> _counter;
  int compte = 0;
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//==============================================================================

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    setState(() {
      _counter = prefs.setInt('counter', counter).then((bool success) {return counter;});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter = SharedPreferences.getInstance().then((SharedPreferences prefs) => prefs.getInt('counter') ?? 0);
  }


  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('المسبحة الإلكترونية',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          centerTitle: true,
        ),
        body: SafeArea(child:Center(child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(vertical: 40),
          width: 400,
          height: 800,
          child:
          Stack(
            children: [
              Image(image: AssetImage('assests/misbaha.png')),
              Positioned(
                top: 78.0,
                left: 65.0,
                child: Text('$compte', style: TextStyle(fontSize: 100)),
              ),
              Positioned(
                top: 250.0,
                left: 260.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white54,
                  radius: 18,
                  child: InkWell(
                    child: Icon(Icons.restart_alt_outlined),
                    onTap: () {
                      setState(() {
                        compte = 0;
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                top: 285.0,
                left: 120.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white54,
                  radius: 65,
                  child: InkWell(
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 100,
                      color: Colors.black54,
                    ),
                    onTap: () {
                      setState(() {
                        if(compte < 9999){
                          compte++;
                        }else{
                          compte = 0; }
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                  top: 45.0,
                  right: 85.0,
                  child: Center(child:Text('لا تنسونا من صالح دعائكم', style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),)),
            ],
          ),
        ),),
        )
    );
  }

  }

