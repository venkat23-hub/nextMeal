import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextmeal/screens/favourites_screen.dart';
import 'package:nextmeal/screens/meals.dart';
import 'package:nextmeal/screens/search_result_screen_meals.dart';
import 'package:nextmeal/widgets/category_grid_item.dart';
import 'package:nextmeal/models/category.dart';
import 'package:nextmeal/data/dummy_data.dart';
import 'package:nextmeal/models/meal.dart';
import 'package:flutter/scheduler.dart';

class HomeScreenPage extends StatefulWidget {
  HomeScreenPage({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  static List<Meal> searchList = dummyMeals;
  List<Meal> displayList = List.from(searchList);
  void updateList(String value) {
    setState(() {
      displayList = searchList
          .where((element) =>
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void navigateToSearchResults() {
    if (searchController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a search term.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SearchResultScreen(searchResults: displayList),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
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
    }
  }

  TextEditingController searchController = TextEditingController();

  var brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => MealsScreen(
                title: category.title,
                meals: filteredMeals,
              )),
    );
  }
  bool _isOnHomeScreen = true;

  @override
  Widget build(BuildContext context) {
    bool isDark = brightness == Brightness.dark;
    return PopScope(
      canPop: _isOnHomeScreen,
      onPopInvoked: (didPop) async {
        if (_isOnHomeScreen) {
          // Close the app
          await SystemNavigator.pop();
        }
      },

      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Colors.black,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.redAccent.shade700.withOpacity(0.9),
                      BlendMode.srcIn,
                    ),
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Image(
                        image: AssetImage('assets/plate_forks.png'),
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'nextMeal',
                      style: GoogleFonts.inter(
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [
                              Color(0xFF8D1F1F), // #8D1F1F
                              Color(0xFFF5793B), // #F5793B
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(
                            const Rect.fromLTWH(130.0, 0.0, 100.0, 100.0),
                          ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 55),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              FavouritesScreen(),
                          transitionDuration: const Duration(milliseconds: 250),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                    icon: const Icon(Icons.favorite_outline,
                        size: 28, color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_shopping_cart,
                        size: 28, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: TextField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) => updateList(value),
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'search',
                          hintStyle: const TextStyle(color: Colors.white70),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white70,
                          ),
                          suffixIcon: IconButton(
                            onPressed: navigateToSearchResults,
                            icon: const Icon(Icons.search),
                            color: Colors.red,
                          ),
                          focusColor: Colors.redAccent,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red.shade900,
                              width: 1,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ImageSlideshow(
                        indicatorColor: Colors.blue,
                        autoPlayInterval: 8000,
                        isLoop: true,
                        children: [
                          Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset('assets/home_page_image.png',
                                  fit: BoxFit.cover),
                              Positioned(
                                left: 20,
                                top: 20,
                                child: Text(
                                  'Crunch',
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 80,
                                top: 50,
                                child: Text(
                                  'munch',
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 80,
                                child: Text(
                                  'and enjoy!',
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Image.asset('assets/home_page_image-2.jpeg',
                              fit: BoxFit.cover),
                          Image.asset('assets/home_page_image-3.jpeg',
                              fit: BoxFit.cover),
                          Image.asset('assets/home_page_image-4.jpeg',
                              fit: BoxFit.cover),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "What's in your mind ",
                          style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.black,
                      height: 250,
                      width: double.infinity,
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        children: [
                          for (final category in availableCategories)
                            CategoryGridItem(
                              category: category,
                              onSelectcategory: () {
                                _selectCategory(context, category);
                              },
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Offers!!",
                          style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(width: 120),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'see all',
                              style: GoogleFonts.inter(
                                  fontSize: 15, color: Colors.blue.shade800),
                            )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: Colors.black,
                      height: 250,
                      width: double.infinity,
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        children: [
                          for (final category in availableCategories)
                            CategoryGridItem(
                              category: category,
                              onSelectcategory: () {
                                _selectCategory(context, category);
                              },
                            )
                        ],
                      ),
                    ),
                    Center(
                        child: Text(
                      "contact details",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
