class GetFavoritesModel
{
  bool? status ;
  GetFavoritesDataModel  ?  data ;

   GetFavoritesModel.fromJso(Map<String , dynamic> json)
   {
     status = json['status'];
     data =GetFavoritesDataModel.fromJso(json['data']);
   }
   }

   class GetFavoritesDataModel
  {
    int? current_page ;
    List<getDataModel> data = [] ;
 String? first_page_url ;
 int? from;
 int? last_page;
 String?  last_page_url ;
 String?  next_page_url;
  String?  path;
 int? per_page;

  GetFavoritesDataModel.fromJso(Map<String , dynamic> json)
  {
    current_page = json['current_page'];
  json['data'].forEach((element)
  {
    data.add(getDataModel.fromJson(element)) ;
  });
    first_page_url = json['first_page_url'];
    from = json['from'];
    last_page = json['last_page'];
    last_page_url = json['last_page_url'];
    last_page_url = json['last_page_url'];
    next_page_url = json['next_page_url'];
    path = json['path'];
    per_page = json['per_page'];

  }

  }

class getDataModel
{
  int? id;
  List<Product> products = [];

  getDataModel.fromJson(Map<String , dynamic> json)
  {
    id = json['id'] ;
    json['products'].forEach((element)
    {
      products.add(Product.fromJson(element));
    });
  }
}

class Product
{
 int? id;
dynamic?  price;
 dynamic? old_price;
 dynamic? discount;
String?  image;
 String? name;
 String? description;
 Product.fromJson(Map<String , dynamic> json)
 {
   id = json['id'] ;
   price = json['price'] ;
   old_price = json['old_price'] ;
   discount = json['discount'] ;
   image = json['image'] ;
   name = json['name'] ;
   description = json['description'] ;
 }


}
