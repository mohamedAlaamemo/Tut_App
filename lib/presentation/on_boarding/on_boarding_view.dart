import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mina_farid/presentation/resources/assets_manger.dart';
import 'package:mina_farid/presentation/resources/color_manager.dart';
import 'package:mina_farid/presentation/resources/strings_manager.dart';
import 'package:mina_farid/presentation/resources/values_manager.dart';

import '../resources/constants_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  final List<OnboardingObject> _listItem = [
    OnboardingObject(
      title: AppStrings.onBoardingTitle1,
      subTitle: AppStrings.onBoardingSubTitle1,
      image: ImageAssets.onboardingLogo1,
    ),
    OnboardingObject(
      title: AppStrings.onBoardingTitle2,
      subTitle: AppStrings.onBoardingSubTitle2,
      image: ImageAssets.onboardingLogo2,
    ),
    OnboardingObject(
      title: AppStrings.onBoardingTitle3,
      subTitle: AppStrings.onBoardingSubTitle3,
      image: ImageAssets.onboardingLogo3,
    ),
    OnboardingObject(
      title: AppStrings.onBoardingTitle4,
      subTitle: AppStrings.onBoardingSubTitle4,
      image: ImageAssets.onboardingLogo4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              itemCount: _listItem.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return onboardingItemView(object: _listItem[index]);
              },
            ),
          ),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.skip,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: AppSize.s40,
            color: ColorManager.primary,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSize.s8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.animateToPage((--_currentIndex%_listItem.length),  duration:  Duration(
                              milliseconds: AppConstants.sliderAnimationTime),
                              curve: Curves.bounceInOut);
                        });

                      },
                      child: SizedBox(
                          width: AppSize.s20,
                          height: AppSize.s20,
                          child: SvgPicture.asset(ImageAssets.arrowLeft)),
                    ),
                  ),
                ),
                for (int i = 0; i < _listItem.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (_currentIndex == i)
                        ? SvgPicture.asset(ImageAssets.solidCirlce)
                        : SvgPicture.asset(ImageAssets.hollowCirlce),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSize.s8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.animateToPage((++_currentIndex%_listItem.length),  duration:  Duration(
                              milliseconds: AppConstants.sliderAnimationTime),
                              curve: Curves.bounceInOut);
                        });
                      },
                      child: SizedBox(
                          width: AppSize.s20,
                          height: AppSize.s20,
                          child: SvgPicture.asset(ImageAssets.arrowRight)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget onboardingItemView({required OnboardingObject object}) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(
              object.title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          const SizedBox(
            height: AppSize.s8,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(
              object.subTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(
            height: AppSize.s8,
          ),
          SvgPicture.asset(object.image),
        ],
      ),
    );
  }
}

class OnboardingObject {
  String title;
  String subTitle;
  String image;

  OnboardingObject(
      {required this.title, required this.subTitle, required this.image});
}
