import 'package:flutter/material.dart';
import 'package:movie_searcher/Movie.dart';
import 'package:movie_searcher/movie_item.dart';

class MovieModel extends StatelessWidget {

  final Movie movie ;

   MovieModel({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Image.network(
              movie.poster!,fit: BoxFit.fill,),
          ),
          MovieItem(label: 'Writer/', value: movie.writer!),
          MovieItem(label: 'Director/', value: movie.director!),
          MovieItem(label: 'Actors/', value: movie.actors!),
          MovieItem(label: 'Title/', value: movie.title!),
          MovieItem(label: 'Release/', value: movie.released!),
          MovieItem(label: 'Country/', value: movie.country!),
          MovieItem(label: 'Language/', value: movie.language!),
          MovieItem(label: 'Awards/', value: movie.awards!),
          MovieItem(label: 'Rating/', value: movie.rated!),
          MovieItem(label: 'BoxOffice/', value: movie.boxOffice!),
          MovieItem(label: 'Plots/', value: movie.plot!),




        ],
      ),
    );
  }
}
