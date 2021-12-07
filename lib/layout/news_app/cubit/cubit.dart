import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/news_app/buisness/business_screen.dart';
import 'package:news_app/modules/news_app/science/science_screen.dart';
import 'package:news_app/modules/news_app/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialStates());
  
  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomsItems=[
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'science',
    ),

  ];
  List<Widget>screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex=index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business =[];
  List<dynamic> sports =[];
  List<dynamic> science =[];
  List<dynamic> search=[];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingStates());

    if(business.length==0){

      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'business',
          'apiKey':'0cd8809a19f743849546d5ce34110c3a',
        },
      ).then((value)
      {
        business=value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }else{
      emit(NewsGetBusinessSuccessState());
    }

  }


  void getSports()
  {
    emit(NewsGetSportsLoadingStates());
    if(sports.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'sports',
          'apiKey':'0cd8809a19f743849546d5ce34110c3a',
        },
      ).then((value)
      {
        sports=value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }


  void getScience()
  {
    emit(NewsGetScienceLoadingStates());
    if(science.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'science',
          'apiKey':'0cd8809a19f743849546d5ce34110c3a',
        },
      ).then((value)
      {
        science=value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingStates());

      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'from':'2021-10-29',
          'sortBy':'publishedAt',
          'apiKey':'0cd8809a19f743849546d5ce34110c3a',
        },
      ).then((value)
      {
        search=value.data['articles'];
        print(search[0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });


  }


}