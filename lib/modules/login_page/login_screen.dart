import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/modules/login_page/login_cubit/login_cubit.dart';
import 'package:shop_pro/modules/login_page/login_cubit/login_state.dart';
import 'package:shop_pro/modules/network/local/chache_helper.dart';
import 'package:shop_pro/modules/register/register_screen.dart';
import '../componant/componant.dart';
import '../constant.dart';
import '../home_page/shop_layout.dart';



class LogInScreen extends StatelessWidget {

   var emailController = TextEditingController() ;
   var passwordController = TextEditingController() ;
   var formkey = GlobalKey<FormState>() ;
 bool  isvisible = true ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LogInCubit(),
      child: BlocConsumer<LogInCubit , LogInStates>(
        listener: (BuildContext context , LogInStates state){

          if(state is SuccessfllyLogInState)

            {
             if(state.logInModel!.status!)
               {
                 print('message is +${state.logInModel!.message}') ;
                 print('token is + ${state.logInModel!.data!.token!}');

                 showToast(text: state.logInModel!.message!, state: ToastState.SUCCESS);

                 ChaceHelper.saveData(key: "token", value: state.logInModel!.data!.token)
                 .then((value) {
                   // if user logout the token be still saved
                   token = state.logInModel!.data!.token! ;
                   NavigteAndFinish(context, ShopLayOutScreen());

                 }) ;

               }
             else
               {
                 print('message is +${state.logInModel!.message}') ;
                 showToast(text: state.logInModel!.message!, state: ToastState.ERROR);
               }

            }

        },
        builder: (BuildContext context , LogInStates state){

       var cubit = LogInCubit.get(context) ;

          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),

            body:
               Center(
                 child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Form(
                        key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Log In' ,style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 18
                              ),) ,

                              SizedBox(height: 10,),

                              Text("login now to browse our hot offers",style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),) ,

                              TextFormField(
                                  keyboardType: TextInputType.emailAddress ,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Email" ,
                                  labelText: " Your Email" ,
                                ),
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty)
                                  {
                                    return "email must not be empty" ;
                                  }

                                },
                              ),
                              SizedBox(height: 20,),
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),


                                  suffixIcon: IconButton(
                                      onPressed:() {
                                    cubit.changePassword() ;

                                  } , icon : Icon(cubit.suffix)),

                                  hintText: "Password" ,
                                  labelText: " Your Password" ,
                                ),
                                validator: (value){
                                  if (value!.isEmpty )
                                  {
                                    return " password must not be empty" ;
                                  }
                                },
                                obscureText: cubit.isvisible ,
                                controller: passwordController,
                              ),
                              SizedBox(height: 20,),

                              ConditionalBuilder(
                                condition: state is ! LogInLoadingState,
                                builder: (BuildContext context ) =>Container(
                                  color: Colors.blue,

                                  child: Center(
                                    child: MaterialButton(onPressed: () {
                                      if (formkey.currentState!.validate())
                                      {
                                        cubit.userLogin(emailController.text, passwordController.text);
                                       // NavigateAndFinish(context , ShopLayOut());
                                      }

                                    } , child: Text('LogIn', style: Theme.of(context).textTheme.bodyText1!.copyWith(

                                        color: Colors.white
                                    ),),),
                                  ),
                                ),
                                fallback: (BuildContext context) => Center(child: CircularProgressIndicator()) ,

                              ),
                              SizedBox(height:20),

                              Center(
                                child: Row(
                                  children: [

                                    Text('Don\'t have an account?' ,style: Theme.of(context).textTheme.caption,) ,
                                    SizedBox(width: 25,),

                                    Container(
                                      color: Colors.blue,

                                      child: TextButton(onPressed: () {

                                          Navigator.push(context,MaterialPageRoute(builder: ( context) => RegisterScreen(),),);

                                      } , child: Text('Register', style: Theme.of(context).textTheme.bodyText1!.copyWith(

                                          color: Colors.white
                                      ),),),
                                    ),




                                  ],
                                ),
                              ),

                            ],
                          ),

                      ),
                    ),
                  ),
               ),



          );
        },

      ),
    );
  }
}
