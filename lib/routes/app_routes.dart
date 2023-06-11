
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_flutter/core/network/response_models/up_coming_movies_response.dart';
import 'package:tmdb_flutter/routes/routes.dart';
import 'package:tmdb_flutter/ui/screens/movie_detail_screen/view/movie_detail_screen.dart';

import '../ui/screens/home_page/view/home_page_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {


    // ----------------------------------------------------------
    case Routes.home:
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return HomePageView();
      });

      // ----------------------------------------------------------
       case Routes.movieDetail:
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Results movie = settings.arguments! as Results;
        return MovieDetailScreen(movie: movie);
      });

    default:
      return PageRouteBuilder<dynamic>(
          pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
              HomePageView());
  }
}
