import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrapp/res/constant.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        isTopSafeArea: true,
        done: const Text('Sign in'),
        onDone: () => Get.toNamed('/login'),
        showSkipButton: true,
        skip: const Text('Skip'),
        next: const Icon(Icons.chevron_right),
        color: colorAccent,
        nextColor: colorAccent,
        skipColor: colorAccent,
        dotsDecorator: DotsDecorator(
          activeColor: colorAccent,
          activeSize: const Size(22, 8),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        pages: [
          PageViewModel(
            title: 'Sourcing curated professional talents',
            body:
                'The Marketplace Curation Algorithm (MCA) filters and curates the top 5-10% of competitive talents seeking opportunities based on real-time demand of job roles.',
            image: Lottie.asset('assets/data.json'),
            decoration: PageDecoration(
              bodyAlignment: Alignment.center,
              imageAlignment: Alignment.bottomCenter,
              titleTextStyle: kHeadingOne,
              contentMargin: const EdgeInsets.symmetric(horizontal: 50),
              bodyTextStyle: kHeadingThree.copyWith(
                  fontWeight: FontWeight.normal, height: 1.5),
            ),
          ),
          PageViewModel(
            title:
                'Insights on salary expectations for employers and candidates',
            body:
                'The Budget Prediction Algorithm (BPA) effectively measures, predicts, and recommends job posting budget range based on current market condition and human capital to ensure managed expectations of both parties.',
            image: Lottie.asset('assets/select.json'),
            decoration: PageDecoration(
              bodyAlignment: Alignment.center,
              imageAlignment: Alignment.bottomCenter,
              titleTextStyle: kHeadingOne,
              contentMargin: const EdgeInsets.symmetric(horizontal: 50),
              bodyTextStyle: kHeadingThree.copyWith(
                  fontWeight: FontWeight.normal, height: 1.5),
            ),
          ),
          PageViewModel(
            title: 'Automated matching of roles with the best talents',
            body:
                'Our proprietary Ekrut Recommender System (ERS) dynamically matches top active professionals to roles based on a multitude of variables including but not limited to experiences, preferences, skills etc.',
            image: Lottie.asset('assets/deal.json'),
            decoration: PageDecoration(
              bodyAlignment: Alignment.center,
              imageAlignment: Alignment.bottomCenter,
              titleTextStyle: kHeadingOne,
              contentMargin: const EdgeInsets.symmetric(horizontal: 50),
              bodyTextStyle: kHeadingThree.copyWith(
                  fontWeight: FontWeight.normal, height: 1.5),
            ),
          )
        ],
      ),
    );
  }
}
