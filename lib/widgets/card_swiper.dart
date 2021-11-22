import 'package:flutter/material.dart';

import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({
    Key? key, 
    required this.movies,
  }) : super(key: key);
  

  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if( movies.isEmpty )
      // ignore: curly_braces_in_flow_control_structures
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator( color: Colors.indigo,),
        ),
      );
    
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      // color: Colors.red,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (context, index) {

          final movie = movies[index];

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}