import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/articles.dart';
import 'package:news_app/models/data_holder.dart';
import 'package:news_app/screens/detail/news_detail.dart';
import 'package:news_app/screens/detail/news_webview.dart';
import 'package:news_app/screens/home/bloc/headlines_bloc.dart';
import 'package:news_app/screens/home/home_page.dart';
import 'package:news_app/screens/location/cubit/geolocation_cubit.dart';
import 'package:news_app/screens/location/cubit/location_cubit.dart';
import 'package:news_app/screens/source/cubit/source_cubit.dart';
import 'package:news_app/service/location/geo_location.dart';
import 'package:news_app/service/network/api_service.dart';
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
      onGenerateRoute: (settings) {
        if (settings.name == NewsDetail.route) {
          Articles article = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => NewsDetail(
              articles: article,
            ),
          );
        }

        if (settings.name == NewsWebView.route) {
          String url = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => NewsWebView(
              url: url,
            ),
          );
        }
      },
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HeadlinesBloc>(
            create: (context) => HeadlinesBloc(service: service),
          ),
          BlocProvider<SourceCubit>(
            create: (context) => SourceCubit(service: service)..getSources(),
          ),
          BlocProvider<LocationCubit>(
            create: (context) => LocationCubit(
              dataHolder: LocationDataHolder(
                countries: countryList,
                selectedCountryIndex: 0,
              ),
            )..getCountries(),
          ),
          BlocProvider<GeolocationCubit>(
            create: (context) => GeolocationCubit(
              location: GeoLocation(),
            )..getCountryCode(),
          ),
        ],
        child: MyHomePage(),
      ),
    );
  }
}
