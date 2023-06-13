import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';

import '../description.dart';

class TopRated extends StatelessWidget {

  final List toprated;

  const TopRated({super.key, required this.toprated});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(text: 'Top Rated Movies', size: 26, color: Colors.white60,),
          SizedBox(height: 10,),
          Container(
            height: 270,
            child: ListView.builder(itemCount: toprated.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>Description(
                          name: toprated[index]['title'],
                          bannerurl: 'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path'],
                          posterurl: 'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path'],
                          description: toprated[index]['overview'],
                          vote: toprated[index]['vote_average'].toString(),
                          launch_on: toprated[index]['released_date'].toString(),
                        )));

                  },
                  child: Container(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path']
                                )
                            ),
                          ),
                        ),
                        Container(
                          child: ModifiedText(text: toprated[index]['title']!=null?
                          toprated[index]['title']: 'Loading',size: 15, color: Colors.white60, ),
                        ),
                      ],
                    ),
                  ),
                );
              },),
          ),
        ],
      ),
    );
  }
}
