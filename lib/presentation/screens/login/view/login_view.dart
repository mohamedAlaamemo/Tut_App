import 'package:flutter/material.dart';
import 'package:mina_farid/app/di.dart';
import 'package:mina_farid/presentation/resources/assets_manger.dart';
import 'package:mina_farid/presentation/resources/color_manager.dart';
import 'package:mina_farid/presentation/resources/constants_manager.dart';
import 'package:mina_farid/presentation/resources/strings_manager.dart';
import 'package:mina_farid/presentation/resources/values_manager.dart';
import 'package:mina_farid/presentation/screens/login/view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginViewModel _viewModel = instance<LoginViewModel>();

  @override
  void initState() {
    _usernameController.addListener(() {
      _viewModel.setUserName(_usernameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: AppPadding.p100),
                  child: Image(image: AssetImage(ImageAssets.splashLogo)),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.userNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: AppStrings.username,
                            hintText: AppStrings.username,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError,
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.passwordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: AppStrings.password,
                              hintText: AppStrings.password,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.passwordError),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: SizedBox(
                    width: double.infinity,
                    child: StreamBuilder<bool>(
                      stream: _viewModel.allDataValid,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          onPressed: (snapshot.data??false)?(){
                            _viewModel.login();
                          }:null,
                          child: const Text(
                            AppStrings.login,
                          ),
                        );
                      }
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: AppPadding.p28, right: AppPadding.p28),
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                foregroundColor: ColorManager.grey),
                            child: Text(
                              AppStrings.forgetPassword,
                              style: TextStyle(color: ColorManager.primary),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: AppPadding.p28, right: AppPadding.p28),
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                foregroundColor: ColorManager.grey),
                            child: Text(
                              AppStrings.registerText,
                              style: TextStyle(color: ColorManager.primary),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
