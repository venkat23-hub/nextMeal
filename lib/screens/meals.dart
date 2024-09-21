import 'package:flutter/material.dart';
import 'package:nextmeal/models/meal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextmeal/screens/bottom_bar.dart';
import 'package:nextmeal/screens/favourites_screen.dart';
import 'package:nextmeal/widgets/meal_item.dart';
import 'package:nextmeal/screens/meal_details_screen.dart';
import 'package:nextmeal/screens/search_screen.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key, this.title, required this.meals});
  final String? title;
  final List<Meal> meals;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => Text(
        widget.meals[index].title,
      ),
    );
    if (widget.meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Uh oh.... Nothing here!',
                style: GoogleFonts.lato(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                'Try selecting a different category',
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70),
              ),
            ),
          ],
        ),
      );
    }
    if (widget.meals.isNotEmpty) {
      content = GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: widget.meals[index],
          onSelectMeal: (context, meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }
    if (widget.title == null) {
      return content;
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Scaffold(
          bottomSheet: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
            child: BottomAppBar(
              color: Colors.redAccent.shade700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // PopupMenuButton(
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(12.0),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           'Filters',
                  //           style: GoogleFonts.inter(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 13),
                  //         ),
                  //      //   const Icon(Icons.filter,color: Colors.black,size: 20,),
                  //       ],
                  //     ),
                  //   ),
                  //   itemBuilder: (BuildContext context) => [
                  //     PopupMenuItem(
                  //       onTap: () {},
                  //       child: const Text('veg'),
                  //     ),
                  //     const PopupMenuItem(
                  //       child: Text('non-veg'),
                  //     ),
                  //     const PopupMenuItem(
                  //       child: Text('desserts'),
                  //     ),
                  //   ],
                  // ),
                  PopupMenuButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Delivery time',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 13),
                          ),
                        //  const Icon(Icons.arrow_drop_down_circle ,color: Colors.black,size: 20,),
                        ],
                      ),
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        onTap: () {},
                        child: const Text('15mins'),
                      ),
                      const PopupMenuItem(
                        child: Text('30mins'),
                      ),
                      const PopupMenuItem(
                        child: Text('45mins'),
                      ),
                    ],
                  ),
                  PopupMenuButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Cost',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 13),
                          ),
                        //  const Icon(Icons.arrow_drop_down_circle ,color: Colors.black,size: 20,),
                        ],
                      ),
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        onTap: () {},
                        child: const Text('200'),
                      ),
                      const PopupMenuItem(
                        child: Text('250'),
                      ),
                      const PopupMenuItem(
                        child: Text('300'),
                      ),
                    ],
                  ),
                  PopupMenuButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Rating',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 13),
                          ),
                       //  const Icon(Icons.arrow_drop_down_circle ,color: Colors.black,size: 20,),
                        ],
                      ),
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        onTap: () {},
                        child: const Text('3.5'),
                      ),
                      const PopupMenuItem(
                        child: Text('4'),
                      ),
                      const PopupMenuItem(
                        child: Text('4.5'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

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
            actions: [

              IconButton(
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => FavouritesScreen(),
                        transitionDuration: const Duration(milliseconds: 250),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const curve = Curves.easeInOut;
                          final curvedAnimation = CurvedAnimation(
                            parent: animation,
                            curve: curve,
                          );

                          return ScaleTransition(
                            scale: curvedAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 28,
                  )),
            ],
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Colors.black12,
          ),
          body: content,
        ),
      ),
    );
  }
}
