import 'dart:ui';

import 'package:flutter/material.dart';

/// A glassmorphism container widget
/// Used throughout the Dream OS UI
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.blur = 10,
    this.opacity = 0.1,
    this.borderOpacity = 0.2,
    this.borderWidth = 1,
  });

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final double opacity;
  final double borderOpacity;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: opacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withValues(alpha: borderOpacity),
                width: borderWidth,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A glass button widget
class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height = 48,
    this.borderRadius = 12,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: width,
      height: height,
      borderRadius: borderRadius,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// A glass card widget
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = 16,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      child: onTap != null
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(borderRadius),
                child: child,
              ),
            )
          : child,
    );
  }
}
