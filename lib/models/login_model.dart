
class LogInModel
{
  bool? status ;
  String? message ;
  UserData?  data ;

  LogInModel.fromJson(Map<dynamic ,dynamic> json)
  {
    status = json['status'] ;
    message = json['message'] ;
    data = json['data'] != null ? UserData.fromJson(json['data']) : null ;

  }

}

class UserData
{
  int? id ;
  String? name ;
  String? email ;
  String? password ;
  String? phone ;
  String? image ;
  int? points ;
  int? credit ;
  dynamic? token ;

  UserData.fromJson(Map<dynamic,dynamic>json)
  {
    id = json['id'] ;
    name = json["name"] ;
    email = json["email"] ;
    password = json["password"] ;
    phone = json["phone"] ;
    image = json["image"] ;
    points = json["points"] ;
    credit = json["credit"] ;
    token = json["token"] ;
  }
}