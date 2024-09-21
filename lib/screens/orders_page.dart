import 'package:flutter/material.dart';
import 'package:nextmeal/data/dummy_data.dart';
import 'package:nextmeal/screens/bottom_bar.dart';
import 'package:nextmeal/screens/explore_page.dart';
import 'package:nextmeal/screens/home_screen.dart';
import 'package:nextmeal/screens/profile_page.dart';
import 'package:nextmeal/screens/search_screen.dart';
import 'package:google_fonts/google_fonts.dart';
class OrdersPage extends StatefulWidget {
   OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
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
            title: Text('MY ORDERS',style: GoogleFonts.inter(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w500),textAlign: TextAlign.start,),
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
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
                  onPressed: () {},
                  icon:const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 28,
                  )),

            ],
          ),
        ),
    );
  }
}
