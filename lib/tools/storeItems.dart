import 'package:candy_emporium/config/collections.dart';
import 'package:candy_emporium/tools/productItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'uiFunctions.dart';

class Merchandise extends StatefulWidget {
  @override
  _MerchandiseState createState() => _MerchandiseState();
}

class _MerchandiseState extends State<Merchandise>
    with AutomaticKeepAliveClientMixin<Merchandise> {
  int productCount = 0;
  bool isLoading = false;
  List<ProductItems> productItems = [];
  List<ProductItems> productItemsStoreLive = [];
  List<ProductItems> productItemsStoreUpcoming = [];
  RefreshController _refreshController = RefreshController();
 

  @override
  void initState() {
    //getProductItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
          body: SmartRefresher(
            child:
                // buildStoreItemsLiveUpcoming(
                //     isLive: true,
                //     context: context,
                //     isLoading: isLoading,
                //     varProductItems: productItemsStoreLive),
                buildProductItemsStream(
                    varProductItemsLive: productItemsStoreLive,
                    varProductItemsUpcoming: productItemsStoreUpcoming,
                    varRef: storeTimelineRef,
                    context: context,
                    isLoading: isLoading,
                    isLive: true),
            onRefresh: () {
              productItemsStoreUpcoming.clear();
              productItemsStoreLive.clear();
              getProductItems();
              _refreshController.refreshCompleted();
            },
            controller: _refreshController,
            header: WaterDropMaterialHeader(
              distance: 40.0,
            ),
          ),
        );
        }

  getProductItems() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot =
        await storeTimelineRef.orderBy('timestamp', descending: true).get();
    productCount = snapshot.docs.length;
    snapshot.docs.forEach((doc) {
      if (!doc.data().containsKey("liveSaleDate") ||
          doc.data()["liveSaleDate"].toDate().isBefore(DateTime.now())) {
        productItemsStoreLive.add(ProductItems.fromDocument(doc));
      }
    });
    snapshot.docs.forEach((doc) {
      if (doc.data()["liveSaleDate"] != null &&
          doc.data()["liveSaleDate"].toDate().isAfter(DateTime.now())) {
        productItemsStoreUpcoming.add(ProductItems.fromDocument(doc));
      }
    });
    print(productItemsStoreUpcoming);
    setState(() {
      isLoading = false;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
