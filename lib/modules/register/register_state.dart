
import 'package:shop_pro/models/login_model.dart';

abstract class RegisterStates {}
class RegisterInitialState extends RegisterStates {}

class ChangePassword extends RegisterStates{}

class ShopLoadingRegisterState extends RegisterStates{}
class ShopSuccessRegisterState extends RegisterStates{
  final LogInModel? loginModel ;
  ShopSuccessRegisterState(this.loginModel);
}
class ShopErrorRegisterState extends RegisterStates{
  String? error ;
  ShopErrorRegisterState(this.error);

}
