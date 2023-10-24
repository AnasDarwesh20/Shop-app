import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/network/API/dio_helper.dart';
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:shop_app/shop_app/login/login_shop_app.dart';
import 'package:shop_app/shop_app/on_boarding/on_boarding.dart';
import 'package:shop_app/shop_layout/cubit/cubit.dart';
import 'package:shop_app/shop_layout/cubit/states.dart';
import 'package:shop_app/shop_layout/shop_home.dart';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized() ;

  print(token.toString()) ;
  Bloc.observer = MyBlocObserver();
  // HttpOverrides.global = MyHttpOverrides();

  DioHelper.init() ;

  await CacheHelper.init() ;

  bool isDark = CacheHelper.getData(key: 'isDark') ;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ;

  token = CacheHelper.getData(key: 'token') ;

  uId = CacheHelper.getData(key: 'uId') ;

  Widget widget ;

  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout() ;
    else widget = ShopLoginScreen() ;
  }
  else
  {
    widget = OnBoardingScreen() ;
  }


  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}
class MyApp extends StatelessWidget
{
  final bool isDark ;
  final Widget startWidget ;
  MyApp({
    this.isDark,
    this.startWidget
  }) ;
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopAppCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context , state) {},
        builder : (context , state)
        {
          return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false ,
              home: startWidget
          ) ;
        },
      ),
    ) ;
  }
}


