import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:solar_system/widget/planet_widget.dart';

class RotatingBottomNav extends StatefulWidget {
  const RotatingBottomNav({super.key});

  @override
  State<RotatingBottomNav> createState() => _RotatingBottomNavState();
}

class _RotatingBottomNavState extends State<RotatingBottomNav> {
  double _angle = 0.0;
  double _oldAngle = 0.0;
  double _angleDelta = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: (MediaQuery.of(context).size.height) - 120,
          left: 0,
          right: 0,
          child: Transform.rotate(
            angle: _angle,
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(300),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      //   Offset centerOfGestureDetector = Offset(
                      // constraints.maxWidth / 2, constraints.maxHeight / 2);
                      /**
                         * using center of positioned element instead to better fit the
                         * mental map of the user rotating object.
                         * (height = container height (30) + container height (30) + container height (200)) / 2
                         */
                      Offset centerOfGestureDetector =
                          Offset(constraints.maxWidth / 2, 130);
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onPanStart: (details) {
                          final touchPositionFromCenter =
                              details.localPosition - centerOfGestureDetector;
                          _angleDelta =
                              _oldAngle - touchPositionFromCenter.direction;
                        },
                        onPanEnd: (details) {
                          setState(
                            () {
                              _oldAngle = _angle;
                            },
                          );
                        },
                        onPanUpdate: (details) {
                          final touchPositionFromCenter =
                              details.localPosition - centerOfGestureDetector;

                          setState(
                            () {
                              _angle = touchPositionFromCenter.direction +
                                  _angleDelta;
                            },
                          );
                        },
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          margin: const EdgeInsets.all(15),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.topLeft,
                                children: const [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: PlanetWidget(
                                      name: "Mercury",
                                      color: Colors.grey,
                                      color2: Color.fromARGB(255, 94, 93, 93),
                                      moons: 0,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: PlanetWidget(
                                      name: "Earth",
                                      color: Color.fromARGB(255, 5, 119, 212),
                                      color2: Color.fromARGB(255, 5, 119, 212),
                                      color3: Color.fromARGB(255, 76, 175, 160),
                                      color4: Colors.white,
                                      moons: 1,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: PlanetWidget(
                                      name: "Jupiter",
                                      color2: Colors.orange,
                                      color: Colors.white,
                                      color4: Colors.brown,
                                      color3:
                                          Color.fromARGB(255, 228, 173, 153),
                                      moons: 57,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: PlanetWidget(
                                      name: "Uranus",
                                      color: Colors.blue,
                                      color2: Colors.green,
                                      color3: Colors.blue,
                                      color4: Colors.green,
                                      moons: 27,
                                    ),
                                  ),
                                ],
                              ),
                              Transform.rotate(
                                angle: 360 - 45,
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: const [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: PlanetWidget(
                                        name: "Venus",
                                        color2: Colors.grey,
                                        color: Colors.brown,
                                        moons: 0,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: PlanetWidget(
                                        name: "Mars",
                                        color: Colors.red,
                                        color2: Colors.brown,
                                        color3:
                                            Color.fromARGB(255, 228, 173, 153),
                                        color4:
                                            Color.fromARGB(255, 253, 124, 114),
                                        moons: 2,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: PlanetWidget(
                                        name: "Saturn",
                                        color:
                                            Color.fromARGB(255, 248, 182, 40),
                                        color2: Colors.brown,
                                        color3: Colors.blueGrey,
                                        color4:
                                            Color.fromARGB(255, 248, 182, 40),
                                        moons: 63,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: PlanetWidget(
                                        name: "Neptune",
                                        color: Colors.blue,
                                        color2:
                                            Color.fromARGB(255, 87, 176, 249),
                                        color3:
                                            Color.fromARGB(255, 142, 204, 255),
                                        color4:
                                            Color.fromARGB(255, 181, 220, 253),
                                        moons: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: (MediaQuery.of(context).size.height) - 80,
          // left: 0,
          right: (MediaQuery.of(context).size.width / 2) - 80,
          child: SizedBox(
            height: 80,
            width: 160,
            child: Center(
              child: Text(
                (_angle * math.pi).round().toString(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
