import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mina_farid/app/di.dart';
import 'package:mina_farid/presentation/screens/register/view_model/register_view_model.dart';

import '../../../resources/assets_manger.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ImagePicker imageProfile = ImagePicker();
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _phoneController.addListener(() {
      _viewModel.setMobileNumber(_phoneController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: AppSize.s18,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.emailAddress,
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        onChanged: (item) {},
                        decoration: InputDecoration(
                          labelText: AppStrings.username,
                          hintText: AppStrings.username,
                          errorText: snapshot.data,
                        ),
                      );
                    })),
            const SizedBox(
              height: AppSize.s18,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p8, right: AppPadding.p28),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CountryCodePicker(
                      onChanged: (country) {
                        _viewModel.setCountryCode(country.dialCode ?? "");
                      },
                      initialSelection: '+20',
                      favorite: const ['+39', 'FR', '+966', '+20'],
                      // optional. Shows only country name and flag
                      showCountryOnly: true,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: true,
                      // optional. aligns the flag and the Text left
                      alignLeft: true,
                      showFlag: true,

                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: StreamBuilder<String?>(
                        stream: _viewModel.outputMobileNumber,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              labelText: AppStrings.mobileNumber,
                              hintText: AppStrings.mobileNumber,
                              errorText: snapshot.data,
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: AppSize.s18,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: StreamBuilder<String?>(
                  stream: _viewModel.outputEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                          labelText: AppStrings.emailHint,
                          hintText: AppStrings.emailHint,
                          errorText: snapshot.data),
                    );
                  }),
            ),
            const SizedBox(
              height: AppSize.s18,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: StreamBuilder<String?>(
                  stream: _viewModel.outputPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                          labelText: AppStrings.password,
                          hintText: AppStrings.password,
                          errorText: snapshot.data),
                    );
                  }),
            ),
            const SizedBox(
              height: AppSize.s18,
            ),
            GestureDetector(
              onTap: () {
                _showBottom();
              },
              child: Container(
                margin: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                height: AppSize.s40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    border: Border.all(color: ColorManager.darkGrey)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p8, right: AppPadding.p8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                          child: Text(
                        AppStrings.profilePicture,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      StreamBuilder<File>(
                          stream: _viewModel.outputImage,
                          builder: (context, snapshot) {
                            return Flexible(child: _showImage(snapshot.data));
                          }),
                      Flexible(child: SvgPicture.asset(ImageAssets.photoCamera))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s40,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: SizedBox(
                  width: double.infinity,
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputAllDataValid,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          onPressed: (snapshot.data ==true) ? () {

                          } : null,
                          child: const Text(
                            AppStrings.register,
                          ),
                        );
                      })),
            ),
            const SizedBox(
              height: AppSize.s40,
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.loginRoute);
                  },
                  style:
                      TextButton.styleFrom(foregroundColor: ColorManager.grey),
                  child: Text(
                    AppStrings.alreadyHaveAccount,
                    style: TextStyle(color: ColorManager.primary),
                  )),
            ),
          ],
        ),
      ),
    ));
  }

  _showBottom() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  onTap: () {
                    _selectPhotoGallery();
                    Navigator.of(context).pop();
                  },
                  trailing: const Icon(Icons.arrow_forward_outlined),
                  title: const Text(AppStrings.photoGallery),
                  leading: const Icon(Icons.camera),
                ),
                ListTile(
                  onTap: () {
                    _selectPhotoCamera();
                    Navigator.of(context).pop();
                  },
                  trailing: const Icon(Icons.arrow_forward_outlined),
                  title: const Text(AppStrings.photoCamera),
                  leading: const Icon(Icons.camera_alt_outlined),
                ),
              ],
            ),
          );
        });
  }

  _selectPhotoGallery() async {
    var image = await imageProfile.pickImage(source: ImageSource.gallery);
    _viewModel.setProfileImage(File(image!.path));
  }

  _selectPhotoCamera() async {
    var image = await imageProfile.pickImage(source: ImageSource.camera);
    _viewModel.setProfileImage(File(image?.path ?? ""));
  }

  Widget _showImage(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    }
    return Container();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
