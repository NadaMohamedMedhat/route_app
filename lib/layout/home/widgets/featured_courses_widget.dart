import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/featured_courses_model.dart';
import '../../../shared/providers/theme_provider.dart';
import '../../../style/app_colors.dart';

class FeaturedCoursesWidget extends StatelessWidget {
  FeaturedCoursesModel featuredCourses;
  FeaturedCoursesWidget({super.key, required this.featuredCourses});

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Provider.of<ThemeProvider>(context).themeMode;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.labelSmallColor.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Image(
                  image: AssetImage("assets/images/featured.png"),
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 10,
            ),
            Text(
              featuredCourses.courseName ?? "",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontSize: 20),
            ),
            Text(
              "${featuredCourses.studentsNum ?? 0}",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 14,color: AppColors.labelSmallColor),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: MaterialStateProperty.all(
                      themeMode == ThemeMode.light
                          ? AppColors.lightPrimaryColor.withOpacity(0.7)
                          : AppColors.labelSmallColor,
                    ),
                    fixedSize: MaterialStateProperty.all(Size.infinite)),
                onPressed: () {},
                child: Text(
                  "Enroll Now",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: themeMode == ThemeMode.light
                            ? AppColors.white
                            : AppColors.black,
                      ),
                ))
          ],
        ),
      ),
    );
  }
}
