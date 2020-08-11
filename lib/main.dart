import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Clock",
      theme: ThemeData(
          // primarySwatch: Colors.red,
          ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  Color backColor = Colors.teal.shade900;
  Color clockColor = Colors.black87.withOpacity(0.2);

  Animation animation;
  AnimationController animationController;

  _currentTime() {

    if (DateTime.now().hour < 10) {
      if (DateTime.now().minute < 10) {
        if (DateTime.now().second < 10) {
          return "0${DateTime.now().hour} : 0${DateTime.now().minute} : 0${DateTime.now().second}";
        } else {
          return "0${DateTime.now().hour} : 0${DateTime.now().minute} : ${DateTime.now().second}";
        }
      } else {
        if (DateTime.now().second < 10) {
          return "0${DateTime.now().hour} : ${DateTime.now().minute} : 0${DateTime.now().second}";
        } else {
          return "0${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
        }
      }
    } else {

      if (DateTime.now().minute < 10) {
        if (DateTime.now().second < 10) {
          return "${DateTime.now().hour} : 0${DateTime.now().minute} : 0${DateTime.now().second}";
        } else {
          return "${DateTime.now().hour} : 0${DateTime.now().minute} : ${DateTime.now().second}";
        }
      } else {
        if (DateTime.now().second < 10) {
          return "${DateTime.now().hour} : ${DateTime.now().minute} : 0${DateTime.now().second}";
        } else {
          return "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animationController.addListener(() {
      if (animation.isCompleted) {
        animationController.reverse();
      } else if (animation.isDismissed) {
        animationController.forward();
      }

      setState(() {});
    });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animation = Tween(begin: -0.5, end: 0.5).animate(animation);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backColor,
        elevation: 0.0,
        title: Text(
          "Clock",
          style: TextStyle(
            fontSize: 24.2,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: backColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 20.2,
                borderRadius: BorderRadius.all(Radius.circular(40.2)),
                color: clockColor,
                child: Container(
                    width: 380,
                    height: 200,
                    child: Center(
                      child: Text(
                        _currentTime(),
                        style: TextStyle(
                          fontSize: 60.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ),
              Transform(
                alignment: FractionalOffset(0.5, 0.01),
                transform: Matrix4.rotationZ(animation.value),
                child: Container(
                  child: Image.asset(
                    "images/pendulum2.png",
                    height: 330,
                    width: 250,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
