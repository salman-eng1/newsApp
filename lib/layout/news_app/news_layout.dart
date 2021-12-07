
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/news_app/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';
class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit =NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('NewsApp'),
              actions: [
                IconButton(
                    onPressed: (){
                  navigateTo(context,SearchScreen());
                }, icon: Icon(Icons.search)),
                IconButton(
                    onPressed: (){
                  AppCubit.get(context).changeAppMode();
                }, icon: Icon(Icons.dark_mode)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomsItems,
            ),
          );
        },
      );

  }
}
