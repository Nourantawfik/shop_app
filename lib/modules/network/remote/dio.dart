
import 'package:dio/dio.dart';

class DioHelper
{

 static late  Dio dio ;

 static init()
 {
   dio = Dio(
     BaseOptions(
       baseUrl: "https://student.valuxapps.com/api/",
       receiveDataWhenStatusError: true ,
     ),

   );}

   static Future<Response> getData({
     required String Url ,
     Map<String , dynamic>? query ,
     String? token ,
     String lang = 'ar' ,
   })
  async {
     dio.options.headers =
         {
           'Content-Type': 'application/json' ,
           "lang" : lang ,
           'Authorization' : token?? " mm " ,
         };
     return await dio.get(Url);
 }


  static Future<Response> PostData({
       Map<String ,dynamic>? query ,
       dynamic  token ,
   String lang = 'ar' ,
       required dynamic Url ,
       required Map<dynamic ,dynamic>? data ,})
   async {
     dio.options.headers =
         {
           "lang" : lang ,
           'Content-Type': 'application/json' ,
           'Authorization' : token?? null ,
         };
                    //path
     return await dio.post(  Url , data: data  ) ;

   }


 static Future<Response> PutData({
   Map<String ,dynamic>? query ,
   dynamic  token ,
   String lang = 'ar' ,
   required dynamic Url ,
   required Map<dynamic ,dynamic>? data ,})
 async {
   dio.options.headers =
   {
     "lang" : lang ,
     'Content-Type': 'application/json' ,
     'Authorization' : token?? null ,
   };
   //path
   return await dio.put(  Url , data: data  ) ;

 }
 }
