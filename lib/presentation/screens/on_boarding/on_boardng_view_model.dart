import 'dart:async';

import 'package:mina_farid/presentation/base/base_view_model.dart';

import '../../../domain/model/model.dart';
import '../../resources/assets_manger.dart';
import '../../resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    implements OnboardingViewModelInput, OnboardingViewModelOutput {
    int _currentIndex=0;
  final StreamController _streamController =
      StreamController<OnboardingOutputViewModel>();

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _postData();
    print('in start $_currentIndex');
  }

  @override
  int goNext() {
    return (++_currentIndex % _listItem.length);
  }

  @override
  int goPrev() {
    return (--_currentIndex % _listItem.length);

  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postData();
  }

  // private data
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
  Sink get inputViewModel => _streamController.sink;

  @override
  Stream<OnboardingOutputViewModel> get outputViewModel =>
      _streamController.stream
          .map((onboardingOutputViewModel) => onboardingOutputViewModel);
  void _postData(){
    inputViewModel.add(OnboardingOutputViewModel(_listItem[_currentIndex], _currentIndex, _listItem.length) );
  }
}

abstract class OnboardingViewModelInput {
  int goNext();

  int goPrev();

  void onPageChanged(int index);

  Sink get inputViewModel;
}

abstract class OnboardingViewModelOutput {
  Stream<OnboardingOutputViewModel> get outputViewModel;
}
