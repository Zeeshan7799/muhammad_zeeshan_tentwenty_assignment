import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_flutter/core/constants/mv_assets.dart';
import 'package:tmdb_flutter/core/constants/mv_colors.dart';
import 'package:tmdb_flutter/core/constants/mv_paddings.dart';
import 'package:tmdb_flutter/core/constants/mv_styles.dart';
import 'package:tmdb_flutter/core/network/response_models/up_coming_movies_response.dart';
import 'package:tmdb_flutter/routes/routes.dart';
import 'package:tmdb_flutter/ui/components/loader.dart';
import 'package:tmdb_flutter/ui/screens/home_page/provider/home_provider.dart';
import 'package:tmdb_flutter/ui/screens/home_page/widgets/movie_item_view.dart';
import 'package:tmdb_flutter/ui/screens/movie_detail_screen/provider/movie_detail_provider.dart';

import '../../../../core/share_providers/movies_provider/movies_provider.dart';

class HomePageView extends ConsumerWidget {
  HomePageView({Key? key}) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();

  // ----------------------------------------------------------
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upComingMoviesList = ref.watch(homeStateProvider).upComingMoviesResponse;
    final isLoading = ref.watch(homeStateProvider).isLoading;

    return Scaffold(
      body: isLoading
          ? const Center(
              child: buildLoader(),
            )
          : buildHomeBody(upComingMoviesList: upComingMoviesList, ref: ref),
    );
  }

  // ----------------------------------------------------------
  Widget buildHomeBody({
    required UpComingMoviesResponse upComingMoviesList,
    required WidgetRef ref,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 67.h,
        ),
        buildTopBar(ref: ref),
        SizedBox(
          height: 24.h,
        ),
        buildMovieList(
          upComingMoviesList: upComingMoviesList,
          ref: ref
        )
      ],
    );
  }

  // ----------------------------------------------------------
  Widget buildTopBar({required WidgetRef ref}) {
    final showSearch = ref.read(homeStateProvider).showSearch;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
      child: !showSearch ? buildWatchWithTextIcon(ref: ref) : buildSearchBar(ref: ref),
    );
  }

  // ----------------------------------------------------------
  Widget buildWatchWithTextIcon({required WidgetRef ref}) {
    return Padding(
        key: const ValueKey<int>(1),
        padding: MVPaddings.homePagePadding,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Watch', style: MVStyles.HOMEPAGE_WATCH_STYLE),
          buildSearchIcon(ref: ref),
        ]));
  }

  // ----------------------------------------------------------
  Widget buildSearchBar({required WidgetRef ref}) {
    return Padding(
        key: const ValueKey<int>(0),
        padding: MVPaddings.homePagePadding,
        child: Container(
          height: 52.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            color: Colors.grey[200],
          ),
          child: TextField(
            controller: _textEditingController,
            onChanged: (value){
              ref.read(homeStateProvider.notifier).searchThisMovieList(query: value);
            },
            decoration: InputDecoration(
              hintText: 'TV shows, movies and more',
              hintStyle: MVStyles.HOMEPAGE_SEARCH_STYLE,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search),
              suffixIcon:
                GestureDetector(
                  onTap: () {
                      _textEditingController.clear();
                      ref.read(homeStateProvider.notifier).clearSearch(showSearch: false);

                  },
                  child: const  Icon(Icons.close, ),
                ),
              ),
          ),
        ));
  }

  // ----------------------------------------------------------
  Widget buildSearchIcon({required WidgetRef ref}) {
    return InkWell(
        onTap: () {
          ref.read(homeStateProvider.notifier).toggleShowSearch();
        },
        child: Image.asset(
          MVAssets.ICON_SEARCH,
          width: 19,
          height: 19,
        ));
  }

  // ----------------------------------------------------------
  Widget buildMovieList({required UpComingMoviesResponse upComingMoviesList, required WidgetRef ref}) {
    return Expanded(
        child: Container(
      color: MVColors.GREY_LIGHT_1,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: upComingMoviesList.results?.length,
        itemBuilder: (context, index) {
          Results movie = upComingMoviesList.results![index];
          return MovieItemView(
            movie: movie,
            onTap: () {
              Navigator.pushNamed(context, Routes.movieDetail, arguments: movie);
              ref.read(movieDetailProvider.notifier).getMovieDetail(id: movie.id!);
            },
          );
        },
      ),
    ));
  }
}
