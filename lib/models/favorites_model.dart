class FavoritesModel
{
bool? status ;
String? message ;
FavoritesDataModel?  data ;

  FavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'] ;
    data = FavoritesDataModel.fromJson(json['data']) ;


  }
}

class FavoritesDataModel
{
 int? id ;
List<FavoritesProductModel>? products = [] ;

 FavoritesDataModel.fromJson(Map<dynamic , dynamic> json)
 {
   id = json['id'] ;
   json['products'].forEach((element)
   {
     products!.add(FavoritesProductModel.fromJson(element)) ;

   });

 }
}


class FavoritesProductModel
{
  int ? id ;
  double ? price ;
  double ? old_price ;
  double ? discount ;
  String? image ;

  FavoritesProductModel.fromJson(Map<dynamic , dynamic> json)
  {
    id = json['id'] ;
    price = json['price'] ;
    old_price = json['old_price'] ;
    discount = json['discount'] ;
    image = json['image'] ;
  }
}



