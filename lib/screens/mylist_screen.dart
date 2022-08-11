import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/cubit/cubit/cubit.dart';
import 'package:movies/cubit/cubit/states.dart';
import 'package:movies/models/movie_model.dart';

import '../styles/icons_broken.dart';
import 'details _screen.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(

      create: (BuildContext context)=>MoviesCubit()..getFvaMovies(),
      child: BlocConsumer<MoviesCubit,MoviesStats>(
        listener: (context,state){},
        builder: (context,state){

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){

                  return buildItem(MoviesCubit.get(context).favMovie[index],context);
                },
                separatorBuilder:(context,index){
                  return Column(
                    children: [

                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20,),
                    ],
                  );
                } ,
                itemCount: MoviesCubit.get(context).favMovie.length
            ),
          );
        },
      ),
    );
  }

}
Widget buildItem(MovieModel model,context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      InkWell(
          onTap: (){
            Navigator.push(
           context,
            MaterialPageRoute(builder: (context) =>  DetailsScreen(model)),
            );
            },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey)
          ),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [

              Row(
                children: [
                  Card(
                    elevation: 10,
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child:Image(image:
                    NetworkImage('${model.image}') ,
                      height: 150,
                      width: 200,
                      fit: BoxFit.cover,
                    ) ,


                  ),
                  SizedBox(width: 10,),
                  Container(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${model.name}',style: GoogleFonts.lato(color: Colors.white,fontSize: 22),),
                        SizedBox(height: 20,),
                        Text('rate :  ${model.rate}',style: GoogleFonts.lato(color: Colors.white,fontSize: 18),),
                        SizedBox(height: 20,),
                        Text('type :  ${model.type}',style: GoogleFonts.lato(color: Colors.white,fontSize: 18),),


                    ],),
                  ),
                ],
              ),
               Padding(

                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    MoviesCubit.get(context).UpdateData(
                        name: model.name,
                        actor1: model.actor1,
                        actor2: model.actor2,
                        actor3: model.actor3!,
                        description: model.description!,
                        id: model.id!,
                        image: model.image!,
                        isfav: false,
                        rate: model.rate!,
                        type: model.type!);
                  },
                  child: const CircleAvatar(

                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close,size: 18,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    ],
  );
}
