





import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/models/movie_model.dart';

import 'states.dart';

class MoviesCubit extends Cubit<MoviesStats>{
  MoviesCubit() : super(MoviesInitialStats());

  static MoviesCubit get(context)=>BlocProvider.of(context);


  List<MovieModel> movies=[];

  void getAllMovies(){
    movies=[];
    FirebaseFirestore.instance
        .collection('movies')
        .get()
        .then((value) {
      value.docs.forEach((element) {

          movies.add(MovieModel.fromJson(element.data())) ;

      });
      emit(GetAllMoviesSuccessStats());
    }).catchError((error){
      emit(GetAllMoviesErrorStats());
    });

  }


  MovieModel? once;

  void getOnce(String id){
        emit(GetOnceLoadingStats());
    FirebaseFirestore.instance
        .collection('movies')
        .doc(id)
        .get()
        .then((value) {
          once=MovieModel.fromJson(value.data()!);
          print('kkkkkkkkkkkkkkkkk  ${once!.isfav}');
      emit(GetOnceSuccessStats());
    }).catchError((error){
      emit(GetOnceErrorStats());
    });

  }


  List<MovieModel> comingSoon=[];

  void getGomingMovies(){
    comingSoon=[];
    FirebaseFirestore.instance
        .collection('comingsoon')
        .get()
        .then((value) {
      value.docs.forEach((element) {

        comingSoon.add(MovieModel.fromJson(element.data())) ;

      });
      emit(GetComingSoonMoviesSuccessStats());
    }).catchError((error){
      emit(GetComingSoonErrorStats());
    });

  }

  var selectedIndex=0;
  void changeIndex(index){
    selectedIndex=index;
    emit(ChangeIndexStats());
  }

  List<MovieModel> filterMovie=[];
  void filterMovies(String type){
    filterMovie=[];
    movies.forEach((element) {
      if(element.type==type){
          filterMovie.add(element);
        emit(AddElementStats());
      }
    });
    emit(AddElementStats());
  }

  void UpdateData(
      {
        required name,
        required actor1 ,
        required actor2,
        required String actor3,
        required String description,
        required String id,
        required String image,
        required bool isfav,
        required String rate,
        required String type,

      }){
    MovieModel model=MovieModel(

        name: name,
        actor1:actor1 ,
        actor2: actor2,
        actor3: actor3,
        description:description ,
        id:id ,
        image:image ,
        isfav:isfav ,
        rate:rate ,
        type: type,


    );
    FirebaseFirestore.instance
        .collection('movies')
        .doc(id).update(model.toMap())
        .then((value) {
          getOnce(model.id!);
          getFvaMovies();

          emit(UpDateSuccessStats());

    })
        .catchError((error){
          emit(UpDateErrorStats());
    });
  }


  List<MovieModel> favMovie=[];
  void getFvaMovies(){
    favMovie=[];
    FirebaseFirestore.instance
        .collection('movies').where('isfav',isEqualTo: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {

        favMovie.add(MovieModel.fromJson(element.data())) ;




      });
      emit(GetAllMoviesSuccessStats());
    }).catchError((error){
      emit(GetAllMoviesErrorStats());
    });

  }

  void bb(){
    print('${favMovie.length}cccccccccccccccccc   $favMovie ');
    print('${movies.length}hhhhhhhhhhhhhh   $movies ');
  }


   }



