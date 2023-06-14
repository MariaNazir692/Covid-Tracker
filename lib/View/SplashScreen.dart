import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_covid_tracker_app/View/word_states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

//Ticker provider helps to build animations
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  //animation controller helps to build animation and it maintain 16 seconds animation
  late final AnimationController _controller =
  AnimationController(duration: Duration(seconds: 3), vsync: this)
    ..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>WorldsStatesScreen())
            )
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 400,
                width: 400,
                child: Center(
                  child: Container(
                    width: 200,
                      height: 300,
                      child: Image.asset('images/virus.png',fit: BoxFit.contain,)),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi, child: child);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "COVID-19\n Tracker App",textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
