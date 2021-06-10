import 'package:candy_emporium/adminScreens/adminHome.dart';
import 'package:candy_emporium/config/collections.dart';
import 'package:candy_emporium/models/users.dart';
import 'package:candy_emporium/profileScreens/dashBoard.dart';
import 'package:candy_emporium/tools/seedVaultItems.dart';
import 'package:candy_emporium/tools/storeItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

int cartCount = 0;
bool isCart = false;
bool isFavourite = false;

class KannapyStore extends StatefulWidget {
  final UserModel currentUserInStore;
  KannapyStore({this.currentUserInStore});
  @override
  _KannapyStoreState createState() => _KannapyStoreState();
}

class _KannapyStoreState extends State<KannapyStore> {
  final String currentUserID = currentUser?.id;

  TabController tabBarController;

  bool _disposed = false;

  int notificationCount = 0;

  checkAdmin() {
    if (currentUser != null && currentUser.type == "admin") {
      if (!_disposed) {
        setState(() {
          kannapyAdmin = currentUser;
          isAdmin = true;
        });
      }
    }
  }

  getNotifications() async {
    QuerySnapshot snapshot =
        await activityFeedRef.doc(currentUser.id).collection('feedItems').get();
    setState(() {
      if (snapshot.docs != null) {
        notificationCount = snapshot.docs.length;
      } else {
        notificationCount = 0;
      }
    });
  }

  getCartCount() async {
    QuerySnapshot snapShot =
        await cartRef.doc(currentUser.id).collection("cartItems").get();
    setState(() {
      if (snapShot.docs != null) {
        cartCount = snapShot.docs.length;
      } else {
        cartCount = 0;
      }
    });
  }

  @override
  void initState() {
    checkAdmin();
    getCartCount();
    getNotifications();
    super.initState();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onLongPress: isAdmin || isMerc
              ? () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AdminHome(currentUser: currentUser, isMerc: isMerc)));
                }
              : () {},
          child: Text(
            'KANNAPY STORE',
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.person_outline,
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Profile(
                        profileId: currentUserID,
                      )))),
        ],
      ),
      body: Merchandise(),

      // floatingActionButton: Stack(
      //   children: <Widget>[
      //     FloatingActionButton(
      //       backgroundColor: Theme.of(context).primaryColor,
      //       onPressed: () {
      //         setState(() {
      //           isCart = true;
      //           isFavourite = false;
      //         });
      //         Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => KannapyCart(
      //                   userId: currentUser?.id,
      //                   //productItems: productItems,
      //                 )));
      //       },
      //       child: Icon(
      //         Icons.shopping_cart,
      //         color: Theme.of(context).accentColor,
      //       ),
      //     ),
      //     CircleAvatar(
      //       radius: 10.0,
      //       child: Text(
      //         "$cartCount",
      //         style: TextStyle(color: Colors.grey.shade400),
      //       ),
      //       backgroundColor: Colors.red,
      //     ),
      //   ],
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
