import 'package:flutter/material.dart';
import 'package:nextmeal/models/category.dart';
import 'package:google_fonts/google_fonts.dart';
class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectcategory});
  final Category category;
  final void Function() onSelectcategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectcategory,
      splashColor: Colors.white38,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children:[
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image(image: category.image.image,fit: BoxFit.contain,),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Row(
                children: [
                  Text(
                  category.title,
                  style: GoogleFonts.inter(
                      fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
               const Icon(Icons.navigate_next_rounded,color: Colors.white,),
                ],
              ),
            ),

        ],
        ),
      ),
    );
  }
}
