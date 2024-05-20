import 'dart:convert';

import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/rout_managment/navigation.dart';
import 'package:QuickDo/core/state_managment/create_model/cubits/create_model_cubit.dart';
import 'package:QuickDo/core/state_managment/create_model/widgets/CreateModel.dart';
import 'package:QuickDo/core/storage/storage_handler.dart';
import 'package:QuickDo/core/utils/validator.dart';
import 'package:QuickDo/core/widgets/buttons/main_elevated_button.dart';
import 'package:QuickDo/core/widgets/text_fields/custom_text_field.dart';
import 'package:QuickDo/features/auth/data/models/login_model.dart';
import 'package:QuickDo/features/auth/data/repsitory/auth_repository.dart';
import 'package:QuickDo/features/auth/data/use_cases/login_use_case.dart';
import 'package:QuickDo/features/home/presentation/screens/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late CreateModelCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...[
                    SizedBox(height: MediaQuery.of(context).size.height / 24),
                    Center(child: Text('sign_in'.tr(), style: AppTheme.headline6)),
                    Center(
                        child: Text(
                      'sign_in_to_make_your_day_productive'.tr(),
                      style: AppTheme.headline4,
                      textAlign: TextAlign.center,
                    )),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('name'.tr(), style: AppTheme.headline4),
                    ),
                    CustomTextField(
                      hintText: "enter_your_name".tr(),
                      controller: _userNameController,
                      /*icon: Icons.email,*/
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validator.nameValidate(value!, context),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('password'.tr(), style: AppTheme.headline4),
                    ),
                    CustomTextField(
                      hintText: "enter_your_password".tr(),
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          Validator.passwordValidate(value!, context),
                    ),
                    CreateModel<LoginModel>(
                      withValidation: false,
                      onSuccess: (model) async {
                        await StorageHandler().setToken(model.token ?? "");
                        await StorageHandler.writeUserData(json.encode(model.toJson()))
                            .then((value) {
                          Navigation.pushAndRemoveUntil(context, HomeScreen());
                        });
                      },
                      useCaseCallBack: (_) async {
                        return await LoginUseCase(AuthRepository()).call(
                            params: LogInParams(
                                password: _passwordController.text,
                                username: _userNameController.text));
                      },
                      onCubitCreated: (cubit) => loginCubit = cubit,
                      child: MainElevatedButton(
                          onPressed: () {
                          //  if (!(_formKey.currentState!.validate())) return;
                            loginCubit.createModel(
                                requestData: LogInParams(
                                    password: _passwordController.text,
                                    username: _userNameController.text));
                          },
                          text: 'sign_in'.tr()),
                    ),
                  ].expand((element) => [
                        element,
                        const SizedBox(
                          height: 6,
                        )
                      ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
