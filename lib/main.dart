
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/modules/home_page/cubit/cubit_screen.dart';
import 'package:shop_pro/modules/login_page/login_cubit/login_cubit.dart';
import 'package:shop_pro/modules/login_page/login_screen.dart';
import 'package:shop_pro/modules/network/local/chache_helper.dart';
import 'package:shop_pro/modules/network/remote/dio.dart';
import 'package:shop_pro/modules/themedata_screen.dart';
import 'modules/home_page/shop_layout.dart';
import 'modules/onbording_page/onboarding_screen.dart';
import 'modules/pages/favorites_page/favorites_screen.dart';
import 'modules/pages/product_page/product_screen.dart';


bool isDark =  false;

void main(context)  async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await ChaceHelper.init();


  bool isDark = ChaceHelper.getData('isDark')?? false;

  Widget widget;
  var token = ChaceHelper.getData('token') ??
      null; //'Tt7n0eaDC01MvP1VNpjZMe4Yo742mhSSvVfmOyRJOOL94YS0m2USHKIhYCoXANIFQAUKVM';
  // LogInCubit.get(context).loginModel!.data!.token! ;
  print(" token is + $token");

  bool onBoarding = ChaceHelper.getData('onBoarding') ?? true;
  print(onBoarding);


  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayOutScreen();
    }
    else {
      widget = LogInScreen();
    }
  }
  else {
    widget = OnBordingScreen();
  }


  runApp(MyApp(widget, isDark)) ;
}

class MyApp extends StatelessWidget {
   final Widget startWidget ;
  final bool isDark ;
  MyApp(this.startWidget , this.isDark) ;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
       providers: [
         BlocProvider(create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getProfile()..changeMood(isfromShared: isDark),),
       ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode:ShopCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

        home: FavoritesScreen(),
        //ProductsScreen(),

        //ShopLayOutScreen(),
       // startWidget,
        //LogInScreen(),
       // OnBordingScreen() ,
      ),
    );
  }
}
