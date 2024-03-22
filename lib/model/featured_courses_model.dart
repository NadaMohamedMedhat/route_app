class FeaturedCoursesModel {
  String? courseName;
  String? studentsNum;

  FeaturedCoursesModel({
    required this.courseName,
    required this.studentsNum,
  });

  FeaturedCoursesModel.fromFireStore(Map<String, dynamic> featuredCoursesData) {
    courseName = featuredCoursesData['courseName'];
    studentsNum = featuredCoursesData['studentsNum'];
  }

  Map<String, dynamic> toFirestore() {
    return {
      "courseName": courseName,
      "studentsNumber": studentsNum,
    };
  }
}
