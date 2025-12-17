import 'package:flutter/material.dart';

class ItemTransition extends StatefulWidget  {
  final Widget content;

  const ItemTransition({super.key, required this.content});

  @override
  State<ItemTransition> createState() => _ItemTransitionState();
}

class _ItemTransitionState extends State<ItemTransition> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.content,
    );
  }
}
