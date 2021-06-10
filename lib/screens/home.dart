import 'package:bot_toast/bot_toast.dart';
import 'package:candy_emporium/cart.dart';
import 'package:candy_emporium/config/collections.dart';
import 'package:candy_emporium/productScreens/kannapyStore.dart';
import 'package:candy_emporium/screens/notifications.dart';
import 'package:candy_emporium/screens/timeline.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class HomeScreen extends StatefulWidget {
  // static MaterialPageRoute get route => MaterialPageRoute(
  //       builder: (context) => const HomeScreen(),
  //     );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;

  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this._pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    if (pageIndex == 2) {
      BotToast.showText(
        text: 'Swipe to Delete',
      );
    }
    _pageController.jumpToPage(
      pageIndex,

      // duration: Duration(milliseconds: 350),
      // curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          KannapyStore(currentUserInStore: currentUser),
          KannapyCart(
            userId: currentUser?.id,
          ),
          Timeline(
            currentUser: currentUser,
          ),
          KannapyNotifications(),
        ],
      ),
      bottomNavigationBar: GlassContainer(
        opacity: 0.2,
        blur: 8,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0x00ffffff),
          currentIndex: _pageIndex,
          onTap: onTap,
          elevation: 0,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined), label: "Store"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_collection_rounded), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.timelapse_rounded), label: "Timeline"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Notifications")
          ],
        ),
      ),
    );
  }
}
