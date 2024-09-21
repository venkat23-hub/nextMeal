import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextmeal/models/meal.dart';
import 'package:nextmeal/screens/search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextmeal/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  final Meal meal;

  const MealDetailsScreen({
    required this.meal,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouritesMealsProvider);
    final isFavourite = favouriteMeals.contains(meal);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(),
                      transitionDuration: const Duration(milliseconds: 1000),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              IconButton(
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
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: Tween<double>(begin: 0.9, end: 1.0)
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: Icon(isFavourite ? Icons.star : Icons.star_border,
                      key: ValueKey(isFavourite)),
                ),
              ),
            ],
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: meal.id,
                    child: Image.network(
                      meal.imageUrl,
                      height: 218,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    meal.title,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
