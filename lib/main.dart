import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/home/bloc/headlines_bloc.dart';
import 'package:news_app/screens/home/home_page.dart';
import 'package:news_app/service/api_service.dart';
import 'package:news_app/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kColorPrimary,
        accentColor: kColorPrimaryDark,
        scaffoldBackgroundColor: kColorSecondary,
        textTheme: TextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<HeadlinesBloc>(
        create: (context) =>
            HeadlinesBloc(service: ApiService())..add(HeadlinesFetch()),
        child: MyHomePage(),
      ),
    );
  }
}
