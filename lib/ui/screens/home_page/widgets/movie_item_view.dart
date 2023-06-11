import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_flutter/core/constants/mv_paddings.dart';
import 'package:tmdb_flutter/core/constants/mv_styles.dart';
import 'package:tmdb_flutter/core/network/response_models/configuration_response_model.dart';
import 'package:tmdb_flutter/core/network/response_models/up_coming_movies_response.dart';
import 'package:tmdb_flutter/core/share_providers/local_db_provider/local_db_provider.dart';
import 'package:tmdb_flutter/core/share_providers/movies_provider/movies_provider.dart';
import 'package:tmdb_flutter/ui/components/canched_network_image.dart';

import '../../../components/loader.dart';

class MovieItemView extends ConsumerWidget {

  Function() onTap;
  Results movie;
  MovieItemView({Key? key, required this.movie, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Padding(
      padding: MVPaddings.homePagePadding,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 180.h,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  buildMoviePoster(ref: ref),
                  buildMovieName()

                ],
              ),
            ),
            SizedBox(height: 20.h,)
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  Widget buildMovieName(){
    return Positioned(
      left: 20,
        bottom: 20,
        right: 20,
        child: Text(movie.title ?? '', style: MVStyles.HOMEPAGE_MOVIE_NAME_STYLE, maxLines: 1, overflow: TextOverflow.fade,)
    );
  }

  // ----------------------------------------------------------
  Widget buildMoviePoster({required WidgetRef ref}) {

    String imagePath =  ref.read(movieRepoProvider).configurationResponseModel.images!.baseUrl! + ref.read(movieRepoProvider).configurationResponseModel.images!.posterSizes!.last;
    return MvCachedNetWorkImage(image: imagePath + movie.backdropPath! ?? '');
  }

}
