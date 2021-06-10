import 'package:candy_emporium/tools/progress.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget cachedNetworkImage(String mediaUrl) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
    child: CachedNetworkImage(
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageUrl: mediaUrl != null ? mediaUrl : "",
      fit: BoxFit.cover,
      placeholder: (context, url) => Padding(
        padding: EdgeInsets.all(20.0),
        child: bouncingGridProgress(),
      ),
    ),
  );
}
