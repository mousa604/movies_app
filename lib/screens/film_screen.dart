import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/cubit/cubit/cubit.dart';
import 'package:movies/cubit/cubit/states.dart';
import 'package:movies/models/movie_model.dart';

import '../styles/icons_broken.dart';
import 'details _screen.dart';
import 'filterMovies_screen.dart';


class FilmScreen extends StatelessWidget {
  const FilmScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>MoviesCubit()..getAllMovies()..getGomingMovies()..bb(),
      child: BlocConsumer<MoviesCubit,MoviesStats>(
        listener: (context,state){},
        builder: (context,state){
          var cubit =MoviesCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.black,
            body:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text('Coming Soon',style: GoogleFonts.lato(color: Colors.white,fontSize: 25),),
                      const SizedBox(height: 20,),
                      Container(
                        height: 180,
                        width: 600,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),

                            itemBuilder: (context,index)=>buildComingSoonItem(cubit.comingSoon[index]),
                            separatorBuilder:(context,index)=> const SizedBox(height: 10,),
                            itemCount: cubit.comingSoon.length),
                      ),

                      const SizedBox(height: 25,),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            
                            InkWell(
                              child: Container(
                                width: 120,
                                height: 40,
                                child: Center(child: Text('Action',style: GoogleFonts.lato(fontSize: 20,color: Colors.white),)),
                                decoration: BoxDecoration(
                                    color: Colors.white12,

                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                              onTap: (){

                                cubit.filterMovies('action');
                                print('${cubit.filterMovie.length}');

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MoviesScreen(cubit.filterMovie)));
                              },
                            ),
                            const SizedBox(width: 10,),
                            InkWell(
                              child: Container(
                                width: 120,
                                height: 40,
                                child: Center(child: Text('Comedy',style: GoogleFonts.lato(fontSize: 20,color: Colors.white),)),
                                decoration: BoxDecoration(
                                    color: Colors.white12,

                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                              onTap: (){
                                cubit.filterMovies('comedy');
                                print('${cubit.filterMovie.length}');

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  MoviesScreen(cubit.filterMovie)));
                              },
                            ),
                            const SizedBox(width: 10,),
                            InkWell(
                              child: Container(
                                width: 120,
                                height: 40,
                                child: Center(child: Text('Romance',style: GoogleFonts.lato(fontSize: 20,color: Colors.white),)),
                                decoration: BoxDecoration(
                                    color: Colors.white12,

                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                              onTap: (){
                                cubit.filterMovies('romance');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MoviesScreen(cubit.filterMovie)));
                              },
                            ),
                            const SizedBox(height: 20,),
                            InkWell(
                              child: Container(
                                width: 120,
                                height: 40,
                                child: Center(child: Text('Anime',style: GoogleFonts.lato(fontSize: 20,color: Colors.white),)),
                                decoration: BoxDecoration(
                                    color: Colors.white12,

                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                              onTap: (){
                                cubit.filterMovies('anime');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MoviesScreen(cubit.filterMovie)));
                              },
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),

                      Text('Trending Now',style: GoogleFonts.lato(color: Colors.white,fontSize: 25),),

                    ],
                  ),
                ),

                Container(
                  height: 350,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index)=> buildTrendingItem(cubit.movies[index],context),
                      separatorBuilder: (context,index)=>const SizedBox(width: 5,),
                      itemCount: cubit.movies.length)
                )

              ],
            ) ,
          );
        },
      ),
    );
  }
}
Widget buildTrendingItem(MovieModel model,context){
  return  Column(
    children: [
       Card(
        elevation: 10,
        margin: const EdgeInsets.all(8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child:InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  DetailsScreen(model)),
            );
          },
          child: Image(image:
          NetworkImage('${model.image}') ,
           height: 275,
           width: 180,
           fit: BoxFit.cover,
          ),
        ) ,


      ),
      Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                width: 50,
                height: 30,
                child: Center(child: Text('+18',style: GoogleFonts.lato(fontSize: 12,color: Colors.white),)),
                decoration: BoxDecoration(
                    color: Colors.white12,

                    borderRadius: BorderRadius.circular(5)
                ),
              ),
              const SizedBox(width: 5,),
              Container(
                width: 50,
                height: 30,
                child: Center(child: Text('${model.type}',style: GoogleFonts.lato(fontSize: 12,color: Colors.white),)),
                decoration: BoxDecoration(
                    color: Colors.white12,

                    borderRadius: BorderRadius.circular(5)
                ),
              ),
              const SizedBox(width: 5,),
              Container(
                width: 50,
                height: 30,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Icon(Icons.star,size: 13,color: Colors.amber,),
                      const SizedBox(width: 5,),
                      Text('${model.rate}',style: GoogleFonts.lato(fontSize: 12,color: Colors.white))
                    ],),
                ),
                decoration: BoxDecoration(
                    color: Colors.white12,

                    borderRadius: BorderRadius.circular(5)
                ),
              ),
            ],
          ),
          SizedBox(height: 8,),
          Text('${model.name}',style: GoogleFonts.lato(color: Colors.white,fontSize: 14),)
        ],
      ),
    ],
  );
}

Widget buildComingSoonItem(MovieModel modelx){
  return Stack(
    alignment: AlignmentDirectional.topEnd,
    children: [
      Container(

          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(15)
          ),
          child:Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
               Image(image:
              NetworkImage('${modelx.image}'),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(children: [
                  const SizedBox(height: 5,),
                  Text('${modelx.name}',style: GoogleFonts.lato(fontWeight:FontWeight.bold,fontSize: 15,color: Colors.white ),)

                ],),
              )
            ],
          )
      ),

    ],
  );
}
