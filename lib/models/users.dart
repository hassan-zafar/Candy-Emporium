import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String photoUrl;  final String password;

  final String displayName;
  final String bio;
  final String type;
  final bool isAdmin;
  final List address;
  final bool hasMadePurchase;
  final String androidNotificationToken;
  UserModel({
    this.id,
    this.userName,
    this.email,
    this.photoUrl,this.password,
    this.displayName,
    this.bio,
    this.type,
    this.isAdmin,
    this.address,
    this.hasMadePurchase,
    this.androidNotificationToken,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc.data()['id'],
      email: doc.data()['email'],
      userName: doc.data()['userName'],
      photoUrl: doc.data()['photoUrl'],      password: doc.data()['password'],

      displayName: doc.data()['displayName'],
      bio: doc.data()['bio'],
      type: doc.data()['type'],
      isAdmin: doc.data()['isAdmin'],
      address: doc.data()['address'],
      hasMadePurchase: doc.data()['hasMadePurchase'],
      androidNotificationToken: doc.data()["androidNotificationToken"],
    );
  }
}
