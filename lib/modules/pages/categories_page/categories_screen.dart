import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/modules/home_page/cubit/cubit_screen.dart';
import 'package:shop_pro/modules/home_page/cubit/states_screen.dart';

import '../../../models/categories_model.dart';
import '../../componant/componant.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (BuildContext context , ShopStates state){},
      builder: (BuildContext context , ShopStates state){

        return ListView.separated(
          itemBuilder: (BuildContext context , index) =>buildCategoriesItemScreen(ShopCubit.get(context).categoriesModel!.data!.data![index]),
          separatorBuilder: (BuildContext context , index) => MyDivider() ,
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length ,
        );
      },

    );
  }


  Widget buildCategoriesItemScreen(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap:( (){}),
      child: Row(
        children: [
          Image(image: NetworkImage('${model.image}'), height: 80, width: 80, fit: BoxFit.cover,),
          SizedBox(width: 20,) ,
          Text('${model.name}' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),

          Spacer(),
          Icon(Icons.arrow_forward_ios_outlined) ,

        ],
      ),
    ),
  );
}