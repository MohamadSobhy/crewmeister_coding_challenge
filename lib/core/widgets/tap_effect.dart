import 'package:flutter/material.dart';

class TapEffect extends StatefulWidget {
  const TapEffect({
    Key? key,
    this.isClickable = true,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final bool isClickable;
  final VoidCallback? onTap;
  final Widget child;

  @override
  _TapEffectState createState() => _TapEffectState();
}

class _TapEffectState extends State<TapEffect>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  DateTime tapTime = DateTime.now();
  bool isProgress = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animationController!.animateTo(
      1.0,
      duration: const Duration(milliseconds: 0),
      curve: Curves.fastOutSlowIn,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Future<void> onTapCancel() async {
    if (widget.isClickable) {
      await _onDelayed();
      _animationController!.animateTo(
        1.0,
        duration: const Duration(milliseconds: 240),
        curve: Curves.fastOutSlowIn,
      );
    }
    isProgress = false;
  }

  Future<void> _onDelayed() async {
    if (widget.isClickable) {
      //this logic creator like more press experience with some delay
      final int tapDuration = DateTime.now().millisecondsSinceEpoch -
          tapTime.millisecondsSinceEpoch;

      if (tapDuration < 120) {
        await Future<dynamic>.delayed(
          Duration(milliseconds: 120 - tapDuration),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (widget.isClickable) {
          await Future<dynamic>.delayed(const Duration(milliseconds: 200));

          try {
            if (!isProgress) {
              if (widget.onTap != null) {
                widget.onTap!();
              }

              isProgress = true;
            }
          } catch (_) {}
        }
      },
      onTapDown: (TapDownDetails details) {
        if (widget.isClickable) {
          tapTime = DateTime.now();
          _animationController!.animateTo(0.9,
              duration: const Duration(milliseconds: 120),
              curve: Curves.fastOutSlowIn);
        }
        isProgress = true;
      },
      onTapUp: (TapUpDetails details) {
        onTapCancel();
      },
      onTapCancel: () {
        onTapCancel();
      },
      child: AnimatedBuilder(
        animation: _animationController!,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: _animationController!.value,
            origin: const Offset(0.0, 0.0),
            child: widget.child,
          );
        },
      ),
    );
  }
}
