import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';

class MovieSlider extends StatefulWidget {
  
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key, 
    required this.movies, 
    required this.onNextPage,
    this.title, 
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {

      if( scrollController.position.pixels >= scrollController.position.maxScrollExtent )
        // ignore: curly_braces_in_flow_control_structures
        widget.onNextPage();
    });
    
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    if ( widget.movies.isEmpty )
      // ignore: curly_braces_in_flow_control_structures
      return const SizedBox(
        width: double.infinity,
        height: 260.0,
        child: Center(
          child: CircularProgressIndicator( color: Colors.indigo ),
        ),
      );
      
    return SizedBox(
      width: double.infinity,
      height: 260.0,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if ( widget.title != null )
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(widget.title!, style: const TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),

          const SizedBox( height: 5.0),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) => _MoviePoster(widget.movies[index])
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  
  final Movie movie;

  const _MoviePoster( this.movie );
  
  @override
  Widget build(BuildContext context) {


    return Container(
      width: 130.0,
      height: 190.0,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130.0,
                height: 190.0,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox( height: 5.0),

          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}