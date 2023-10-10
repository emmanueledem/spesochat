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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
    emailStreamController = StreamController<String>.broadcast();
    passwordStreamController = StreamController<String>.broadcast();

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

    final emailError = CustomFormValidation.errorEmailMessage(
      _emailController.text.trim(),
      'Email is required',
    );

    final passwordError = CustomFormValidation.errorMessagePassword(
      _passwordController.text.trim(),
      'Password is required',
    );

    if (emailError != '' || passwordError != '') {
      canSubmit = false;
    }
    _canSubmit.value = canSubmit;
  }

  @override
  void dispose() {
    super.dispose();
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
                                'Login',
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
                                      .login(
                                    context,
                                    UsersModel(
                                      emailAddress:
                                          _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  )
                                      .then((value) {
                                    value
                                        ? FlushBarNotification.showSuccess(
                                            context: context,
                                            message: 'Login Successfull',
                                          ).then((value) {
                                            Navigator.pushNamed(
                                              context,
                                              RouteName.home,
                                              arguments: HomeViewParams(
                                                username: authProvider
                                                    .availableData[0].username
                                                    .toString(),
                                              ),
                                            );
                                            _emailController.clear();
                                            _passwordController.clear();
                                            setState(() {
                                              isloading = false;
                                            });
                                          })
                                        : FlushBarNotification.showError(
                                            context: context,
                                            message: 'Incorrect user details',
                                          ).then((value) {
                                            setState(() {
                                              isloading = false;
                                            });
                                          });
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
                                "Don't have an account? ",
                                fontWeight: FontWeight.w500,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  RouteName.registerView,
                                ),
                                child: TextRegular(
                                  'Register',
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
