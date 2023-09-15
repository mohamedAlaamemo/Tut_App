import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mina_farid/app/di.dart';
import 'package:mina_farid/presentation/common/state_rerender/state_renderer_impl.dart';
import 'package:mina_farid/presentation/resources/assets_manger.dart';
import 'package:mina_farid/presentation/resources/color_manager.dart';
import 'package:mina_farid/presentation/resources/routes_manager.dart';
import 'package:mina_farid/presentation/resources/strings_manager.dart';
import 'package:mina_farid/presentation/resources/values_manager.dart';
import 'package:mina_farid/presentation/screens/login/view_model/login_view_model.dart';

import '../../../../app/app_prefs.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();


  @override
  void initState() {
    _usernameController.addListener(() {
      _viewModel.setUserName(_usernameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context,showScaffold(),(){
              _viewModel.login();
            })??showScaffold();
          }
      ),
      floatingActionButton: InkWell(onTap:(){_changeLanguage();},child: Icon(Icons.ac_unit)),
    );
  }
  _changeLanguage() {
    // i will implement it later
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }
  Widget showScaffold() {
    return  SingleChildScrollView(
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
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          labelText: AppStrings.emailHint.tr(),
                          hintText: AppStrings.emailHint.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.invalidEmail.tr(),
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
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                            labelText: AppStrings.password.tr(),
                            hintText: AppStrings.password.tr(),
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError.tr()),
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
                          onPressed: (snapshot.data ?? false) ? () {
                            _viewModel.login();
                          } : null,
                          child:  Text(
                            AppStrings.login.tr(),
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
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: ColorManager.grey),
                          child: Text(
                            AppStrings.forgetPassword.tr(),
                            style: TextStyle(color: ColorManager.primary),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.registerRoute);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: ColorManager.grey),
                          child: Text(
                            AppStrings.registerText.tr(),
                            style: TextStyle(color: ColorManager.primary),
                          )),
                    ),
                  ),
                ],
              ),
            ],
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
