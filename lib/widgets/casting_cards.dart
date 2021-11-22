import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/models/models.dart';

class CastingCards extends StatelessWidget {
  
  final int movieId;

  const CastingCards({
  Key? key, 
  required this.movieId,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: ( _ , AsyncSnapshot<List<Cast>> snapshot) {

        if ( !snapshot.hasData ){
          return Container(
            margin: const EdgeInsets.only( bottom: 30.0 ),
            width: double.infinity,
            height: 180.0,
            child: const Center(child: CircularProgressIndicator( color: Colors.indigo )),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only( bottom: 30.0 ),
          width: double.infinity,
          height: 180.0,
          // color: Colors.red,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (context, index) => _CastCards( actor: cast[index] )
          ),
        );
      },
    );
    
  }
}

class _CastCards extends StatelessWidget {

  final Cast actor;

  const _CastCards({
    Key? key, required this.actor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.0,
      height: 100.0,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage( actor.fullProfilePath ),
              height: 140.0,
              width: 100.0,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox( height: 5.0),
          
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}