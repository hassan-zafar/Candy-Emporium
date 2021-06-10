import 'package:candy_emporium/config/collections.dart';
import 'package:candy_emporium/tools/productItems.dart';
import 'package:candy_emporium/tools/uiFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SeedVaultItems extends StatefulWidget {
  @override
  _SeedVaultItemsState createState() => _SeedVaultItemsState();
}

class _SeedVaultItemsState extends State<SeedVaultItems>
    with AutomaticKeepAliveClientMixin<SeedVaultItems> {
  bool _disposed = false;
  bool isLoading = false;
  int productVaultCount = 0;
  List<ProductItems> productItemsVaultLive = [];
  List<ProductItems> productItemsVaultUpcoming = [];
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    //getVaultItems();
    super.initState();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  getVaultItems() async {
    if (!_disposed) {
      setState(() {
        isLoading = true;
      });
    }
    QuerySnapshot snapshot =
        await seedVaultTimelineRef.orderBy('timestamp', descending: true).get();
    productVaultCount = snapshot.docs.length;
    snapshot.docs.forEach((doc) {
      if (!doc.data().containsKey("liveSaleDate") ||
          doc.data()["liveSaleDate"].toDate().isBefore(DateTime.now())) {
        productItemsVaultLive.add(ProductItems.fromDocument(doc));
      }
    });
    snapshot.docs.forEach((doc) {
      if (doc.data()["liveSaleDate"] != null &&
          doc.data()["liveSaleDate"].toDate().isAfter(DateTime.now())) {
        productItemsVaultUpcoming.add(ProductItems.fromDocument(doc));
      }
    });
    print(productItemsVaultUpcoming);
    if (!_disposed) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildProductItemsStream(
          varRef: seedVaultTimelineRef,
          context: context,
          varProductItemsUpcoming: productItemsVaultUpcoming,
          varProductItemsLive: productItemsVaultLive,
          isLoading: isLoading,
          isLive: true),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
