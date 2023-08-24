class OnboardingObject {
  String title;
  String subTitle;
  String image;

  OnboardingObject(
      {required this.title, required this.subTitle, required this.image});
}
class OnboardingOutputViewModel{
   OnboardingObject? onboardingObject;
   int currentIndex;
   int lengthOfList;
  OnboardingOutputViewModel(this.onboardingObject,this.currentIndex,this.lengthOfList);
}