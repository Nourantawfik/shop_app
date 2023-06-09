import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/modules/home_page/shop_layout.dart';
import 'package:shop_pro/modules/network/local/chache_helper.dart';
import 'package:shop_pro/modules/register/register_cubit.dart';
import 'package:shop_pro/modules/register/register_state.dart';
import '../componant/componant.dart';
import '../constant.dart';
import '../login_page/login_screen.dart';

class RegisterScreen extends StatelessWidget {

  var nameController = TextEditingController() ;
  var emailController = TextEditingController() ;
  var passwordController = TextEditingController() ;
  var phoneController = TextEditingController() ;


  var formkey = GlobalKey<FormState>() ;


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit , RegisterStates>(
        listener: (BuildContext context , RegisterStates state){
          if (state is ShopSuccessRegisterState)
            {
              if(state.loginModel!.status!)
                {
                  showToast(text: state.loginModel!.message!, state: ToastState.SUCCESS);
                  print(state.loginModel!.message);
                  print(state.loginModel!.data!.token);
                  ChaceHelper.saveData(key: "token", value: state.loginModel!.data!.token).then((value) {
                    token = state.loginModel!.data!.token;
                    NavigteAndFinish(context, ShopLayOutScreen());
                  });
                }else
                  {
                    showToast(text: state.loginModel!.message!, state: ToastState.ERROR);
                    print(state.loginModel!.message);
                  }
            }

        },
        builder: (BuildContext context , RegisterStates state){

          var cubit = RegisterCubit.get(context) ;

          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),

            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register' ,style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18
                        ),) ,

                        SizedBox(height: 10,),

                        Text("Register now to browse our hot offers",style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),) ,

                        SizedBox(height: 20,),

                        TextFormField(
                          keyboardType: TextInputType.name ,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Name" ,
                            labelText: " Your Name" ,
                          ),
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty)
                            {
                              return "name must not be empty" ;
                            }

                          },
                        ),
                        SizedBox(height: 20,),


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
                          keyboardType: TextInputType.visiblePassword ,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),

                            suffixIcon: IconButton(
                                onPressed:() {
                                  cubit.ChangePasswordIcon() ;

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
                          obscureText: cubit.isVisible! ,
                          controller: passwordController,
                        ),
                        SizedBox(height: 20,),

                        TextFormField(
                          keyboardType: TextInputType.phone ,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Phone" ,
                            labelText: " Your Phone" ,
                          ),
                          controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty)
                            {
                              return "Phone must not be empty" ;
                            }

                          },
                        ),
                        SizedBox(height: 25,),

                        Container(
                          color: Colors.blue,
                          child: Center(
                            child: ConditionalBuilder(
                              condition:  state is! ShopLoadingRegisterState,
                              builder: (BuildContext context) =>
                                  MaterialButton(onPressed: () {
                                    if (formkey.currentState!.validate())
                                    {
                                      RegisterCubit.get(context).userRegister(

                                          name: nameController.text, email: emailController.text,
                                          password: passwordController.text, phone: phoneController.text) ;

                                      NavigteAndFinish(context , ShopLayOutScreen());
                                    }
                                  } ,
                                    child: Text('Register', style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white
                                  ),),),
                              fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),

                            ),
                          ),
                        ),
                        SizedBox(height: 25,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text('Already have an account?' ,style: Theme.of(context).textTheme.caption,) ,
                            SizedBox(width: 25,),
                            Container(
                              color: Colors.blue,
                              child:  TextButton
                                (onPressed: () {
                                  Navigator.push(context,MaterialPageRoute(builder: ( context) => LogInScreen(),),);

                              } , child: Text('Log In', style: Theme.of(context).textTheme.bodyText1!.copyWith(

                                  color: Colors.white
                              ),),),
                            ),




                          ],
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

