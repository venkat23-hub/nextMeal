import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextmeal/screens/bottom_bar.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/scheduler.dart';

class OtpVerificationPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const OtpVerificationPage({super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
  TextEditingController otpController = TextEditingController();
  bool isResending = false;
  late String verificationId;
  int resendTokenTimeout = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    verificationId = widget.verificationId;
    startResendTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void startResendTimer() {
    setState(() {
      resendTokenTimeout = 30;
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (resendTokenTimeout > 0) {
          resendTokenTimeout--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  Future<void> _resendOtp() async {
    setState(() {
      isResending = true;
    });

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to resend OTP. Please try again later.')),
          );
        },
        codeSent: (String newVerificationId, int? resendToken) {
          setState(() {
            verificationId = newVerificationId;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OTP resent successfully.')),
          );
          startResendTimer();
        },
        codeAutoRetrievalTimeout: (String newVerificationId) {},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to resend OTP. Please try again later.')),
      );
    } finally {
      setState(() {
        isResending = false;
      });
    }
  }

  Future<void> _saveUserData(String phoneNumber, String otp) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      'phoneNumber': phoneNumber,
      'otp': otp,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.red,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    bool isDark = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 90),
            Text(
              'Verify OTP sent to your number',
              style: GoogleFonts.inter(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 50),
            Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              controller: otpController,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: otpController.text,
                    );

                    await FirebaseAuth.instance.signInWithCredential(credential);

                    // Save user data to Firestore
                    await _saveUserData(widget.phoneNumber, otpController.text);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => BottomBarScreen()),
                          (route) => false,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid OTP! Please try again.')),
                    );
                  }
                },
                child: Text(
                  'Continue',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: resendTokenTimeout > 0 ? null : _resendOtp,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Didn't receive? Try again.",
                    style: GoogleFonts.inter(color: Colors.white),
                  ),
                  if (resendTokenTimeout > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "($resendTokenTimeout s)",
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
