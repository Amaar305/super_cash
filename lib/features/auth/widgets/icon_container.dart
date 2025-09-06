import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    this.width,
    this.height,
    this.color,
    this.radius,
    this.child,
    required this.imagePath,
    this.onTap,
  });
  final double? width, height, radius;
  final Color? color;
  final Widget? child;
  final String imagePath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 50,
      height: height ?? 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 10),
        color: color,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius ?? 10),
        onTap: onTap,
        child: Center(
          child: SizedBox.square(
            dimension: 35,
            child: child,
          ),
        ),
      ),
    );
  }
}
