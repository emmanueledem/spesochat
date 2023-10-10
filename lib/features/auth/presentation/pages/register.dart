import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spesochat/app/app.dart';
import 'package:spesochat/app/view/widgets/busy_button.dart';
import 'package:spesochat/app/view/widgets/input_field.dart';
import 'package:spesochat/core/constants/app_assets.dart';
import 'package:spesochat/core/constants/colors.dart';
import 'package:spesochat/core/core.dart';
import 'package:spesochat/features/auth/presentation/provider/auth_provider.dart';
import 'package:spesochat/features/features.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late StreamController<String> fullNameStreamController;
  late StreamController<String> emailStreamController;
  late StreamController<String> passwordStreamController;
  final ValueNotifier<bool> _canSubmit = ValueNotifier(false);
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    validateStreams();
  }

  void validateStreams() {
    fullNameStreamController = StreamController<String>.broadcast();
    emailStreamController = StreamController<String>.broadcast();
    passwordStreamController = StreamController<String>.broadcast();

    _fullNameController.addListener(() {
      fullNameStreamController.sink.add(_fullNameController.text.trim());
      validateInputs();
    });

    _emailController.addListener(() {
      emailStreamController.sink.add(_emailController.text.trim());
      validateInputs();
    });

    _passwordController.addListener(() {
      passwordStreamController.sink.add(_passwordController.text.trim());
      validateInputs();
    });
  }

  void validateInputs() {
    var canSubmit = true;

    final fullNameError = CustomFormValidation.errorMessage(
      _fullNameController.text.trim(),
      'Full Name is required',
    );

    final emailError = CustomFormValidation.errorEmailMessage(
      _emailController.text.trim(),
      'Email is required',
    );

    final passwordError = CustomFormValidation.errorMessagePassword(
      _passwordController.text.trim(),
      'Password is required',
    );

    if (fullNameError != '' || emailError != '' || passwordError != '') {
      canSubmit = false;
    }
    _canSubmit.value = canSubmit;
  }

  @override
  void dispose() {
    super.dispose();
    fullNameStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder:
            (BuildContext context, AuthProvider authProvider, Widget? child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(screenHeight(context) * 0.013),
                          Row(
                            children: [
                              HeaderText(
                                'Registration',
                                color: AppColors.deepBlue,
                              ),
                              HeaderText(
                                '.',
                                color: AppColors.secondaryColor,
                              ),
                            ],
                          ),
                          const Gap(10),
                          TextRegular(
                            'Please enter your details.',
                          ),
                          Gap(screenHeight(context) * 0.04),
                          TextBold(
                            'Full Name',
                            color: AppColors.ash,
                          ),
                          const Gap(10),
                          StreamBuilder<String>(
                            stream: fullNameStreamController.stream,
                            builder: (context, snapshot) {
                              return InputField(
                                controller: _fullNameController,
                                placeholder: 'Enter your full name',
                                prefix: Row(
                                  children: [
                                    SvgPicture.asset(AppAssets.profile),
                                    const Gap(10),
                                  ],
                                ),
                                validationMessage:
                                    CustomFormValidation.errorMessage(
                                  snapshot.data,
                                  'Full Name is required*',
                                ),
                                validationColor: CustomFormValidation.getColor(
                                  snapshot.data,
                                  _fullNameFocus,
                                  CustomFormValidation.errorMessage(
                                    snapshot.data,
                                    'Full Name is required*',
                                  ),
                                ),
                              );
                            },
                          ),
                          Gap(screenHeight(context) * 0.01),
                          TextBold(
                            'Email Address',
                            color: AppColors.ash,
                          ),
                          const Gap(10),
                          StreamBuilder<String>(
                            stream: emailStreamController.stream,
                            builder: (context, snapshot) {
                              return InputField(
                                controller: _emailController,
                                placeholder: 'Enter your email address',
                                prefix: Row(
                                  children: [
                                    SvgPicture.asset(AppAssets.email),
                                    const Gap(10),
                                  ],
                                ),
                                validationMessage:
                                    CustomFormValidation.errorEmailMessage(
                                  snapshot.data,
                                  'Email is required*',
                                ),
                                validationColor: CustomFormValidation.getColor(
                                  snapshot.data,
                                  _emailFocus,
                                  CustomFormValidation.errorEmailMessage(
                                    snapshot.data,
                                    'Email is required*',
                                  ),
                                ),
                              );
                            },
                          ),
                          Gap(screenHeight(context) * 0.01),
                          TextBold(
                            'Password',
                            color: AppColors.ash,
                          ),
                          const Gap(10),
                          StreamBuilder<String>(
                            stream: passwordStreamController.stream,
                            builder: (context, snapshot) {
                              return InputField(
                                controller: _passwordController,
                                placeholder: 'Enter your password',
                                password: true,
                                prefix: Row(
                                  children: [
                                    SvgPicture.asset(AppAssets.lock),
                                    const Gap(10),
                                  ],
                                ),
                                validationMessage:
                                    CustomFormValidation.errorMessagePassword(
                                  snapshot.data,
                                  'Password is required*',
                                ),
                                validationColor: CustomFormValidation.getColor(
                                  snapshot.data,
                                  _passwordFocus,
                                  CustomFormValidation.errorMessagePassword(
                                    snapshot.data,
                                    'Password is required*',
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                              );
                            },
                          ),
                          Gap(screenHeight(context) * 0.04),
                          ValueListenableBuilder(
                            valueListenable: _canSubmit,
                            builder: (
                              context,
                              canSubmit,
                              child,
                            ) {
                              return BusyButton(
                                title: 'Continue',
                                onpress: () async {
                                  setState(() {
                                    _canSubmit.value = false;
                                    isloading = true;
                                  });
                                  await authProvider
                                      .register(
                                    context,
                                    UsersModel(
                                      username: _fullNameController.text.trim(),
                                      emailAddress:
                                          _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  )
                                      .then((value) {
                                    value
                                        ? FlushBarNotification.showSuccess(
                                            context: context,
                                            message:
                                                'Account Created Successfully',
                                          ).then((value) {
                                            Navigator.pushNamed(
                                              context,
                                              RouteName.loginView,
                                            );
                                            _fullNameController.clear();
                                            _emailController.clear();
                                            _passwordController.clear();
                                            setState(() {
                                              isloading = false;
                                            });
                                          })
                                        : FlushBarNotification.showError(
                                            context: context,
                                            message:
                                                'something went wrong try again',
                                          );
                                  });
                                },
                                loading: isloading,
                                deactivate: canSubmit == false || isloading,
                              );
                            },
                          ),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextRegular(
                                'Already have an account? ',
                                fontWeight: FontWeight.w500,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  RouteName.loginView,
                                ),
                                child: TextRegular(
                                  'Login',
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const Gap(30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
