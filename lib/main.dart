import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
  double height = 0;
  double _width = 0;
  Animation animation;
  bool isRight = true;
  Animation<Offset> animationOffset;
  Animation<double> rotateLeft;
  Animation<double> rotate;
  Animation<Offset> leftanimationOffset;

  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    rotate = Tween<double>(
      begin: -0.0,
      end: -20.0,
    ).animate(animationController)
      ..addListener(() {
        setState(
          () {
            if (rotate.isCompleted) {
              animationController.reset();
            }
          },
        );
      });
    animationOffset = Tween<Offset>(begin: Offset.zero, end: Offset(30.0, 0.0))
        .animate(animationController);

    rotateLeft =
        Tween<double>(begin: 0.0, end: 20.0).animate(animationController)
          ..addListener(() {
            print(rotateLeft.value);
            setState(() {
              if (rotateLeft.isCompleted) {
                animationController.reset();
              }
            });
          });
    leftanimationOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset(-30.0, 0.0))
            .animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: (isRight)
                ? Alignment(animationOffset.value.dx, animationOffset.value.dy)
                : Alignment(
                    leftanimationOffset.value.dx, leftanimationOffset.value.dy),
            child: Transform(
              transform: Matrix4.skewX(
                0.0,
              ),
              child: RotationTransition(
                turns: (isRight)
                    ? AlwaysStoppedAnimation(-rotate.value / 600)
                    : AlwaysStoppedAnimation(rotate.value / 600),
                child: Container(
                    height: height * 0.8,
                    width: _width * 0.9,
                    color: Colors.blue),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin:
                    EdgeInsets.only(left: _width * 0.02, right: _width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        startLeftAnimation(false);
                      },
                      child: Container(
                          height: height * 0.07,
                          width: _width * 0.2,
                          child: Center(
                            child: Text("left".toUpperCase()),
                          ),
                          color: Colors.blue),
                    ),
                    GestureDetector(
                      onTap: () {
                        startRightAnimation(true);
                      },
                      child: Container(
                          height: height * 0.07,
                          width: _width * 0.2,
                          child: Center(
                            child: Text(
                              "right".toUpperCase(),
                            ),
                          ),
                          color: Colors.blue),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  void startRightAnimation(bool isRight) {
    setState(() {
      this.isRight = isRight;
    });
    animationController.forward();
    //print(animationOffset.value);
  }

  void startLeftAnimation(bool isLeft) {
    setState(() {
      this.isRight = isLeft;
    });
    animationController.forward();
  }
}
