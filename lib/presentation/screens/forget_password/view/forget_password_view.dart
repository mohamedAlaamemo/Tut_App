import 'package:flutter/material.dart';
import 'package:mina_farid/app/di.dart';
import 'package:mina_farid/presentation/common/state_rerender/state_renderer_impl.dart';
import 'package:mina_farid/presentation/resources/assets_manger.dart';
import 'package:mina_farid/presentation/resources/strings_manager.dart';
import 'package:mina_farid/presentation/resources/values_manager.dart';

import '../../../resources/color_manager.dart';
import '../view_model/forgot_view_model.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _textEditingController = TextEditingController();
  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();

  @override
  void initState() {
    _textEditingController.addListener(() {
      _viewModel.setEmail(_textEditingController.text);
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
            return snapshot.data?.getScreenWidget(context, showContent(), () {
                  _viewModel.resetPassword();
                }) ??
                showContent();
          }),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: AppPadding.p100),
            child: Image(image: AssetImage(ImageAssets.splashLogo)),
          ),
          const SizedBox(
            height: AppSize.s28,
          ),
          StreamBuilder<bool>(
              stream: _viewModel.emailValid,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
                      child: TextFormField(
                        controller: _textEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: AppStrings.emailHint,
                            hintText: AppStrings.emailHint,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.invalidEmail,

                        ),
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s40,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
                      child: ElevatedButton(
                        onPressed: !(snapshot.data ?? false)
                            ? null
                            : () {
                                _viewModel.resetPassword();
                              },
                        child: const Text(AppStrings.resetPassword),
                      ),
                    ),
                  ],
                );
              }),
          const SizedBox(
            height: AppSize.s8,
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: ColorManager.grey),
            child: Text(
              AppStrings.resendAgain,
              style: TextStyle(color: ColorManager.primary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
