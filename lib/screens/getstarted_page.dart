import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextmeal/screens/Enter_phonenumber_page.dart';

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/burger_first_page.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80), // Adjust as needed
              // Centered Row with Image and Text widgets
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Fading Icon with size adjustment
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.redAccent.shade700.withOpacity(0.9),
                        BlendMode.srcIn,
                      ),
                      child: const SizedBox(
                        width: 45, // Set the desired width
                        height: 45, // Set the desired height
                        child: Image(
                          image: AssetImage('assets/plate_forks.png'),
                        ),
                      ),
                    ),
                    //SizedBox(width: 10), // Adjust spacing between image and text
                    // RichText for Text 1 with faded color effect
                    RichText(
                      text: TextSpan(
                        text: 'nextMeal',
                        style: GoogleFonts.inter(
                          fontSize: 55,
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
                              Rect.fromLTWH(180.0, 0.0, 200.0, 100.0),
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Text 2
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    75.0, 10.0, 20.0, 10.0), // Adjust top padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        'Food',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.inter(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 300,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              // Text 3
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text(
                  'Order from top restaurants',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Spacer(), // Push the button to the bottom
              // Get Started button
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.redAccent.shade700, // Button color
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EnterPhoneNumberPage()),
                      );
                      // Handle button press
                    },
                    child: Text(
                      'Get started',
                      style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
