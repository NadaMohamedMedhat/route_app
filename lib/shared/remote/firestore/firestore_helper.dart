import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/user_model.dart';

//todo: try to write this class again from scratch
class FireStoreHelper {
  //create users collection if there is no collection with that name
  CollectionReference<UserModel> getUserCollection() {
    CollectionReference<UserModel> userRef =
        FirebaseFirestore.instance.collection('Users').withConverter(
      fromFirestore: (snapshot, option) {
        Map<String, dynamic> data = snapshot.data()!;
        return UserModel.fromFirestore(data);
      },
      toFirestore: (UserModel, option) {
        return UserModel.toFirestore();
      },
    );
    return userRef;
  }

  addUser(String email, String fullName, String userID) {
    DocumentReference<UserModel> userDoc = getUserCollection().doc(userID);
    userDoc.set(
      UserModel(
        id: userID,
        email: email,
        fullName: fullName,
      ),
    );
  }

  Future<UserModel> getUser(String userID) async {
    DocumentReference<UserModel> userDoc = getUserCollection().doc(userID);
    DocumentSnapshot<UserModel> snapshot = await userDoc.get();
    return snapshot.data()!;
  }
}
