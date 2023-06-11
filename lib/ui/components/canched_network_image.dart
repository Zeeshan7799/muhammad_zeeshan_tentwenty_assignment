import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_flutter/core/constants/mv_assets.dart';

import 'loader.dart';

class MvCachedNetWorkImage extends StatelessWidget {
  String image;
  bool doClippingOfImage;

  MvCachedNetWorkImage({Key? key, required this.image, this.doClippingOfImage = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: doClippingOfImage == true ? BorderRadius.circular(10.0) : BorderRadius.circular(0.0),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const Center(child: buildLoader()),
            errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.4), Colors.transparent],
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
