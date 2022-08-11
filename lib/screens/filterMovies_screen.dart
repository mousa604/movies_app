import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/cubit/cubit/cubit.dart';
import 'package:movies/cubit/cubit/states.dart';
import 'package:movies/models/movie_model.dart';

import 'details _screen.dart';

class MoviesScreen extends StatelessWidget {


  List<MovieModel> model;
  MoviesScreen(this.model);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>MoviesCubit(),
      child: BlocConsumer<MoviesCubit,MoviesStats>(
        listener: (context,state){},
        builder: (context,state){
          var cubit =MoviesCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                titleSpacing: 0,
                title: Text('action',style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 40),),
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,size: 30,),
                ),


              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.count(
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1/1.5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(
                        model.length,
                            (index) =>buildItem(model[index],context)
                    ),
                  ),
                ),
              ),

            ),
          );
        },
      ),
    );
  }
}

Widget buildItem(MovieModel model,context){
  return  Column(
    children: [
      Column(
        children: [
          Card(
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
                height: 240,
                width: 180,
                fit: BoxFit.cover,
              ),
            ) ,


          ),
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
        ],
      ),
    ],
  );
}