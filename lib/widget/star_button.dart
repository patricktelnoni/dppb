import 'package:flutter/material.dart';

class StarButton extends StatefulWidget {
  final Future<bool> Function()? onPressed;
  
  const StarButton({super.key, this.onPressed});

  @override
  State<StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  bool state = false;
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;

  Icon get icon {
    final IconData iconData = state ? Icons.star : Icons.star_outline;
    final Color iconColor = state ? Colors.amber : Colors.grey;

    return Icon(iconData, color: iconColor, size: 24);
  }

  Future<void> _toggle() async {
    // Optimistic update
    setState(() {
      state = !state;
    });
    
    if (widget.onPressed != null) {
      bool success = await widget.onPressed!();
      if (!success) {
        // Rollback if failed
        if (mounted) {
          setState(() {
            state = !state;
          });
        }
      }
    }
  }

  double get turns => state ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: turns,
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 300),
      child: IconButton( // Changed to IconButton for better touch target and standard look
        icon: icon,
        onPressed: () => _toggle(),
        style: IconButton.styleFrom(
           backgroundColor: Colors.white,
           elevation: 2,
           shadowColor: Colors.black12
        ),
      ),
    );
  }
}
