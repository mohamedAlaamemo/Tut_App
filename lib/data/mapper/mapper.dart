import 'package:mina_farid/app/extensions.dart';
import 'package:mina_farid/presentation/resources/constants_manager.dart';

import '../../domain/model/model.dart';
import '../response/responses.dart';

//login
extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  ContactsModel toDomain() {
    return ContactsModel(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension LoginResponseMapper on LoginResponse? {
  LoginModel toDomain() {
    return LoginModel(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}

//forgotPassword
extension DataForgotPasswordMapper on DataForgotPasswordResponse? {
  DataForgotPasswordModel toDomain() {
    return DataForgotPasswordModel(
      this?.id.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.password.orEmpty() ?? Constants.empty,
    );
  }
}

extension ForgotPasswordMapper on ForgotPasswordResponse? {
  ForgotPasswordModel toDomain() {
    return ForgotPasswordModel(this?.data.toDomain());
  }
}
