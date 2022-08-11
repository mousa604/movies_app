import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/cubit/cubit/cubit.dart';
import 'package:movies/cubit/cubit/states.dart';
import 'package:movies/models/movie_model.dart';

import '../styles/icons_broken.dart';


class DetailsScreen extends StatelessWidget {
  MovieModel model;
  DetailsScreen(this.model, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(

      create: (BuildContext context)=>MoviesCubit()..getOnce(model.id!),
      child: BlocConsumer<MoviesCubit,MoviesStats>(
        listener: (context,state){
          if(state is GetOnceLoadingStats) {
            Center(child: const CircularProgressIndicator());
          }
        },
        builder: (context,state){

          var cubit =MoviesCubit.get(context);
          return Scaffold(


            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Column(

                children: [
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children:  [
                      Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child:Image(image:
                        NetworkImage('${model.image}'),
                          height: 450,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),


                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: IconButton(onPressed: () {
                          Navigator.pop(context);
                        },
                            icon: const Icon(Icons.arrow_back_ios_outlined,size: 25,color: Colors.white,)),
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Container(
                              width: 70,
                              height: 30,
                              child: Center(child: Text('+18',style: GoogleFonts.lato(fontSize: 17,color: Colors.white),)),
                              decoration: BoxDecoration(
                                  color: Colors.white12,

                                  borderRadius: BorderRadius.circular(7)
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              width: 70,
                              height: 30,
                              child: Center(child: Text('${model.type}',style: GoogleFonts.lato(fontSize: 17,color: Colors.white),)),
                              decoration: BoxDecoration(
                                  color: Colors.white12,

                                  borderRadius: BorderRadius.circular(7)
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              width: 70,
                              height: 30,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    const Icon(Icons.star,size: 15,color: Colors.amber,),
                                    const SizedBox(width: 5,),
                                    Text('${model.rate}',style: GoogleFonts.lato(fontSize: 17,color: Colors.white))
                                  ],),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white12,

                                  borderRadius: BorderRadius.circular(7)
                              ),
                            ),
                            const Spacer(),
                            Conditional.single(
                                fallbackBuilder: (BuildContext context) =>const Center(child: CircularProgressIndicator(color: Colors.black,)),
                                conditionBuilder: (BuildContext context) =>state is! GetOnceLoadingStats,
                                context: context,
                                widgetBuilder: (BuildContext context) {
                                  return InkWell(
                                    child: Icon(IconBroken.Heart,color:cubit.once!.isfav!?Colors.red:Colors.white,),

                                    onTap: (){

                                      cubit.UpdateData(
                                        type: model.type!,
                                        rate: model.rate!,
                                        image: model.image!,
                                        id:model.id! ,
                                        description: model.description!,
                                        name: model.name,
                                        actor3: model.actor3!,
                                        actor2: model.actor2,
                                        actor1: model.actor1,
                                        isfav:!cubit.once!.isfav!,
                                      );



                                    },
                                  );
                                }
                            ),
                            const SizedBox(width: 20,)
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Text('${model.name}',style: GoogleFonts.lato(fontSize:25,color: Colors.white,fontWeight: FontWeight.bold ),),
                        const SizedBox(height: 8,),
                        Text('${model.description}',
                          style: GoogleFonts.lato(color: Colors.grey,fontSize: 17),maxLines: 5,overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 30,),
                        Text('Actors',style: GoogleFonts.lato(fontSize:25,color: Colors.white,fontWeight: FontWeight.bold ),),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            Card(
                              elevation: 10,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child:Image(image:
                              NetworkImage('${model.actor1}'),
                                height: 100,
                                width:70,
                                fit: BoxFit.fill,
                              ),


                            ),
                            const SizedBox(width: 10,),
                            Card(
                              elevation: 10,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child:Image(image:
                              NetworkImage('${model.actor2}'),
                                height: 100,
                                width:70,
                                fit: BoxFit.fill,
                              ),


                            ),
                            const SizedBox(width: 10,),
                            Card(
                              elevation: 10,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child:Image(image:
                              NetworkImage('${model.actor3}'),
                                height: 100,
                                width:70,
                                fit: BoxFit.fill,
                              ),


                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
