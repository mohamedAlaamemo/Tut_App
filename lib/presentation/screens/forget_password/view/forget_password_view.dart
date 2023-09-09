import 'package:flutter/material.dart';
import 'package:mina_farid/presentation/resources/assets_manger.dart';
import 'package:mina_farid/presentation/resources/strings_manager.dart';
import 'package:mina_farid/presentation/resources/values_manager.dart';

import '../../../resources/color_manager.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding:  EdgeInsets.only(top: AppPadding.p100),
                child: const Image(image: AssetImage(ImageAssets.splashLogo)),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p28,right: AppPadding.p28),
                child: TextFormField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: AppStrings.emailHint,
                    hintText: AppStrings.emailHint,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: AppPadding.p28,right: AppPadding.p28),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(AppStrings.resetPassword),
                ),
              ),
              const SizedBox(
                height: AppSize.s8,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: ColorManager.grey),
                child:  Text(AppStrings.resendAgain,
                  style: TextStyle(
                    color: ColorManager.primary
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
