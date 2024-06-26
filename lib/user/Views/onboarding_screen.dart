import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcare/share/board.dart';
import 'package:healthcare/user/Views/login_screen.dart';
import 'package:healthcare/user/Views/register_one.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isLastPage = false;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool showNextButton =
      true; // Variable to control the visibility of the "التالى" button

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    const autoPlayDuration = Duration(seconds: 3);
    Timer.periodic(
      autoPlayDuration,
      (timer) {
        if (_currentPage < 4) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      showNextButton = page <
          3; // Update the visibility of the "التالى" button based on page number
    });
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('تخطى'),
                const SizedBox(width: 0),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: const [
                  Boarding(
                    imagePass: "assets/Images/image 1.png",
                    //  uniSize: .6,
                    backgroundColor: Colors.white,
                    text: " التطعيمات",
                    title:
                        'ترشيح التطعيم المناسب لحالتك وحسب احتياجك، وأيضًا جميع التطعيمات متوفرة مع تفاصيل عنها.',
                  ),
                  Boarding(
                    imagePass: "assets/Images/image 2.png",
                    // uniSize: 0.6,
                    backgroundColor: Colors.white,
                    text: "التاريخ المرضي",
                    title:
                        'نسجيل و نتابعة حالتك الصحية و زياراتك للطبيب بشكل دقيق و منظم.',
                  ),
                  Boarding(
                    imagePass: "assets/Images/image 3.png",
                    backgroundColor: Colors.transparent,
                    text: "الفحص الكامل",
                    title:
                        'نحتفظ بجميع التحاليل و الفحوصات الخاصة بصحتك بشكل منظم حتى الحاجة إليها.',
                  ),
                  Boarding(
                    imagePass: "assets/Images/image 4.png",
                    backgroundColor: Colors.transparent,
                    text: "رفيق صحتك الإلكتروني",
                    title:
                        'رفيق صحتك الإلكتروني، يجيب على جميع استفساراتك وتساؤلاتك الطبية بشكل متكامل ودقيق.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 0.5),
          SmoothPageIndicator(
            controller: _pageController,
            count: 4,
            effect: WormEffect(
              activeDotColor: const Color(0xff28CC9E),
              dotColor: const Color(0xff28CC9E).withOpacity(0.3),
              dotHeight: 10,
              dotWidth: 10,
              spacing: 10,
            ),
          ),
          const SizedBox(height: 35),
          if (showNextButton)
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff28CC9E),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff000000).withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'التالى',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (!showNextButton && _currentPage == 3)
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff28CC9E),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff000000).withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'تسجيل دخول',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff28CC9E),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff000000).withOpacity(0.25),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => RegisterOne(),
                          ),
                        );
                      },
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'انشاء حساب',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
