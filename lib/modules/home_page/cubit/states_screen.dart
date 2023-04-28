
import 'package:shop_pro/models/login_model.dart';
import '../../../models/favorites_model.dart';

abstract class ShopStates{}

 class ShopInitialState extends ShopStates{}

 class ChangeBottomnavBarState extends ShopStates{}

//product_Screen
class ShopLoadingHomeState extends ShopStates{}
class ShopSuccessHomeState extends ShopStates{}
class ShopErrorHomeState extends ShopStates
{
 String error ;
 ShopErrorHomeState(this.error) ;}

 //categories_Screen
 class ShopLoadingCategoriesState extends ShopStates{}
 class ShopSuccessCategoriesState extends ShopStates{}
 class ShopErrorCategoriesState extends ShopStates
 {
 String error ;
 ShopErrorCategoriesState(this.error) ;
}


//favorites_Screen in icon (have or not)
class ShopLoadingFavoritesState extends ShopStates{}
class ShopSuccessFavoritesState extends ShopStates{

  final FavoritesModel favoritesModel ;
  ShopSuccessFavoritesState(this.favoritesModel) ;
}
class ShopErrorFavoritesState extends ShopStates
{
 String error ;
 ShopErrorFavoritesState(this.error) ;
}
class ShopSuccessChangeFavoritesState extends ShopStates{}


//favorites_page
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates
{
 String error ;
 ShopErrorGetFavoritesState(this.error) ;
}


//profile(settingScreen)
class ShopLoadingGetProfileState extends ShopStates{}
class ShopSuccessGetProfileState extends ShopStates{
 final LogInModel loginModel ;
 ShopSuccessGetProfileState(this.loginModel);
}
class ShopErrorGetProfileState extends ShopStates {
 String error;

 ShopErrorGetProfileState(this.error);
}


//updateprofile(settingScreen)
class ShopLoadingUpdateProfileState extends ShopStates{}
class ShopSuccessUpdateProfileState extends ShopStates{
 final LogInModel loginModel ;
 ShopSuccessUpdateProfileState(this.loginModel);
}
class ShopErrorUpdateProfileState extends ShopStates {
 String error;

 ShopErrorUpdateProfileState(this.error);
}


//Dark_Mood
class ShopChangeMoodState extends ShopStates{}


