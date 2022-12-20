import 'package:flutter/material.dart';

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
          top: MediaQuery.of(context).size.height - 200,
          left: 0,
          right: 0,
          child: Transform.rotate(
            angle: _angle,
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
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
                      );
                    },
                  ),
                ),
                Container(
                  height: 0,
                  width: 5,
                  color: Colors.black,
                ),
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
