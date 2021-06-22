import 'package:flutter/material.dart';
import 'package:flutter_app/layout/news_app/cubit/states.dart';
import 'package:flutter_app/modules/news_app/business/business_screen.dart';
import 'package:flutter_app/modules/news_app/science/science_screen.dart';
import 'package:flutter_app/modules/news_app/sports/sports_screen.dart';

import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List <BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: "Science",
    ),
  ];

  List <Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    if(currentIndex == 1)
      getSports();
    if(currentIndex == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  List <dynamic> business = [];

  void getBusiness (){
    emit(NewsBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category' : 'business',
        'apiKey': '8dea888a9ffe49a3a1a59392e53233a3',
      },
    ).then((value){
      business = value.data['articles'];
      //print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print("Error ${error.toString()}");
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List <dynamic> sports = [];

  void getSports (){
    emit(NewsSportsLoadingState());

    if(sports.length == 0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category' : 'sports',
          'apiKey': '8dea888a9ffe49a3a1a59392e53233a3',
        },
      ).then((value){
        sports = value.data['articles'];
        //print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print("Error ${error.toString()}");
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List <dynamic> science = [];

  void getScience (){
    emit(NewsScienceLoadingState());

    if(science.length == 0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category' : 'science',
          'apiKey': '8dea888a9ffe49a3a1a59392e53233a3',
        },
      ).then((value){
        science = value.data['articles'];
        //print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print("Error ${error.toString()}");
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetScienceSuccessState());
    }
  }

  List <dynamic> search = [];

  void getSearch (String value){
    emit(NewsSearchLoadingState());
    search = [];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q' : '$value',
        'apiKey': '8dea888a9ffe49a3a1a59392e53233a3',
      },
    ).then((value){
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print("Error ${error.toString()}");
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}


