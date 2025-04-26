import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget? child;
  final Widget? topLogo;
  final Widget? bottomLogo;
  final Widget? centerLogo;
  final bool fitTopWidth;
  final bool fitBottomWidth;
  final bool showTopLogo;
  final bool showBottomLogo;
  final bool showCenterLogo;
  final Gradient? Function(double?)? gradientBuilder;
  final double gradientOpacity;
  final bool animateGradient;
  final int gradientStart;
  final Function(AnimationController)? onGradientAnimationCreated;

  const AppBackground({
    super.key,
    this.child,
    this.topLogo,
    this.bottomLogo,
    this.centerLogo,
    this.fitTopWidth = false,
    this.fitBottomWidth = false,
    this.showTopLogo = true,
    this.showBottomLogo = true,
    this.showCenterLogo = false,
    this.gradientBuilder,
    this.gradientOpacity = 0.15,
    this.animateGradient = false,
    this.gradientStart = 0,
    this.onGradientAnimationCreated,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatableGradientView(
            gradientOpacity: gradientOpacity,
            gradientBuilder: gradientBuilder,
            animateGradient: animateGradient,
            gradientStart: gradientStart,
            onGradientAnimationCreated: onGradientAnimationCreated,
          ),
        ),
        if (showTopLogo && topLogo != null)
          Positioned(
            top: 0,
            right: 0,
            left: fitTopWidth ? 0 : null,
            child: topLogo!,
          ),
        if (showCenterLogo && centerLogo != null)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: centerLogo!,
          ),
        if (showBottomLogo && bottomLogo != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: fitBottomWidth ? 0 : null,
            child: bottomLogo!,
          ),
        if (child != null) Positioned.fill(child: child!),
      ],
    );
  }
}

class AnimatableGradientView extends StatefulWidget {
  const AnimatableGradientView({
    super.key,
    required this.gradientOpacity,
    required this.gradientBuilder,
    this.animateGradient = false,
    this.gradientStart = 0,
    this.onGradientAnimationCreated,
  });

  final double gradientOpacity;
  final Gradient? Function(double?)? gradientBuilder;
  final bool animateGradient;
  final int gradientStart;
  final Function(AnimationController)? onGradientAnimationCreated;

  @override
  State<AnimatableGradientView> createState() => _AnimatableGradientViewState();
}

class _AnimatableGradientViewState extends State<AnimatableGradientView>
    with SingleTickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 18),
      vsync: this,
    );

    _animation = StepTween(
            begin: widget.gradientStart, end: widget.gradientStart + 360)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    if (widget.animateGradient) {
      _controller.forward();

      if (widget.onGradientAnimationCreated != null) {
        widget.onGradientAnimationCreated!(_controller);
      }

      _controller.addStatusListener(_onStatusChanged);
    }

    super.initState();
  }

  void _onStatusChanged(status) {
    if (status == AnimationStatus.completed) {
      _controller.repeat();
    }
    //  else if (status == AnimationStatus.dismissed) {
    //   _controller.forward();
    // }
  }

  @override
  void dispose() {
    if (widget.animateGradient) {
      _controller.removeStatusListener(_onStatusChanged);
    }

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (ctx, snapshot) {
        return Opacity(
          opacity: widget.gradientOpacity,
          child: Container(
            decoration: BoxDecoration(
              gradient: widget.gradientBuilder != null
                  ? widget
                      .gradientBuilder!((_animation.value as int).toDouble())
                  : null,
            ),
          ),
        );
      },
    );
  }
}
