import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_pro/models/categories_model.dart';
import 'package:shop_pro/models/favorites_model.dart';
import 'package:shop_pro/models/getfavorites_model.dart';
import 'package:shop_pro/models/search_model.dart';
import 'package:shop_pro/modules/home_page/cubit/states_screen.dart';
import 'package:shop_pro/modules/network/local/chache_helper.dart';
import 'package:shop_pro/modules/network/remote/dio.dart';
import '../../../models/home_model.dart';
import '../../../models/login_model.dart';
import '../../constant.dart';
import '../../network/remote/endpoint.dart';
import '../../pages/categories_page/categories_screen.dart';
import '../../pages/favorites_page/favorites_screen.dart';
import '../../pages/product_page/product_screen.dart';
import '../../pages/setteings_page/settings_screen.dart';



class ShopCubit extends Cubit<ShopStates> {

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<BottomNavigationBarItem> Items =
  [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'category'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),

  ];

  List<Widget> Screens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),

  ];


//will build favoritesList from productsModel
  Map<int, bool> favorites = {};

  HomeModel? homeModel;

//productScreen
  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(Url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data!.banners![0].image);
      printFullText(homeModel.toString());

      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({element.id!: element.in_favorites!});
      });
      emit(ShopSuccessHomeState());
    }).catchError((error) {
      print("getHomeDataEroor is + $error");
      emit(ShopErrorHomeState(error));
    });
  }

  CategoriesModel? categoriesModel;

//categoriesScreen
  void getCategories({index}) {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(Url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.data!.data![index].id);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print("Categories Error is + $error");
      emit(ShopErrorCategoriesState(error));
    });
  }

  FavoritesModel? favoritesModel;

//favoritesModel(have or not vahe in favo)
  void changeFavorites(int productId) {
    // instance favo botton light
    favorites[productId] = !favorites[productId]!;
    emit(ShopSuccessChangeFavoritesState());

    //this process done in background
    DioHelper.PostData(
      Url: FAVORITES,
      data: {
        "product_id": productId
      },
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel!.message);

      //if status is false in postman  & // instance favo botton light too
      if (!favoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        // to remove item from favoScreen if we press on icon from favoScreen to remove it
        getFavorites();
      }
      emit(ShopSuccessFavoritesState(favoritesModel!));
    }).catchError((error) {
      // if we have error   ايرور كامل
      favorites[productId] = !favorites[productId]!;

      print("favorites Error is + ${error.toString}");
      emit(ShopErrorFavoritesState(error));
    });
  }


  GetFavoritesModel? getFavoritesModel;
//favo_page
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(Url: FAVORITES, token: token).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJso(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print("Get Favo Error is $error");
      emit(ShopErrorGetFavoritesState(error));
    });
  }



  LogInModel? loginModel;
  //profile
  void getProfile() {
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(Url: PROFILE, token: token).then((value) {
      loginModel = LogInModel.fromJson(value.data);

      print(loginModel!.data!.token);

      emit(ShopSuccessGetProfileState(loginModel!));
    }).catchError((error) {
      print("getProfileError is + $error");
      emit(ShopErrorGetProfileState(error));
    });
  }



//updateProfile
  void updateProfile({required String name ,required String email,required String phone})
  {
    emit(ShopLoadingUpdateProfileState());
    DioHelper.PutData(Url: UPDATE_PROFILE,token: token , data:
    {
      "name": name ,
      "email" : email ,
      "phone" : phone,

    }).then((value) {
      loginModel = LogInModel.fromJson(value.data);

      print(loginModel!.data!.token);

      emit(ShopSuccessUpdateProfileState(loginModel!));
    }).catchError((error) {
      print("UpdateProfileEroor is + $error");
      emit(ShopErrorUpdateProfileState(error));
    });
  }


//dark_mood
  bool isDark = true;
  void changeMood({bool? isfromShared})
  {
    if(isfromShared != null)
      {
        isDark = isfromShared ;
        emit(ShopChangeMoodState());
      }else {
      isDark = !isDark ;
      ChaceHelper.saveData(key: "isDark", value: isDark).then((value) {
        emit(ShopChangeMoodState());
      });
    }
  }



  void changeBottomNavBar(int index) {
    currentindex = index;
    emit(ChangeBottomnavBarState());
  }
}
