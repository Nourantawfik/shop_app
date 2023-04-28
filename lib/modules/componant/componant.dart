


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/getfavorites_model.dart';
import '../constant.dart';
import '../home_page/cubit/cubit_screen.dart';

//onboardingScreen
NavigteAndFinish(context , widget)
{
  Navigator.pushAndRemoveUntil(
      context,MaterialPageRoute(builder: (context) => widget),(Route <dynamic> route) => false) ;
}

void showToast({required  String text ,required ToastState state })
{
  Fluttertoast.showToast(
    msg: text,
    //state.logInModel.message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0 ,);

}

enum ToastState { SUCCESS , ERROR , WARNING}


Color chooseToastColor(ToastState state)
{

 Color color ;

 switch(state) {
   case ToastState.SUCCESS:
     color = Colors.green;
     break;
   case ToastState.ERROR:
     color = Colors.red;
     break;
   case ToastState.WARNING:
     color = Colors.teal;
     break;
 }
  return color ;


}

Widget MyDivider() =>

  Divider(
    color: Colors.grey,
    height: 1,
    thickness: 1,) ;


//because we use it in tow pages (search , favo screen)
//getDataModel model
Widget buildListProduct(model , context , index ,{ bool old_price = true}) =>

    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
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
                if (model.discount!.round() != 0 && old_price)
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

                      if (model.discount!.round() != 0 && old_price)
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
      ),
    );