import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_searcher/Movie.dart';
import 'package:movie_searcher/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:movie_searcher/movie_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var searchController = TextEditingController();
  late StreamController _streamController;

  late Stream _stream;

  searchMovieInfo({required String movieName}) async {
    if (movieName.isEmpty) {
      _streamController.add('empty');
      return;
    }
    if (await ChkConnectivity.isNotConnected()) {
      _streamController.add('not_connected');
      return;
    }
    _streamController.add('Loading');
    // Api Call
    var response = await http.get(Uri.parse(
        'https://www.omdbapi.com/?t=$movieName&plot=full&apiKey=e5ed294e'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _streamController.add(Map<String, dynamic>.from(data));
    } else {
      _streamController.add('wrong');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
    _streamController.add('empty');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Movies INFO'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20,),
                const Text('Get More Information about Movies',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green,
                  ),),
                SizedBox(height: 20,),

                TextField(
                  style: TextStyle(color: Colors.black, fontSize: 25,),
                  controller: searchController,
                  decoration: InputDecoration(
                      hintText: 'Search Movie',

                      suffixIcon: IconButton(onPressed: () {
                        final movieName = searchController.text.trim();
                        searchMovieInfo(movieName: movieName);
                      }, icon: Icon(Icons.search),),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))
                  ),
                  maxLines: 1,

                ),
                SizedBox(height: 10,),



              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (snapshot.data == 'empty') {
                    return const Center(
                      child: Text('Please Provide Movie Name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),);
                  } else if (snapshot.data == 'not_connected') {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.signal_wifi_connected_no_internet_4),
                          Text('No Internet Connection',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),

                        ],
                      ),
                    );
                  } else if (snapshot.data == 'Loading') {
                    return const Center(
                      child: CircularProgressIndicator(),);
                  } else if (snapshot.data == 'wrong') {
                    return const Center(
                      child: Text('Something went wrong'),);
                  } else {
                    var movieData = snapshot.data as Map<String, dynamic>;
                    var movie = Movie.fromJson(movieData);
                    return MovieModel(movie: movie);
                  }
                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
