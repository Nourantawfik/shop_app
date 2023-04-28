
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/models/login_model.dart';
import 'package:shop_pro/modules/login_page/login_cubit/login_state.dart';
import 'package:shop_pro/modules/network/remote/dio.dart';
import '../../network/remote/endpoint.dart';


class LogInCubit extends Cubit<LogInStates> {

 LogInCubit() : super(InintialLogInState());

  static LogInCubit get(context) => BlocProvider.of(context) ;

  LogInModel? loginModel ;

  void userLogin(String email , String password)
  {
   emit(LogInLoadingState());

   DioHelper.PostData(
       Url:LOGIN,
       //body in postMan
       data: {
        "email" : email ,
        "password" : password ,
       } ,

   ).then((value) {

    loginModel = LogInModel.fromJson(value.data);
    print(loginModel!.data!.token);
    print(loginModel!.data!.name);


    emit(SuccessfllyLogInState(loginModel));
   }).catchError((error){
    print("Login error is + $error");
    emit(ErrorLogInState(error)) ;
   });
  }

  IconData? suffix = Icons.visibility ;
  bool isvisible = true ;

 void changePassword()
 {
  isvisible = !isvisible ;
  suffix = isvisible? Icons.visibility_off: Icons.visibility ;

  emit(ChangePasswordIconState());

 }








}