import 'package:flutter/material.dart';
import 'package:nextmeal/data/dummy_data.dart';
import 'package:nextmeal/models/meal.dart';
import 'package:nextmeal/screens/home_screen.dart';
import 'package:nextmeal/screens/meals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextmeal/providers/favourites_provider.dart';
class FavouritesScreen extends ConsumerStatefulWidget {
  const FavouritesScreen({super.key});

  @override
  ConsumerState<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends ConsumerState<FavouritesScreen> {

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomeScreenPage(availableMeals: dummyMeals);
final favouriteMeals = ref.watch(favouritesMealsProvider);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: Text(
          'Wishlist',
          style: GoogleFonts.inter(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: activePage = MealsScreen(
        meals: favouriteMeals,
      ),
    ));
  }
}
