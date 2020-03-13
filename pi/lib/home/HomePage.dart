import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final customDecoration = BoxDecoration(
  color: Color(0xFFE0E5EC),
  borderRadius: BorderRadius.circular(25.0),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(163, 177, 198, 0.6),
      offset: Offset(9.0, 9.0),
      blurRadius: 16.0,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: Color.fromRGBO(255, 255, 255, 0.5),
      offset: Offset(-9.0, -9.0),
      blurRadius: 16.0,
      spreadRadius: 1.0,
    ),
  ],
);

class _HomePageState extends State<HomePage> {
  GlobalKey key = GlobalKey();
  double xCenter, yCenter, pi;
  List<Widget> customStack, customPos;
  int allDots, inDots;

  @override
  void initState() {
    super.initState();
    customStack = List();
    customPos = List();
    pi = 0.0;
    allDots = inDots = 0;
  }

  getPositions() {
    final RenderBox renderBoxRed = key.currentContext.findRenderObject();
    final position = renderBoxRed.localToGlobal(Offset.zero);
    setState(() {
      xCenter = position.dx;
      yCenter = position.dy;
    });
  }

  Widget customPositioned(data, bool inOut) {
    return Positioned(
      top: yCenter,
      left: xCenter,
      child: Container(
        height: data.size.width * 0.03,
        width: data.size.width * 0.03,
        decoration: BoxDecoration(
          color: (inOut ? Color(0xFFEB8989) : Color(0x88EB8989)),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  more(data) {
    setState(() {
      for (int i = 0; i < 100; i++) {
        getPositions();
        allDots++;
        var rand = Random.secure();
        double dx = rand.nextDouble() * data.size.width * 0.8;
        double dy = rand.nextDouble() * data.size.width * 0.8;
        double oCenterY =
            yCenter + data.size.width * 0.4 - data.size.width * 0.015;
        double oCenterX =
            xCenter + data.size.width * 0.4 - data.size.width * 0.015;
        bool inOut = false;
        yCenter = yCenter + dy - data.size.width * 0.015;
        xCenter = xCenter + dx - data.size.width * 0.015;
        double dist = sqrt((oCenterX - xCenter) * (oCenterX - xCenter) +
            (oCenterY - yCenter) * (oCenterY - yCenter));
        if (dist <= data.size.width * 0.4) {
          inOut = true;
          inDots++;
        }
        pi = 4.0 * (inDots / allDots);
        customPos.add(customPositioned(data, inOut));
      }
    });
  }

  double toPrecision(double x, int fractionDigits) {
    double mod = pow(10, fractionDigits.toDouble());
    return ((x * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    setState(() {
      customStack = [
        Container(
          height: data.size.height,
          width: data.size.width,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: data.size.width * 0.05,
              vertical: data.size.height * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(data.size.width * 0.03),
                  width: data.size.width * 0.8,
                  decoration: customDecoration,
                  child: Center(
                    child: Text(
                      'Calculate PI',
                      style: TextStyle(
                        color: Color(0xFF577DB5),
                        fontSize: data.size.width * 0.12,
                      ),
                    ),
                  ),
                ),
                Container(
                  key: key,
                  child: Container(
                    height: data.size.width * 0.8,
                    width: data.size.width * 0.8,
                    decoration: customDecoration,
                    child: Center(
                      child: Container(
                        height: data.size.width * 0.8,
                        width: data.size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Color(0xFFE0E5EC),
                          borderRadius: BorderRadius.circular(
                            data.size.width * 0.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(163, 177, 198, 0.6),
                              offset: Offset(9.0, 9.0),
                              blurRadius: 16.0,
                              spreadRadius: 1.0,
                            ),
                            BoxShadow(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              offset: Offset(-9.0, -9.0),
                              blurRadius: 16.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(data.size.width * 0.04),
                  width: data.size.width * 0.8,
                  decoration: customDecoration,
                  child: Center(
                    child: Text(
                      (toPrecision(pi, 10)).toString(),
                      style: TextStyle(
                        color: Color(0xFF577DB5),
                        fontSize: data.size.width * 0.1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    more(data);
                  },
                  child: Container(
                    padding: EdgeInsets.all(data.size.width * 0.04),
                    decoration: customDecoration,
                    child: Text(
                      'More',
                      style: TextStyle(
                        color: Color(0xFF577DB5),
                        fontSize: data.size.width * 0.08,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
      customStack.addAll(customPos);
    });

    return Scaffold(
      backgroundColor: Color(0xFFE0E5EC),
      body: Container(
        height: data.size.height,
        width: data.size.width,
        child: Center(
          child: Stack(
            children: customStack,
          ),
        ),
      ),
    );
  }
}
