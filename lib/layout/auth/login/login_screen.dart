import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:route_app/layout/auth/register/register_screen.dart';
import 'package:route_app/layout/home/home_screen.dart';
import 'package:route_app/model/user_model.dart';
import 'package:route_app/shared/remote/firebase_auth/auth_provider.dart';
import 'package:route_app/shared/remote/firebase_auth/firebase_auth_error_codes.dart';
import 'package:route_app/shared/remote/firestore/firestore_helper.dart';
import 'package:route_app/shared/reusable%20components/custom_text_field.dart';
import 'package:route_app/shared/reusable%20components/dialog_utils.dart';
import 'package:route_app/style/app_colors.dart';

import '../../../shared/constants/constant.dart';
import '../../../shared/providers/theme_provider.dart';
import '../../../shared/reusable components/theme_icon.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscured = true;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Provider.of<ThemeProvider>(context).themeMode;
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
                        themeMode == ThemeMode.light
                            ? 'assets/images/route.svg'
                            : 'assets/images/route_dark.svg',
                      ),
                      const ThemeIcon(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Hi, Welcome Back!',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    'Hello again, you’ve been missed!',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.labelSmallColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: themeMode == ThemeMode.light
                              ? AppColors.lightPrimaryColor
                              : AppColors.white,
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
                  Text('Password',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: themeMode == ThemeMode.light
                            ? AppColors.lightPrimaryColor
                            : AppColors.white,
                      ),),
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
                      style: Theme.of(context).iconButtonTheme.style?.copyWith(
                        iconColor: MaterialStateProperty.all(
                          themeMode == ThemeMode.light
                              ? AppColors.black
                              : AppColors.lightPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: themeMode == ThemeMode.light
                              ? AppColors.white
                              : AppColors.black,
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
                        'Don\'t have an account?',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: Text(
                          'Sign Up',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
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

  Future<void> login() async {
    AuthProviders authProviders = Provider.of<AuthProviders>(
      context,
      listen: false,
    );

    if (formKey.currentState!.validate()) {
      DialogUtils.showLoadingDialog(context);
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        DialogUtils.hideDialog(context);

        //user id is stored in credential.user.uid
        print(credential.user?.uid);
        UserModel? userModel =
            await FireStoreHelper.getUser(credential.user!.uid);
        authProviders.setUsers(credential.user, userModel);

        DialogUtils.showMessage(
            context: context,
            message: 'Login Successfully',
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
        if (e.code == FirebaseAuthErrorCodes.userNotFound) {
          DialogUtils.showMessage(
              context: context,
              message: 'User Not Found',
              positiveText: 'ok',
              positivePress: () {
                Navigator.pop(context);
              });
        } else if (e.code == FirebaseAuthErrorCodes.wrongPassword) {
          DialogUtils.showMessage(
              context: context,
              message: 'Wrong Password',
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
