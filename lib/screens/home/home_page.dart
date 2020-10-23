import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/home/bloc/headlines_bloc.dart';
import 'package:news_app/screens/home/widgets/article_widget.dart';
import 'package:news_app/screens/home/widgets/bottom_loader.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  HeadlinesBloc _headlinesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _headlinesBloc = BlocProvider.of<HeadlinesBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.location_on), Text('India')],
            ),
          )
        ],
      ),
      body: BlocBuilder<HeadlinesBloc, HeadlinesState>(
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
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.articles.length
                    ? BottomLoader()
                    : ArticleWidget(article: state.articles[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.articles.length
                  : state.articles.length + 1,
              controller: _scrollController,
            );
          }
        },
      ),
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
