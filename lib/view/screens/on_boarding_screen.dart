import 'package:flutter/material.dart';
import 'package:shop/constants/namepage.dart';
import 'package:shop/data/sheard_pref/sheard_pref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Boarding {
  final String image;
  final String title;
  final String body;

  Boarding({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Boarding> onBoarding = [
    Boarding(
        image: 'assets/image/page1.jpg', title: 'Title 1 ', body: 'Body 1'),
    Boarding(
        image: 'assets/image/page2.jpg', title: 'Title 2 ', body: 'Body 2'),
    Boarding(image: 'assets/image/page3.jpg', title: 'Title 3 ', body: 'Body 3')
  ];
  var controller = PageController();
  bool isLogin = false;

  void submit() {
    CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: submit, child: const Text('SKIP'))],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 30, right: 20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    if (index == 2) {
                      isLogin = true;
                    } else {
                      isLogin = false;
                    }
                  });
                },
                physics: const BouncingScrollPhysics(),
                controller: controller,
                itemBuilder: (context, index) => buildPages(onBoarding[index]),
                itemCount: onBoarding.length,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: onBoarding.length,
                  effect: const ExpandingDotsEffect(
                      expansionFactor: 3,
                      activeDotColor: Colors.deepOrange,
                      dotColor: Colors.grey,
                      //activeDotColor:
                      spacing: 4,
                      dotWidth: 13,
                      dotHeight: 13),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLogin) {
                      submit();
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Column buildPages(Boarding boarding) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            boarding.image,
            scale: 1.5,
          ),
        ),
        Text(
          boarding.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          boarding.body,
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Raleway',
          ),
        ),
      ],
    );
  }
}
