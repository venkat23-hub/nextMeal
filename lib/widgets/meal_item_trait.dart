import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealItemTrait extends StatefulWidget {
  const MealItemTrait({super.key, this.icon, required this.label});

  final IconData? icon;
  final String label;

  @override
  State<MealItemTrait> createState() => _MealItemTraitState();
}

class _MealItemTraitState extends State<MealItemTrait> {
  @override
  Widget build(BuildContext context) {
    if (widget.label == '4.5') {//replace label with rating
      return Row(
        children: [
          Text(
            widget.label,
            style: GoogleFonts.inter(fontSize:13, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          if (widget.icon != null)
            Icon(widget.icon, size: 13, color: Colors.yellow),
        ],
      );
    } else{ //replace label with rating
      return Row(
        children: [
          if (widget.icon != null)
            Icon(widget.icon, size: 13, color: Colors.white),
          Text(
            widget.label,
            style: GoogleFonts.inter(fontSize: 13,color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }
  }
}
