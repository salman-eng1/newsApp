import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/shared/bloc_observe.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/thems.dart';
import 'layout/news_app/cubit/cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark=CacheHelper.getData(key: 'isDark');

  BlocOverrides.runZoned(
        () {
          runApp(MyApp(isDark: isDark,));
        },
    blocObserver: MyBlocObserver(),
  );

}


class MyApp extends StatelessWidget{

  final bool? isDark;
  MyApp({this.isDark});
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create: (context)=>AppCubit()..changeAppMode(fromShared:isDark),),

    ],
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark ? ThemeMode.light:ThemeMode.dark,
              home:NewsLayout(),
            );
          },
        ),
      );
  }

}
