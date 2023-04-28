 import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/models/login_model.dart';
import 'package:shop_pro/modules/register/register_state.dart';

import '../network/remote/dio.dart';
import '../network/remote/endpoint.dart';

class RegisterCubit extends Cubit<RegisterStates>
 {
   RegisterCubit() : super(RegisterInitialState()) ;

   static RegisterCubit get(context) => BlocProvider.of(context);



   LogInModel? loginModel ;
void userRegister({required String name ,required String email,required String password ,required String phone})
{
  emit(ShopLoadingRegisterState());
  DioHelper.PostData(Url: REGISTER, data: {

    "name": name ,
    "email" : email ,
    "password" : password ,
    "phone" : phone,

  }).then((value) {
loginModel = LogInModel.fromJson(value.data);

    emit(ShopSuccessRegisterState(loginModel));
  }).catchError((error){

    print("register Error is $error");
    emit(ShopErrorRegisterState(error)) ;
  });

}




   IconData? suffix = Icons.visibility ;
   bool? isVisible = true ;

   void ChangePasswordIcon()
   {
     isVisible = ! isVisible! ;

     suffix = isVisible! ? Icons.visibility : Icons.visibility_off ;
     emit(ChangePassword());
   }

 }