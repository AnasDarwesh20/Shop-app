import 'package:flutter/material.dart';
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shop_app/login/login_shop_app.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;

  final String title;

  final body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'images/image.jpg',
      title: 'Let is get started ...',
      body: '',
    ),
    BoardingModel(
      image: 'images/image.jpg',
      title: 'Browse new hot offers !',
      body: '',
    ),
    BoardingModel(
      image: 'images/image.jpg',
      title: 'The shopping will be easier :) ',
      body: '',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'Skip',
            ),
          ),
        ],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    }
                    boardController.nextPage(
                      duration: Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateTo(context, ShopLoginScreen());
      }
    });
  }

  Widget buildBoardingItem(BoardingModel onBoard) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage(
                  "${onBoard.image}",
                ),
                width: double.infinity,
                height: 500.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              '${onBoard.title}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              ' ${onBoard.body} ',
            ),
          ],
        ),
      );
}
