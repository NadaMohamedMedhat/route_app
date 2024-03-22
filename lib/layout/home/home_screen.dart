import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:route_app/model/best_selling_courses_model.dart';
import 'package:route_app/model/featured_courses_model.dart';
import 'package:route_app/shared/remote/firebase_auth/auth_provider.dart';
import 'package:route_app/shared/remote/firestore/courses_firestore_helper.dart';
import 'package:route_app/shared/reusable%20components/theme_icon.dart';

import '../../shared/providers/theme_provider.dart';
import '../../style/app_colors.dart';
import '../auth/login/login_screen.dart';
import 'widgets/best_selling_courses_widget.dart';
import 'widgets/featured_courses_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProviders authProviders = Provider.of<AuthProviders>(context);
    ThemeMode themeMode = Provider.of<ThemeProvider>(context).themeMode;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    SvgPicture.asset(
                      themeMode == ThemeMode.light
                          ? 'assets/images/route.svg'
                          : 'assets/images/route_dark.svg',
                      width: 80,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Welcome to Route',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        Text(
                          'Enjoy our courses',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.labelSmallColor,
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                  ]),
                  Row(
                    children: [
                      const ThemeIcon(),
                      IconButton(
                        style:
                            Theme.of(context).iconButtonTheme.style?.copyWith(
                                  foregroundColor: MaterialStateProperty.all(
                                    themeMode == ThemeMode.light
                                        ? AppColors.black
                                        : AppColors.white,
                                  ),
                                ),
                        onPressed: () {
                          authProviders.signOut();
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Featured ",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: themeMode == ThemeMode.light
                              ? AppColors.lightPrimaryColor
                              : AppColors.white,
                        ),
                  ),
                  Text(
                    "Courses",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: themeMode == ThemeMode.light
                              ? AppColors.black
                              : AppColors.labelSmallColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: CoursesFireStoreHelper.listenToFeaturedCourses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Column(
                        children: [
                          const Text("There Is An Error!!"),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Try Again"))
                        ],
                      );
                    }
                    List<FeaturedCoursesModel> featuredCourses =
                        snapshot.data ?? [];
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => FeaturedCoursesWidget(
                        featuredCourses: featuredCourses[index],
                      ),
                      itemCount: featuredCourses.length,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Best Selling ",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: themeMode == ThemeMode.light
                                  ? AppColors.lightPrimaryColor
                                  : AppColors.white,
                            ),
                      ),
                      Text(
                        "Courses",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: themeMode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.labelSmallColor,
                            ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: themeMode == ThemeMode.light
                                ? AppColors.black
                                : AppColors.lightPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: CoursesFireStoreHelper.listenToBestSellingCourses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Column(
                        children: [
                          const Text("There Is An Error!!"),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Try Again"))
                        ],
                      );
                    }
                    List<BestSellingCoursesModel> bestSellingCourses =
                        snapshot.data ?? [];
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) => BestSellingCoursesWidget(
                          bestSellingCourses: bestSellingCourses[index]),
                      itemCount: bestSellingCourses.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
