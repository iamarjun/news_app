import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:news_app/models/country.dart';
import 'package:news_app/models/sources.dart';
import 'package:news_app/screens/detail/news_detail.dart';
import 'package:news_app/screens/home/bloc/headlines_bloc.dart';
import 'package:news_app/screens/home/widgets/article_widget.dart';
import 'package:news_app/screens/home/widgets/bottom_loader.dart';
import 'package:news_app/screens/home/widgets/location_widget.dart';
import 'package:news_app/screens/location/cubit/geolocation_cubit.dart';
import 'package:news_app/screens/location/cubit/location_cubit.dart';
import 'package:news_app/screens/location/location_bottom_sheet.dart';
import 'package:news_app/screens/home/widgets/search_widget.dart';
import 'package:news_app/screens/source/cubit/source_cubit.dart';
import 'package:news_app/screens/source/source_bottom_sheet.dart';

class MyHomePage extends StatefulWidget {
  static final String route = '/';

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HeadlinesBloc _headlinesBloc;
  String _selection;
  String _selectedCountryCode;
  String _selectedSourceIds;
  String _searchQuery;
  String _selectedCountry;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _headlinesBloc = BlocProvider.of<HeadlinesBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('News'),
        actions: [
          BlocBuilder<GeolocationCubit, GeolocationState>(
            builder: (context, state) {
              if (state is GeolocationSuccess) {
                Placemark country = state.country;
                _selectedCountryCode = country.isoCountryCode;
                _headlinesBloc.add(
                  HeadlinesFetch(country: _selectedCountryCode),
                );
                print(country.toString());
                return BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    if (state is LocationInitial) {
                      return LocationInkWell(onTap: () {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Loading locations...'),
                            ),
                          );
                        }, location: country.country);
                    }

                    if (state is LocationFailure) {
                      return LocationInkWell(onTap: () {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Something went wrong...'),
                            ),
                          );
                        }, location: country.country);
                    }

                    if (state is LocationSuccess) {
                      if (state.dataHolder.countries.isEmpty) {
                        return LocationInkWell(onTap: () {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Locations not available...'),
                              ),
                            );
                          }, location: country.country);
                      }

                      state.dataHolder.setCurrentCountry = country;
                      return LocationInkWell(onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => LocationBottomSheet(
                              dataHolder: state.dataHolder,
                              onPressed: (Country country) {
                                print(country.toString());
                                _headlinesBloc.add(
                                  HeadlinesFetch(
                                    country: country.code,
                                  ),
                                );
                                setState(() {
                                  _selectedCountry = country.name;
                                });
                                _selectedCountryCode = country.code;
                                _selectedSourceIds = null;
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        }, location: country.country);
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Search(
              onSubmiited: (value) {
                _searchQuery = value;
                _headlinesBloc.add(
                  HeadlinesFetch(
                    country: _selectedCountryCode,
                    sources: _selectedSourceIds,
                    query: value,
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Headlines',
                  style: TextStyle(fontSize: 22.0),
                ),
                PopupMenuButton<String>(
                  child: Row(
                    children: [
                      Text('Sort: $_selection'),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  onSelected: (String value) {
                    setState(() {
                      _selection = value;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Popular',
                      child: Text('Popular'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Newest',
                      child: Text('Newest'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Oldest',
                      child: Text('Oldest'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            BlocBuilder<HeadlinesBloc, HeadlinesState>(
              builder: (context, state) {
                if (state is HeadlinesInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is HeadlinesFailure) {
                  return Center(
                    child: Text('failed to fetch posts'),
                  );
                }
                if (state is HeadlinesSuccess) {
                  if (state.articles.isEmpty) {
                    return Center(
                      child: Text('no posts'),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return index >= state.articles.length
                            ? BottomLoader()
                            : InkWell(
                                child: ArticleWidget(
                                  article: state.articles[index],
                                ),
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  NewsDetail.route,
                                  arguments: state.articles[index],
                                ),
                              );
                      },
                      itemCount: state.hasReachedMax
                          ? state.articles.length
                          : state.articles.length + 1,
                      controller: _scrollController,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<SourceCubit, SourceState>(
        builder: (context, state) {
          if (state is SourceInitial) {
            return buildFloatingActionButton(
              () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Loading Sources...'),
                  ),
                );
              },
            );
          }
          if (state is SourceFailure) {
            return buildFloatingActionButton(
              () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Something went wrong...'),
                  ),
                );
              },
            );
          }
          if (state is SourceSuccess) {
            if (state.sources.isEmpty) {
              return buildFloatingActionButton(
                () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sources not available...'),
                    ),
                  );
                },
              );
            }
            return buildFloatingActionButton(
              () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => SourceBottomSheet(
                    source: state.sources,
                    onPressed: (List<Sources> sources) {
                      print(sources.toString());
                      String sIds = getSourceIdsFromSourceList(sources);
                      _selectedSourceIds = sIds;
                      _selectedCountryCode = null;
                      _headlinesBloc.add(
                        HeadlinesFetch(
                          sources: sIds,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String getSourceIdsFromSourceList(List<Sources> sources) {
    String sourceIds = '';

    sources.forEach((element) {
      sourceIds += '${element.id},';
    });

    return sourceIds;
  }

  FloatingActionButton buildFloatingActionButton(Function onPressed) {
    return FloatingActionButton(
      child: Icon(
        Icons.filter_alt,
      ),
      onPressed: onPressed,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _headlinesBloc.add(HeadlinesFetch(
        country: _selectedCountryCode,
        sources: _selectedSourceIds,
        query: _searchQuery,
      ));
    }
  }
}

