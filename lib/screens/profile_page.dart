import 'package:flutter/material.dart';
import 'package:nextmeal/screens/bottom_bar.dart';
import 'package:nextmeal/screens/favourites_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextmeal/screens/getstarted_page.dart';
import 'package:nextmeal/screens/search_screen.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _showLogoutDialog() async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Log out',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to log out?',
              style: GoogleFonts.inter()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No', style: GoogleFonts.inter(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GetStartedPage())); // Close the dialog
                // Add your logout logic here
              },
              child: Text('Yes', style: GoogleFonts.inter(color: Colors.red)),
            ),
          ],
        );
      },
    );
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged out successfully.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
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
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            'Profile',
            style: GoogleFonts.inter(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const SearchScreen(),
                    transitionDuration: const Duration(milliseconds: 1000),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const FavouritesScreen(),
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
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 28,
                )),
          ],
        ),
        body: Container(
          color: Colors.black,
          width: double.infinity,
          height: 569,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade700,
                              child: const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              )),
                          title: Text(
                            'Your Orders',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade700,
                              child: const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                              )),
                          title: Text(
                            'Wishlist',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const FavouritesScreen(),
                                transitionDuration:
                                    const Duration(milliseconds: 250),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade700,
                              child: const Icon(
                                Icons.wallet,
                                color: Colors.white,
                              )),
                          title: Text(
                            'Payment Settings',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade700,
                              child: const Icon(
                                Icons.card_giftcard,
                                color: Colors.white,
                              )),
                          title: Text(
                            'Collected Coupens',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade700,
                              child: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              )),
                          title: Text(
                            'Settings',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade700,
                              child: const Icon(
                                Icons.power_settings_new_outlined,
                                color: Colors.white,
                              )),
                          title: Text(
                            'Log out',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          onTap: _showLogoutDialog,
                        ),
                      ),
                    ],
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
