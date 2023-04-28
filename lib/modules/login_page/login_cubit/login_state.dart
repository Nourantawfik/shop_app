
 import 'package:shop_pro/models/login_model.dart';

abstract class LogInStates {}

 class InintialLogInState extends LogInStates {}

 class LogInLoadingState extends LogInStates {}

 class SuccessfllyLogInState extends LogInStates {
 // send this because token is null & going to loginHomePage in listen too
  LogInModel? logInModel ;
  SuccessfllyLogInState(this.logInModel);


 }

 class ErrorLogInState extends LogInStates {
  String error ;
  ErrorLogInState(this.error) ;

 }


 class ChangePasswordIconState extends LogInStates{}


