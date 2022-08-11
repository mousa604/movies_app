import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Series_screen.dart';
import 'film_screen.dart';
import 'mylist_screen.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar:PreferredSize(
          preferredSize:const Size.fromHeight(70.0) ,
          child: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,


            bottom:  TabBar(
              padding: EdgeInsets.symmetric(horizontal: 60),
              labelColor: Colors.red,
              indicatorColor: Colors.black38,
              unselectedLabelColor: Colors.white,
              tabs: [

                Tab(icon: Text('Film',style:GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 20)),),
                Tab(icon: Text('My List',style:GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 20)),),
              ],),


          ),
        ),
        body: const TabBarView(
          children: [


            FilmScreen(),
            MyListScreen(),


          ],),
      ),

    );
  }
}
