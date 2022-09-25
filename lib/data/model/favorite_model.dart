class FavoriteModelPost{
  late bool status;
  late String message;

  FavoriteModelPost.fromJson(Map<String,dynamic> json){

    status = json['status'];
    message = json['message'];

  }



}