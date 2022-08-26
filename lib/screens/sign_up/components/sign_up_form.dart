import 'package:flutter/material.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String confirmPassword;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordConfirmFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
              text: "Continue",
              press: () {
                if (_formKey.currentState!.validate()) {
                  // Go to complete profile page
                }
              }
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordConfirmFormField() {
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => confirmPassword = newValue!,
        onChanged: (value) {
          if (password == confirmPassword) {
            removeError(error: kMatchPassError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return "";
          } else if ((password != confirmPassword)) {
            addError(error: kMatchPassError);
            return "";
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            labelText: "Confirm Password",
            hintText: "Re-enter your password",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Lock.svg",
            )
        )
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => password = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kPassNullError)) {
            removeError(error: kPassNullError);
          } else if (value.length >= 8 && errors.contains(kShortPassError)) {
            removeError(error: kShortPassError);
          }
          password = value;
          return;
        },
        validator: (value) {
          if (value!.isEmpty && !errors.contains(kPassNullError)) {
            addError(error: kPassNullError);
            return "";
          } else if (value.length < 8 &&
              !errors.contains(kShortPassError) &&
              !errors.contains(kPassNullError)) {
            addError(error: kShortPassError);
            return "";
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Lock.svg",
            )
        )
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kEmailNullError)) {
            setState(() {
              removeError(error: kEmailNullError);
            });
          } else if (emailValidatorRegExp.hasMatch(value) &&
              errors.contains(kInvalidEmailError)) {
            setState(() {
              removeError(error: kInvalidEmailError);
            });
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty && !errors.contains(kEmailNullError)) {
            setState(() {
              addError(error: kEmailNullError);
            });
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value) &&
              !errors.contains(kInvalidEmailError) &&
              !errors.contains(kEmailNullError)) {
            setState(() {
              addError(error: kInvalidEmailError);
            });
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Mail.svg",
            )
        )
    );
  }
}
