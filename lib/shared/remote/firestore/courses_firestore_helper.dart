import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/best_selling_courses_model.dart';
import '../../../model/featured_courses_model.dart';

class CoursesFireStoreHelper {
  static CollectionReference<FeaturedCoursesModel>
      getFeaturedCoursesCollection() {
    CollectionReference<FeaturedCoursesModel> featuredCoursesRef =
        FirebaseFirestore.instance.collection('Featured Courses').withConverter(
            fromFirestore: (snapshot, option) {
      Map<String, dynamic> data = snapshot.data()!;
      return FeaturedCoursesModel.fromFireStore(data);
    }, toFirestore: (featuredCoursesModel, option) {
      return featuredCoursesModel.toFirestore();
    });
    return featuredCoursesRef;
  }

  static Stream<List<FeaturedCoursesModel>> listenToFeaturedCourses() async* {
    Stream<QuerySnapshot<FeaturedCoursesModel>> featuredCoursesQureyStream =
        getFeaturedCoursesCollection().snapshots();
    Stream<List<FeaturedCoursesModel>> featureCourseStream =
        featuredCoursesQureyStream.map(
      (querySnapshot) =>
          querySnapshot.docs.map((document) => document.data()).toList(),
    );
    yield* featureCourseStream;
  }

 static CollectionReference<BestSellingCoursesModel>
      getBestSellingCoursesCollection() {
    CollectionReference<BestSellingCoursesModel> bestSellingCoursesRef =
        FirebaseFirestore.instance
            .collection('Best Selling Courses')
            .withConverter(
      fromFirestore: (snapshot, option) {
        Map<String, dynamic> data = snapshot.data()!;
        return BestSellingCoursesModel.fromFireStore(data);
      },
      toFirestore: (bestSellingCoursesModel, option) {
        return bestSellingCoursesModel.toFirestore();
      },
    );
    return bestSellingCoursesRef;
  }

  static Stream<List<BestSellingCoursesModel>>
      listenToBestSellingCourses() async* {
    Stream<QuerySnapshot<BestSellingCoursesModel>> bestSellingQureyStream =
        getBestSellingCoursesCollection().snapshots();
    var bestSellingStream = bestSellingQureyStream.map((querySnapshot) =>
        querySnapshot.docs.map((document) => document.data()).toList());
    yield* bestSellingStream;
  }
}
