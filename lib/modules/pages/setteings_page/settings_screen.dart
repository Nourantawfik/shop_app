import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/modules/constant.dart';
import 'package:shop_pro/modules/home_page/cubit/cubit_screen.dart';
import 'package:shop_pro/modules/home_page/cubit/states_screen.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (BuildContext context , ShopStates state){},
      builder: (BuildContext context , ShopStates state){

        nameController.text = ShopCubit.get(context).loginModel!.data!.name! ;
        emailController.text = ShopCubit.get(context).loginModel!.data!.email!;
        phoneController.text = ShopCubit.get(context).loginModel!.data!.phone! ;

        return  ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel != null ,
          builder:(BuildContext context) =>
             Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateProfileState)
                        LinearProgressIndicator(),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon:Icon(Icons.person) ,
                          labelText: "Name" ,
                          hintText: "enter your name" ,
                        ),
                      ),
                      SizedBox(height: 10,),

                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon:Icon(Icons.email) ,
                          labelText: "email" ,
                          hintText: "enter your email" ,
                        ),
                      ),
                      SizedBox(height: 10,),

                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          prefixIcon:Icon(Icons.phone) ,
                          labelText: "phone" ,
                          hintText: "enter your phone" ,
                        ),
                      ),
                      SizedBox(height:10),
                      MaterialButton(onPressed: (){
                        signOut(context) ;

                      },child: Text("LogOut" , style: TextStyle(color: Colors.white),), ),
                      SizedBox(height: 10,),

                      //Text("data"),

                      SizedBox(height: 10,),

                      MaterialButton(onPressed: (){
                        if(formkey.currentState!.validate())
                          {
                            ShopCubit.get(context).updateProfile(
                                name: nameController.text , email: emailController.text , phone: phoneController.text
                            );
                          }

                      },child: Text("Update" , style: TextStyle(color: Colors.white),), ),
                      SizedBox(height: 10,),
                      Text("data"),

                    ],
                  ),
                ),
              ),
            ),

          fallback:(BuildContext context) => Center(child: CircularProgressIndicator()),
        );

      },

    );
  }
}