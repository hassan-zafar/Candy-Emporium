import 'package:candy_emporium/config/collections.dart';
import 'package:candy_emporium/models/users.dart';
import 'package:candy_emporium/tools/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:candy_emporium/database/local_database.dart';

class DatabaseMethods {
  // Future<Stream<QuerySnapshot>> getproductData() async {
  //   return FirebaseFirestore.instance.collection(productCollection).snapshots();
  // }

  Future addUserInfoToFirebase(
      {@required userModel, @required String userId, @required email}) async {
    print("addUserInfoToFirebase");
    final Map<String, dynamic> userInfoMap = userModel.toMap();
    return userRef.doc(userId).set(userInfoMap).then((value) {
      UserLocalData().setUserUID(userModel.userId);
      UserLocalData().setUserEmail(userModel.email);
      UserLocalData().setUserName(userModel.userName);
      UserLocalData().setIsAdmin(userModel.isAdmin);
    }).catchError(
      (Object obj) {
        errorToast(message: obj.toString());
      },
    );
  }

  Future fetchUserInfoFromFirebase({@required String uid}) async {
    final DocumentSnapshot _user = await userRef.doc(uid).get();
    UserModel currentUser = UserModel.fromDocument(_user);
    UserLocalData().setUserUID(currentUser.id);
    UserLocalData().setUserEmail(currentUser.email);
    UserLocalData().setIsAdmin(currentUser.isAdmin);
    isAdmin = currentUser.isAdmin;
    print(currentUser.email);
  }
}
