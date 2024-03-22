import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_app/model/best_selling_courses_model.dart';

import '../../../shared/providers/theme_provider.dart';
import '../../../style/app_colors.dart';

class BestSellingCoursesWidget extends StatelessWidget {
  BestSellingCoursesModel bestSellingCourses;
  BestSellingCoursesWidget({super.key, required this.bestSellingCourses});

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Provider.of<ThemeProvider>(context).themeMode;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.labelSmallColor.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Image(
              image: AssetImage("assets/images/bestSelling.png"),
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bestSellingCourses.courseName ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontSize: 16),
                  ),
                  Text(
                    "${bestSellingCourses.studentsNum ?? 0}",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 12,color: AppColors.labelSmallColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
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
                  "Join Now",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: themeMode == ThemeMode.light
                        ? AppColors.white
                        : AppColors.black,
                  ),
                ),),
          ],
        ),
      ),
    );
  }
}
