import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/home/bloc/headlines_bloc.dart';
import 'package:news_app/screens/home/home_page.dart';
import 'package:news_app/screens/source/cubit/source_cubit.dart';
import 'package:news_app/service/api_service.dart';
import 'package:news_app/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService service = ApiService();
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HeadlinesBloc>(
            create: (context) => HeadlinesBloc(service: service)
              ..add(
                HeadlinesFetch(),
              ),
          ),
          BlocProvider<SourceCubit>(
            create: (context) => SourceCubit(service: service)..getSources(),
          ),
        ],
        child: MyHomePage(),
      ),
    );
  }
}
