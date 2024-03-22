class BestSellingCoursesModel {
  String? courseName;
  String? studentsNum;

  BestSellingCoursesModel({
    required this.courseName,
    required this.studentsNum,
  });

  BestSellingCoursesModel.fromFireStore(Map<String, dynamic> bestSellingCoursesData) {
    courseName = bestSellingCoursesData['courseName'];
    studentsNum = bestSellingCoursesData['studentsNum'];
  }

  Map<String, dynamic> toFirestore() {
    return {
      "courseName": courseName,
      "studentsNumber": studentsNum,
    };
  }
}
