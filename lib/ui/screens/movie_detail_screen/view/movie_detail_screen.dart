import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_flutter/core/constants/mv_assets.dart';
import 'package:tmdb_flutter/core/constants/mv_colors.dart';
import 'package:tmdb_flutter/core/constants/mv_paddings.dart';
import 'package:tmdb_flutter/core/constants/mv_styles.dart';
import 'package:tmdb_flutter/core/network/response_models/individual_movie_detail_response.dart';
import 'package:tmdb_flutter/core/network/response_models/up_coming_movies_response.dart';
import 'package:tmdb_flutter/core/share_providers/movies_provider/movies_provider.dart';
import 'package:tmdb_flutter/ui/components/canched_network_image.dart';
import 'package:tmdb_flutter/ui/components/loader.dart';
import 'package:tmdb_flutter/ui/screens/movie_detail_screen/provider/movie_detail_provider.dart';

class MovieDetailScreen extends ConsumerWidget {

  Results movie;

  MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  // ----------------------------------------------------------
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetail = ref.watch(movieDetailProvider).individualMovieDetailResponse;
    final isLoading = ref.watch(movieDetailProvider).isLoading;

    return Scaffold(
      body: isLoading
          ? const Center(
        child: buildLoader(),
      )
          : buildMovieBody(movieDetail: movieDetail, ref: ref),
    );
  }

  // ----------------------------------------------------------
  Widget buildMovieBody({required IndividualMovieDetailResponse movieDetail, required WidgetRef ref}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBackPostBody(movieDetail: movieDetail, ref: ref),
          SizedBox(height: 27.h,),
          buildGenres(movieDetail: movieDetail, ref: ref),
          SizedBox(height: 15.h,),
          buildOverView(movieDetail: movieDetail, ref: ref),
          SizedBox(height: 32.h,)

        ],
      ),
    );
  }

  // ----------------------------------------------------------
  Widget buildOverView({required IndividualMovieDetailResponse movieDetail, required WidgetRef ref}){
    return Padding(
      padding: MVPaddings.movieDetailPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: MVStyles.MOVIE_DETAIL_SUB_HEADING_STYLE,),
          SizedBox(height: 14.h,),
          Text(movieDetail.overview! + movieDetail.overview! + movieDetail.overview!, style: MVStyles.MOVIE_DETAIL_OVERVIEW_STYLE,),

      ]),
    );
  }

  // ----------------------------------------------------------
  Widget buildGenres({required IndividualMovieDetailResponse movieDetail, required WidgetRef ref}){
    return Padding(
      padding: MVPaddings.movieDetailPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Genres', style: MVStyles.MOVIE_DETAIL_SUB_HEADING_STYLE,),
          SizedBox(height: 14.h,),
          Wrap(
            runSpacing: 8,
            spacing: 10,
            direction: Axis.horizontal,
            children: movieDetail.genres!.map((item) => ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
               decoration: BoxDecoration(
                 color: Colors.black,
                 borderRadius: BorderRadius.circular(24),
               ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item.name!, style: MVStyles.MOVIE_DETAIL_GENRES_STYLE,),
                ),
              ),
            )).toList().cast<Widget>(),
          ),
          SizedBox(height: 22.h,),
          const Divider(color: MVColors.DIVIDER_COLOR, thickness: .1,)
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  Widget buildBackPostBody({required IndividualMovieDetailResponse movieDetail, required WidgetRef ref}) {
    return Column(

      children: [
        SizedBox(
          height: 466.h,
          child: Stack(
            children: [
              buildBackPosterImage(movieDetail: movieDetail, ref: ref),
              buildTicketsAndTrailerInfoColumn(movieDetail: movieDetail, ref: ref)

            ]

          ),
        )
      ],
    );
  }

  // ----------------------------------------------------------
  Widget buildTicketsAndTrailerInfoColumn({required WidgetRef ref, required IndividualMovieDetailResponse movieDetail}){
    return Positioned(
      bottom: 34.h,
      left: 0,
      right: 0,
      child: Column(
        children: [
          buildInTheaters(ref: ref, movieDetail: movieDetail),
          SizedBox(height: 15.h,),
          buildGetTickets(),
          SizedBox(height: 10.h,),
          buildWatchTrailer()
        ]

      ),
    );
  }

  // ----------------------------------------------------------
  Widget buildGetTickets(){
    return Container(
      height: 50.h,
      width: 243.w,
      decoration: BoxDecoration(
        color: MVColors.LIGHT_BLUE,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text('Get Tickets', style: MVStyles.MOVIE_DETAIL_TICKETS_TRAILER_STYLE,),
      ),
    );
  }

  // ----------------------------------------------------------
  Widget buildWatchTrailer(){
    return Container(
      height: 50.h,
      width: 243.w,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: MVColors.LIGHT_BLUE,
          width: 1.sp
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(MVAssets.ICON_PLAY, width: 8.w, height: 12.h,),
            SizedBox(width: 8.w,),
            Text('Watch Trailer', style: MVStyles.MOVIE_DETAIL_TICKETS_TRAILER_STYLE,),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  Widget buildInTheaters({required WidgetRef ref, required IndividualMovieDetailResponse movieDetail}){
      return Text('In Theaters ${movieDetail.returnFormattedDate()}', style: MVStyles.MOVIE_DETAIL_IN_THEATERS_STYLE,);
  }

  // ----------------------------------------------------------
  Widget buildBackPosterImage({required WidgetRef ref, required IndividualMovieDetailResponse movieDetail}) {
    String imagePath = ref
        .read(movieRepoProvider)
        .configurationResponseModel
        .images!
        .baseUrl! +  ref
        .read(movieRepoProvider)
        .configurationResponseModel
        .images!
        .stillSizes!.last + movieDetail.backdropPath!;

      debugPrint(imagePath);

    return MvCachedNetWorkImage(image: imagePath, doClippingOfImage: false);
  }

}

