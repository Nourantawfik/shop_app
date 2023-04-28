import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/models/favorites_model.dart';
import 'package:shop_pro/modules/componant/componant.dart';
import 'package:shop_pro/modules/home_page/cubit/states_screen.dart';

import '../../../models/getfavorites_model.dart';
import '../../../models/home_model.dart';
import '../../constant.dart';
import '../../home_page/cubit/cubit_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopCubit.get(context);
        return

          ConditionalBuilder(
            // as the mode is not empty even if we press unlike to remove item so here we can playing on state
            condition: state is! ShopLoadingGetFavoritesState,
            builder: (BuildContext context) =>
                ListView.separated(
                  itemBuilder: (BuildContext context, index) =>
                      buildListProduct(

                        cubit.getFavoritesModel!.data!.data[index], context,
                        index,
                      ),
                  separatorBuilder: (BuildContext context, index) =>
                      MyDivider(),
                  itemCount: cubit.getFavoritesModel!.data!.data.length,
                ),
            fallback: (BuildContext context) =>
                Center(child: CircularProgressIndicator()),

          );
      },
    );
  }
}