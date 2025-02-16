import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/utils/constants/app_strings.dart';
import 'package:supos_v3/utils/constants/type.dart';
import 'package:supos_v3/utils/helpers/form_validators.dart.dart';
import 'package:supos_v3/utils/shared_components/component_styles.dart';

import '../../../../utils/constants/app_sizes.dart';
import '../../bloc/auth_bloc.dart';

class SigninScreen extends StatefulWidget {
  final VoidCallback onToggle;
  final VoidCallback onWelcome;

  const SigninScreen(
      {super.key, required this.onToggle, required this.onWelcome});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(AppStrings.login, style: headingTextStyle()),
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
                          context.read<AuthBloc>().add(LoginRequested(
                              emailController.text, passwordController.text));
                        }
                      },
                      child: const Text(AppStrings.login),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: widget.onToggle,
                  child: Text(
                    AppStrings.doNotHaveAnAccount,
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
