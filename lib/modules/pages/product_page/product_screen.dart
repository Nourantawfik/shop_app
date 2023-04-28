import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/modules/componant/componant.dart';
import 'package:shop_pro/modules/home_page/cubit/cubit_screen.dart';
import '../../../models/categories_model.dart';
import '../../../models/home_model.dart';
import '../../constant.dart';
import '../../home_page/cubit/states_screen.dart';
import '../../home_page/cubit/states_screen.dart';
import '../../home_page/cubit/states_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {

        if(state is ShopSuccessFavoritesState)
          {
            if(!(state.favoritesModel.status!))

            {showToast(text: state.favoritesModel.message!, state: ToastState.ERROR) ;}
          }

      },
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (BuildContext context) => BroductsBuilder(
              cubit.homeModel!, context, cubit.categoriesModel!,),
          fallback: (BuildContext context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget BroductsBuilder( HomeModel model, context, CategoriesModel categoriesModel, ) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                // to return list<Widget>
                // e is numbers of bunners
                items: model.data!.banners!
                    .map(
                      (e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),

                options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  viewportFraction: 0.1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CATEGORIES',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 10),

                    //size it  نحجمها
                    Container(
                      height: 100,
                      child: ListView.separated(
                        shrinkWrap:  true,
                        scrollDirection: Axis.horizontal,
                        physics:BouncingScrollPhysics(),

                        itemBuilder: (BuildContext, index) =>
                            buildCategories(categoriesModel.data!.data![index]),
                        separatorBuilder: (BuildContext, index) => SizedBox(width: 5),
                        itemCount: categoriesModel.data!.data!.length,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'PRODUCTS',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  // this two commands to make the page scroll with SingleChilScroll on Column
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  crossAxisCount: 2,

                  //this to prevent error overflow => width/height & to write below the pic it's info
                  childAspectRatio: 1 / 1.59,

                  //  this two commands  to make space between them
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,

                  children: List<Widget>.generate(
                    model.data!.products!.length,
                    (index) =>
                        buildGridProduct(model.data!.products![index], context),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

//product
  Widget buildGridProduct(ProductsModel model, context) => Container(
        //to change B.G color
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    "${model.image}",
                  ),
                  width: double.infinity,
                  height: 250,
                ),
                if (model.discount!.round() != 0)
                  Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14, height: 1.1),
                  ),
                  Row(
                    children: [
                      //to invert price into int
                      Text(
                        '${model.price!.round()} ',
                        style: TextStyle(fontSize: 12, color: defaultColor),
                      ),
                      //Text('\$') ,

                      SizedBox(
                        width: 10,
                      ),

                      if (model.discount!.round() != 0)
                        Text(
                          '${model.old_price!.round()}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[300],
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),

                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!) ;
                          print(model.id) ;
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                          radius: 15,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  //categories (below carousal)
  //  نستقبل الداتا فى شكل الموديل بتاعها
  Widget buildCategories(DataModel model) =>

      Container(
        width: 100,
        height: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage("${model.image}"),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Container(
                color: Colors.black.withOpacity(0.6),
                width: double.infinity,
                child: Text('${model.name}',textAlign:TextAlign.center ,
                  style: TextStyle(color: Colors.white,) ,overflow: TextOverflow.ellipsis, maxLines: 1 ,)),
          ],
        ),
      );
}
