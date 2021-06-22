import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_app/layout/social_layout/cubit/cubit.dart';
import 'package:flutter_app/layout/social_layout/social_layout.dart';
import 'package:flutter_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:flutter_app/shared/bloc_observer.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_app/shared/cubit/cubit.dart';
import 'package:flutter_app/shared/cubit/states.dart';
import 'package:flutter_app/shared/network/local/cache_helper.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_app/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/news_app/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  //bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  //token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');
  if(uId != null){
    widget = SocialLayout();
  }
  else{
    widget = SocialLoginScreen();
  }


  // if(onBoarding != null){
  //   if(token != null)widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // }else{
  //   widget = OnBoardingScreen();
  // }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()..getBusiness(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()..getUsers(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            // themeMode:
            //     AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
