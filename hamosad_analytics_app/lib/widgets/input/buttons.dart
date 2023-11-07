import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconButtonWithHover extends StatefulWidget {
  const IconButtonWithHover({
    super.key,
    required this.icon,
    this.iconSize,
    this.iconColor,
    this.iconHoverColor,
    this.onPressed,
  });

  final IconData icon;
  final double? iconSize;
  final Color? iconColor, iconHoverColor;
  final VoidCallback? onPressed;

  @override
  State<IconButtonWithHover> createState() => _IconButtonWithHoverState();
}

class _IconButtonWithHoverState extends State<IconButtonWithHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        _isHovered = true;
      }),
      onExit: (event) => setState(() {
        _isHovered = false;
      }),
      child: IconButton(
        icon: FaIcon(
          widget.icon,
          color: _isHovered ? widget.iconHoverColor : widget.iconColor,
          size: widget.iconSize,
        ),
        padding: EdgeInsets.zero,
        iconSize: widget.iconSize,
        onPressed: widget.onPressed,
      ),
    );
  }
}
