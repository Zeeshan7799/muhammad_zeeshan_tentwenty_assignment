import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mv_colors.dart';

class MVStyles {

  // HomePage Styles ----------------------------------------------------------
  static TextStyle HOMEPAGE_WATCH_STYLE = GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16.sp, color: MVColors.HOMEPAGE_WATCH_COLOR);
  static TextStyle HOMEPAGE_MOVIE_NAME_STYLE = GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.white);
  static TextStyle HOMEPAGE_SEARCH_STYLE = GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14.sp, color: MVColors.HOMEPAGE_WATCH_COLOR.withAlpha(70));

  // Movie Detail Styles----------------------------------------------------------
  static TextStyle MOVIE_DETAIL_IN_THEATERS_STYLE = GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.white);
  static TextStyle MOVIE_DETAIL_TICKETS_TRAILER_STYLE = GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14.sp, color: Colors.white);
  static TextStyle MOVIE_DETAIL_GENRES_STYLE = GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12.sp, color: Colors.white);
  static TextStyle MOVIE_DETAIL_SUB_HEADING_STYLE = GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16.sp, color: MVColors.HOMEPAGE_WATCH_COLOR);
  static TextStyle MOVIE_DETAIL_OVERVIEW_STYLE = GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 12.sp, color: MVColors.OVERVIEW_COLOR);
}
