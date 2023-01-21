import 'dart:ui';

import 'package:fanimation/screens/onboding/components/animated_btn.dart';
import 'package:fanimation/screens/onboding/components/sign_in_form.dart';
import 'package:fanimation/screens/onboding/components/custom_sign_in_dialog.dart';
// import 'package:fanimation/screens/onboding/components/sign_in_form.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

//lets code
class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isSignInDialogShown = false;
  late RiveAnimationController _btnAnimationColtroller;

  @override
  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            // height: 100,
            bottom: 200,
            left: 100,
            width: MediaQuery.of(context).size.width * 1.7,
            child: Image.asset("assets/Backgrounds/Spline.png"),
          ),
          Image.asset("assets/Backgrounds/Spline.png"),
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            // top: isSignInDialogShown ? -50 : 0,
            duration: const Duration(milliseconds: 240),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 260,
                      child: Column(
                        children: const [
                          Text(
                            "Learn design & code",
                            style: TextStyle(
                              fontSize: 60,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                              "Don't skip design. Learn design and code by building real apps with Flutter and Shift.Complete courses about the best"),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    //add animation button
                    AnimatedBtn(
                      btnAnimationColtroller: _btnAnimationColtroller,
                      press: () {
                        _btnAnimationColtroller.isActive = true;
                        Future.delayed(const Duration(milliseconds: 800), () {
                          setState(() {
                            isSignInDialogShown = true;
                          });
                          //signup dialog box
                          //lets add animation design
                          customSigninDialog(context, onCLosed: (_) {
                            setState(() {
                              isSignInDialogShown = false;
                            });
                          });
                        });
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                          "Purchase includes accesss to 30 + courses , 240 + permium tutorials , 120+ hours of videos,source files and certificates."),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
