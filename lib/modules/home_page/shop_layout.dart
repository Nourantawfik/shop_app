import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/search/search_screen.dart';
import 'cubit/cubit_screen.dart';
import 'cubit/states_screen.dart';



class ShopLayOutScreen extends StatelessWidget {
  const ShopLayOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context , ShopStates state){},
      builder:  (BuildContext context , ShopStates state){

        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar:AppBar(
            title: Text("Salla" , style:Theme.of(context).textTheme.bodyText1,),
            actions: [
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),),);
              }, icon: Icon(Icons.search)) ,
              IconButton(onPressed: () {
                ShopCubit.get(context).changeMood();
              }, icon: Icon(Icons.dark_mode)) ,


            ],
          ),
          body:cubit.Screens[cubit.currentindex] ,
         bottomNavigationBar: BottomNavigationBar(

           items: cubit.Items,
           currentIndex: cubit.currentindex,
           onTap: (index) {cubit.changeBottomNavBar(index);},
         ),



        );
      },

    );
  }
}
