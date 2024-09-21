import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextmeal/models/meal.dart';
import 'package:nextmeal/screens/bottom_bar.dart';
import 'package:nextmeal/screens/meal_details_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextmeal/providers/favourites_provider.dart';

class SearchResultScreen extends ConsumerWidget {
  final List<Meal> searchResults;

  const SearchResultScreen({super.key, required this.searchResults});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final favouriteMeals = ref.watch(favouritesMealsProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => BottomBarScreen(),
                      transitionDuration: const Duration(milliseconds: 300),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        final tween = Tween(begin: begin, end: end);
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: curve,
                        );

                        return SlideTransition(
                          position: tween.animate(curvedAnimation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Colors.black,
            title: Text(
              'Search Results',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              childAspectRatio: 1, // Aspect ratio for the grid items
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final meal = searchResults[index];
              final isFavourite = favouriteMeals.contains(meal);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MealDetailsScreen(meal: searchResults[index]),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [

                      Positioned(
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          child: GridTile(
                            child: Image.network(
                              searchResults[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                            footer: Container(
                              width: double.infinity,
                              height: 45,
                              child: GridTileBar(
                                backgroundColor: Colors.redAccent.shade700,
                                title: Text(
                                  textAlign: TextAlign.start,
                                  searchResults[index].title!,
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Rating',
                                      //  '${searchResults[index].affordability}',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '${searchResults[index].duration}mins',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'cost',
                                      //'${searchResults[index].duration}mins',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: (){
                              final wasAdded = ref
                                  .read(favouritesMealsProvider.notifier)
                                  .toggleMealFavouriteStatus(searchResults[index]);
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(wasAdded
                                      ? 'Meals added as favourite'
                                      : 'Meal removed from favourites')));
                            },
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder: (child ,animation) {
                                return RotationTransition(turns: Tween<double>(begin: 0.9 ,end:1.0 ).animate(animation), child: child,);
                              },
                              child: Icon(
                              isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
                              key: ValueKey(isFavourite),
                              color: isFavourite ? Colors.redAccent.shade700 : Colors.white,
                            ),
                            ),),
                          ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
