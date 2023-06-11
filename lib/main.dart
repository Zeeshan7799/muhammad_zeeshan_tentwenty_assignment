import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_flutter/routes/app_routes.dart';
import 'package:tmdb_flutter/routes/routes.dart';
import 'package:tmdb_flutter/ui/screens/home_page/view/home_page_view.dart';

import 'ui/components/dismiss_keybaord.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      builder: (context, child){
        return DismissKeyboard(
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: HomePageView(),
            onGenerateRoute: generateRoute,
            initialRoute: Routes.home,
          ),
        );
      },
    );
  }
}

