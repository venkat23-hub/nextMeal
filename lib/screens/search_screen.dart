import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextmeal/data/dummy_data.dart';
import 'package:nextmeal/models/meal.dart';
import 'package:nextmeal/screens/bottom_bar.dart';
import 'package:nextmeal/screens/favourites_screen.dart';
import 'package:nextmeal/screens/home_screen.dart';
import 'package:nextmeal/screens/search_result_screen_meals.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        BottomBarScreen(),
                    transitionDuration: const Duration(milliseconds: 300),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
          title: Row(
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
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavouritesScreen()));
              },
              icon: const Icon(Icons.favorite_outline,
                  size: 28, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: searchController,
                keyboardType: TextInputType.text,
                onChanged: (value) => updateList(value),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
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
          ],
        ),
      ),
    );
  }
}
