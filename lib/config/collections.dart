import 'package:candy_emporium/models/addressModel.dart';
import 'package:candy_emporium/models/users.dart';
import 'package:candy_emporium/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final Reference storageRef = FirebaseStorage.instance.ref();
final userRef = FirebaseFirestore.instance.collection('users');
final cardRef = FirebaseFirestore.instance.collection('card');
final adminOrderHistoryRef =
    FirebaseFirestore.instance.collection('adminOrderHistory');
final postsRef = FirebaseFirestore.instance.collection('posts');
final addressRef = FirebaseFirestore.instance.collection('address');
//Store timeline refs
final productRef = FirebaseFirestore.instance.collection('products');
final auctionTimelineRef =
    FirebaseFirestore.instance.collection('auctionTimeline');

final storeTimelineRef = FirebaseFirestore.instance.collection('storeTimeline');
final seedVaultTimelineRef =
    FirebaseFirestore.instance.collection('seedVaultTimeline');
final biddersRef = FirebaseFirestore.instance.collection('bidders');
final vendorsRef = FirebaseFirestore.instance.collection('vendors');
final commentsRef = FirebaseFirestore.instance.collection('comments');
final favouritesRef = FirebaseFirestore.instance.collection('favourites');
final mercReqRef = FirebaseFirestore.instance.collection('mercRequests');
final mercSelectedRef = FirebaseFirestore.instance.collection('mercSelected');
final bidWinnersRef = FirebaseFirestore.instance.collection('bidWinners');
final cartRef = FirebaseFirestore.instance.collection('cart');

final activityFeedRef = FirebaseFirestore.instance.collection('activityFeed');
final timelineRef = FirebaseFirestore.instance.collection('timeline');
final auctionBidsRef = FirebaseFirestore.instance.collection('auctionBids');
final reviewRef = FirebaseFirestore.instance.collection('review');
final DateTime timestamp = DateTime.now();
final codesRef = FirebaseFirestore.instance.collection('codes');
final chatRoomRef = FirebaseFirestore.instance.collection('chatRoom');
final chatListRef = FirebaseFirestore.instance.collection('chatLists');

UserModel currentUser;
bool isAuctionMercItem = false;
bool isAuctionVaultItem = false;
bool isStoreItem = false;
bool isVaultItem = false;
bool isAdmin = false;
bool isMerc = false;
UserModel kannapyAdmin;
AddressModel deliveryAddress;
bool isAuth = false;
bool isValidCode = false;
List allCodes = [];
TextEditingController codeController = TextEditingController();
String userName, code;
final GoogleSignIn googleSignIn = GoogleSignIn();
logout(BuildContext context) async {
  await googleSignIn.signOut();
  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
}
