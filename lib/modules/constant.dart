


import 'package:flutter/material.dart';
import 'package:shop_pro/modules/componant/componant.dart';
import 'package:shop_pro/modules/network/local/chache_helper.dart';

import 'login_page/login_screen.dart';

const defaultColor = Colors.teal ;

String token = ' ' ;


void signOut(context)
{

  ChaceHelper.removeData(key:"token").then((value) {
    if(value)
      {
        NavigteAndFinish(context, LogInScreen()) ;
      }

  });

}
void printFullText(String text)
{

  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match)=> print ( match.group(0)));
}
