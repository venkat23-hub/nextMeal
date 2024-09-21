import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextmeal/models/meal.dart';
import 'package:nextmeal/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextmeal/providers/favourites_provider.dart';

class MealItem extends ConsumerWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});
  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouritesMealsProvider);
    final isFavourite = favouriteMeals.contains(meal);
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(context, meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 180,
                width: double.infinity,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  final wasAdded = ref
                      .read(favouritesMealsProvider.notifier)
                      .toggleMealFavouriteStatus(meal);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(wasAdded
                          ? 'Meals added as favourite'
                          : 'Meal removed from favourites')));
                },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child ,animation) {
                    return RotationTransition(turns: Tween<double>(begin: 0.9 ,end:1.0 ).animate(animation), child: child,);
                  },
                  child:
                  Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
                  key: ValueKey(isFavourite),
                  color: isFavourite ? Colors.redAccent.shade700 : Colors.white,
                ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.redAccent.shade700,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // very long text ....
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const MealItemTrait(
                          icon: Icons.star,
                          //label: complexityText,
                          label: '4.5', //replace label with rating
                        ),
                        MealItemTrait(
                          label: '${meal.duration}min',
                          //label: '35min',//replace label with duration
                        ),
                        const MealItemTrait(
                          icon: Icons.currency_rupee,
                          // label: affordabilityText,
                          label: "250", //replace label with cost
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
