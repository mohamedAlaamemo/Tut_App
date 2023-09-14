class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest(this.email);
}

class RegisterRequest {
  String userName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String photo;

  RegisterRequest(this.userName, this.countryCode, this.mobileNumber,
      this.email, this.password, this.photo);
}
