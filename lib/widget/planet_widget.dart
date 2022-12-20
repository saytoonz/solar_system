import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_system/utils/app_colors.dart';

class PlanetWidget extends StatefulWidget {
  const PlanetWidget({
    super.key,
    this.moons = 0,
    this.color = AppColors.black,
    this.color2 = AppColors.black,
    this.color3 = AppColors.black,
    this.color4 = AppColors.black,
    this.name = "Mercury",
  });

  final int moons;
  final Color color, color2, color3, color4;
  final String name;

  @override
  State<PlanetWidget> createState() => _PlanetWidgetState();
}

class _PlanetWidgetState extends State<PlanetWidget>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _animationController?.forward();
    _animationController?.repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider.value(
      value: _animationController,
      child: Consumer<AnimationController>(
        builder: (context, animation, child) {
          return Transform.rotate(
            angle: math.pi * animation.value * 2,
            child: child,
          );
        },
        child: SizedBox(
          height: 45,
          width: 45,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      widget.color4,
                      widget.color3,
                      widget.color2,
                      widget.color,
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: widget.moons > 0,
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.moons > 1,
                child: Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.moons > 2,
                child: Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.moons > 3,
                child: Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      shape: BoxShape.circle,
                    ),
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
