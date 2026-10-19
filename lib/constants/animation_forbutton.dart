import 'package:flutter/material.dart';

class BounceButton extends StatefulWidget {
  final Widget child; // 👈 1. මෙතනින් ඕනෑම child widget එකක් pass කරගන්න පුළුවන්
  final VoidCallback onTap; // 👈 Tap කළාම වෙන දේ (Page navigate / next)
  final Duration duration;

  const BounceButton({
    super.key,
    required this.child,
    required this.onTap,
    this.duration = const Duration(milliseconds: 150),
  });

  @override
  State<BounceButton> createState() => _BounceButtonState();
}

class _BounceButtonState extends State<BounceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0.0,
      upperBound: 0.1, // 0.1 කියන්නේ 10% කින් පොඩි වෙනවා (pressed state)
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward(); // Touch කළාම කුඩා වෙනවා
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse(); // අත ඇරියම ආයේ සාමාන්‍ය size එකට එනවා (Bounce!)
    widget.onTap(); // Original action එක trigger වෙනවා
  }

  void _onTapCancel() {
    _controller.reverse(); // Touch එක cancel වුණොත් සාමාන්‍ය ප්‍රමාණයට එනවා
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child, // 👈 2. මෙතනින් pass කරපු child එක render වෙනවා
      ),
    );
  }
}