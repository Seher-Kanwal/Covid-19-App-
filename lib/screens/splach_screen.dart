import 'dart:async';
import 'package:covid_app/screens/world_statics_data.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController controller =
  AnimationController(duration: const Duration(seconds: 10), vsync: this)..repeat();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(   //that display screen only for 5 sec and than move to actual screen
      const Duration(seconds: 5),
      () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WorldStaticsData())),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
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
                animation: controller,
                // in builder you have to provide context along with the widget you want to build
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: controller.value * 2 * math.pi,
                    child: Transform.scale(
                      scale: controller.value * 0.7* math.pi,
                      //angle: controller.value * 2.0 * math.pi,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        // height: 200,
                        //width: 200,
                        child: const Center(
                          child: Image(image: AssetImage('images/virus3.png',),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(
              //height: 100,
               height: MediaQuery.of(context).size.height*0.002,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Covid19 App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
