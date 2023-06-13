import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/toprated.dart';
import 'package:movie_app/widgets/trending.dart';
import 'package:movie_app/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
      ),
    );
  }
}

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  final String apikey = '758da1632919911ca4e63beb01f8aac8';
  final readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NThkYTE2MzI5MTk5MTFjYTRlNjNiZWIwMWY4YWFjOCIsInN1YiI6IjY0ODc3OGZkZTM3NWMwMDBlMjUwOTY4ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8h7Bd0x0o71Y4Zu_SPWW531EFqj-p10KlbztEk8pa-I';

  @override
  void initState(){
    loadmovies();
    super.initState();
  }

  loadmovies()async{
TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccesstoken),
logConfig: ConfigLogger(
  showLogs: true,
  showErrorLogs: true
));
Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();

setState(() {
  trendingmovies = trendingresult['results'];
  topratedmovies = topratedresult['results'];
  tv = tvresult['results'];
});
print(trendingmovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: ModifiedText(text: 'Flutter Movie App', size: 30, color: Colors.white60,),),
      
      body: ListView(
       children: [
         TV(tv: tv),
         TopRated(toprated: topratedmovies),
         TrendingMovies(trending: trendingmovies)
       ],
      ),
    );
  }
}


