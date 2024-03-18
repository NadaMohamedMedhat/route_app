import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:route_app/shared/remote/firebase_auth/firebase_auth_error_codes.dart';
import 'package:route_app/shared/reusable%20components/custom_text_field.dart';
import 'package:route_app/shared/reusable%20components/dialog_utils.dart';
import 'package:route_app/style/app_colors.dart';

import '../../../shared/constants/constant.dart';
import '../../../style/app_theme.dart';
import '../../home/home_screen.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/images/route.svg',
                      ),
                      Icon(
                        Icons.dark_mode,
                        color: Theme.of(context).iconTheme.color,
                        size: Theme.of(context).iconTheme.size,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Create an account',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    'Connect with your friends today!',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Full Name',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.lightPrimaryColor,
                        ),
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.name,
                    controller: fullNameController,
                    hintText: 'Enter your email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Email',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: AppColors.lightPrimaryColor,
                    ),
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hintText: 'Enter your email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email can\t be empty';
                      }
                      if (!RegExp(Constant.emailRegex).hasMatch(value)) {
                        return ('Email is not valid');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.lightPrimaryColor,
                        ),
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    hintText: 'Enter your password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field can't be empty";
                      }
                      if (value.length < 8) {
                        return "Password should be at least 8 char";
                      }
                      return null;
                    },
                    obscureText: isObscured,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                      icon: isObscured
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      style: Theme.of(context).iconButtonTheme.style,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Confirm Password',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: AppColors.lightPrimaryColor,
                    ),
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: confirmPasswordController,
                    hintText: 'Enter your email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field can't be empty";
                      }
                      if (value.length < 8) {
                        return "Password should be at least 8 char";
                      }
                      return null;
                    },
                    obscureText: isObscured,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                      icon: isObscured
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      style: Theme.of(context).iconButtonTheme.style,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        registerUser();
                      },
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.white,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: AppTheme.lightTheme.textTheme.labelSmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                        child: Text(
                          'Sign In',
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppColors.lightPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    if (formKey.currentState!.validate()) {
      DialogUtils.showLoadingDialog(context);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        DialogUtils.hideDialog(context);

        //User ID is generated by firebase
        print(credential.user!.uid);

        DialogUtils.showMessage(
            context: context,
            message: 'Register Successfully',
            positiveText: 'ok',
            positivePress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                (route) => false,
              );
            });
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideDialog(context);
        if (e.code == FirebaseAuthErrorCodes.weakPassword) {
          DialogUtils.showMessage(
            context: context,
            message: 'Weak Password',
            positiveText: 'ok',
            positivePress: () {
              Navigator.pop(context);
            },
          );
        } else if (e.code == FirebaseAuthErrorCodes.emailAlreadyInUse) {
          DialogUtils.showMessage(
              context: context,
              message: 'Email Already In Use',
              positiveText: 'ok',
              positivePress: () {
                Navigator.pop(context);
              });
        }
      } catch (e) {
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            positiveText: 'ok',
            positivePress: () {
              Navigator.pop(context);
            });
      }
    }
  }
}
