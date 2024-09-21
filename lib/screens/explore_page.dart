import 'package:flutter/material.dart';
import 'package:nextmeal/data/dummy_data.dart';
import 'package:nextmeal/screens/favourites_screen.dart';
import 'package:nextmeal/screens/meal_details_screen.dart';
import 'package:nextmeal/screens/search_screen.dart';
import 'package:nextmeal/screens/bottom_bar.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextmeal/models/meal.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  static List<Meal> availableMeals = dummyMeals;
  List<Meal> exploreMeals = List.from(availableMeals);
  var brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  @override
  Widget build(BuildContext context) {
    bool isDark = brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 218),
          child: AppBar(
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
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const SearchScreen(),
                      transitionDuration: const Duration(milliseconds: 800),
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
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/explore_page_appbar.png', // Path to your background image
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        onTap: () {},
                        child: const Text('veg'),
                      ),
                      const PopupMenuItem(
                        child: Text('non-veg'),
                      ),
                      const PopupMenuItem(
                        child: Text('desserts'),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Filters',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 13),
                          ),
                          //   const Icon(Icons.filter,color: Colors.black,size: 20,),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        onTap: () {},
                        child: const Text('veg'),
                      ),
                      const PopupMenuItem(
                        child: Text('non-veg'),
                      ),
                      const PopupMenuItem(
                        child: Text('desserts'),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Delivery time',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 13),
                          ),
                          //  const Icon(Icons.arrow_drop_down_circle ,color: Colors.black,size: 20,),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        onTap: () {},
                        child: const Text('veg'),
                      ),
                      const PopupMenuItem(
                        child: Text('non-veg'),
                      ),
                      const PopupMenuItem(
                        child: Text('desserts'),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Cost',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 13),
                          ),
                          //  const Icon(Icons.arrow_drop_down_circle ,color: Colors.black,size: 20,),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        onTap: () {},
                        child: const Text('veg'),
                      ),
                      const PopupMenuItem(
                        child: Text('non-veg'),
                      ),
                      const PopupMenuItem(
                        child: Text('desserts'),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Rating',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 13),
                          ),
                          //  const Icon(Icons.arrow_drop_down_circle ,color: Colors.black,size: 20,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 1),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: availableMeals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => MealDetailsScreen(meal: availableMeals[index]),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  availableMeals[index].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 45,
                                  color: Colors.redAccent.shade700,
                                  child: GridTileBar(
                                    title: Text(
                                      availableMeals[index].title!,
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Rating',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${availableMeals[index].duration} mins',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Cost',
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
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: (){},
                                 icon: const Icon(Icons.favorite_border),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
