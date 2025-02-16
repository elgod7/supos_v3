import 'package:flutter/material.dart';
import 'package:supos_v3/modules/auth/bloc/auth_bloc.dart';
import 'package:supos_v3/utils/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/utils/constants/type.dart';
import 'package:supos_v3/utils/helpers/form_validators.dart.dart';

import '../../../../utils/constants/app_sizes.dart';
import '../../../../utils/shared_components/component_styles.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback onToggle;
  final VoidCallback onWelcome;

  const SignupScreen(
      {super.key, required this.onToggle, required this.onWelcome});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSizes.defaultContainerWidth,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.register,
                  style: headingTextStyle(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: textFieldDecoration(label: AppStrings.name),
                  controller: fullNameController,
                  validator: FormValidators.validateName,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: textFieldDecoration(label: AppStrings.email),
                  controller: emailController,
                  validator: FormValidators.validateEmail,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: textFieldDecoration(label: AppStrings.password),
                  obscureText: true,
                  controller: passwordController,
                  validator: FormValidators.validatePassword,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration:
                      textFieldDecoration(label: AppStrings.confirmPassword),
                  obscureText: true,
                  controller: confirmPasswordController,
                  validator: (value) => FormValidators.validateConfirmPassword(
                      value, passwordController.text),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: secondaryButtonStyle(
                          context: context, size: SizeOption.medium),
                      onPressed: widget.onWelcome,
                      child: const Text(AppStrings.cancel),
                    ),
                    ElevatedButton(
                      style: primaryButtonStyle(
                          context: context, size: SizeOption.medium),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Form is valid, submit data
                          context.read<AuthBloc>().add(
                                SignupRequested(
                                    fullNameController.text,
                                    emailController.text,
                                    passwordController.text),
                              );
                        }
                      },
                      child: const Text(AppStrings.register),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: widget.onToggle,
                  child: Text(
                    AppStrings.iHaveAnAccount,
                    style: normalTextButtonStyle(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
