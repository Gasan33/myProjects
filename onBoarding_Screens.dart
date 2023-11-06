import 'package:flutter/material.dart';
import 'package:shopping/Animations/Zoom2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget button(String txt) {
    return txt == 'SKIP'
        ? InkWell(
            onTap: () {
              controller.jumpToPage(2);
            },
            child: SizedBox(
              //color: Colors.black,
              width: MediaQuery.of(context).size.width / 3,
              child: Container(
                height: 48,
                width: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    //color: Colors.grey,
                    border: Border.all(
                        width: 0.5, color: Colors.pinkAccent.shade700)),
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: Text(
                        txt,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            child: SizedBox(
              //color: Colors.black,
              width: MediaQuery.of(context).size.width / 3,
              child: Container(
                height: 48,
                width: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.pinkAccent.shade700,
                  //border: Border.all(width: 1, color: Colors.grey)
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text(txt,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold))),
                ),
              ),
            ),
          );
  }

  Widget buildPage(
          {required Color color,
          required String urlImage,
          required String title,
          required String subTitle}) =>
      Container(
        color: color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                urlImage,
                fit: BoxFit.contain,
                height: 250.0,
                width: MediaQuery.of(context).size.width / 2,
                //width: double.minPositive,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    subTitle,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        color: Colors.white,
        child: PageView(
          controller: controller,
          onPageChanged: (index) => {
            setState(
              () {
                isLastPage = index == 2;
              },
            )
          },
          children: [
            buildPage(
                color: Colors.white,
                urlImage: 'lottie/faviorate_item.json',
                title: 'Find your favourite items',
                subTitle:
                    'Find your favourite items products that you need to buy daily'),
            buildPage(
                color: Colors.white,
                urlImage: 'lottie/payment.json',
                title: 'Easy & Safe Payment',
                subTitle: 'Pay for the products you buy safely & easily'),
            buildPage(
                color: Colors.white,
                urlImage: 'lottie/delivary.json',
                title: 'Product delivary',
                subTitle:
                    'your products are delivered home safely & securely in fastest way possible'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 20, right: 20, left: 20, bottom: 40),
              child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      backgroundColor: Colors.pinkAccent.shade700,
                      minimumSize: const Size.fromHeight(56)),
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const Zoom2()));
                  },
                  child: const Text(
                    "LET'S Started",
                    style: TextStyle(fontSize: 16.0),
                  )),
            )
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 20, right: 20, left: 20, bottom: 40),
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.pinkAccent.shade700),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      button('SKIP'),
                      // TextButton(
                      //     onPressed: () => controller.jumpToPage(2),
                      //     child: const Text('SKIP')),
                      button('NEXT'),
                      // TextButton(
                      //     onPressed: () => controller.nextPage(
                      //         duration: const Duration(milliseconds: 500),
                      //         curve: Curves.easeInOut),
                      //     child: const Text('NEXT')),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
