import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/home/bloc/headlines_bloc.dart';
import 'package:news_app/screens/home/widgets/article_widget.dart';
import 'package:news_app/screens/home/widgets/bottom_loader.dart';
import 'package:news_app/screens/home/widgets/location_bottom_sheet.dart';
import 'package:news_app/screens/home/widgets/search_widget.dart';
import 'package:news_app/screens/source/cubit/source_cubit.dart';
import 'package:news_app/screens/source/source_bottom_sheet.dart';
import 'package:news_app/utils/constants.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedCountry = 0;
  HeadlinesBloc _headlinesBloc;
  String _selection;

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
          InkWell(
            onTap: () => showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => LocationBottomSheet(
                index: _selectedCountry,
                countryList: countryList,
                onChanged: (index, e) {
                  setState(() {
                    _selectedCountry = index;
                    e.setSelected = !e.isSelected;
                  });
                  print(countryList[index]);
                  Navigator.pop(context);
                },
                onPressed: () {},
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.location_on), Text('India')],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Search(),
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
                            : ArticleWidget(article: state.articles[index]);
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
                    onPressed: () {},
                  ),
                );
              },
            );
          }
        },
      ),
    );
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
      _headlinesBloc.add(HeadlinesFetch());
    }
  }
}
