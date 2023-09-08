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

// Login Models
class CustomerModel {
  String id;
  String name;
  int numOfNotifications;

  CustomerModel(this.id, this.name, this.numOfNotifications);
}

class ContactsModel {
  String phone;
  String email;
  String link;

  ContactsModel(this.phone, this.email, this.link);
}

class LoginModel {
  CustomerModel? customer;
  ContactsModel? contacts;

  LoginModel(this.customer, this.contacts);
}



// forgotPassword model
class DataForgotPasswordModel{
  String id;
  String email;
  String password;
  DataForgotPasswordModel(this.id,this.email,this.password);
}

class ForgotPasswordModel{
  DataForgotPasswordModel? data;
  ForgotPasswordModel(this.data);
}


