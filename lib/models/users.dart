class Users{
  String name ,pass,email,userType,userId,pic,userPhone;
  Users({this.name,this.pass,this.email,this.userType,this.userId,this.pic,this.userPhone});



Users.fromJson(Map<dynamic,dynamic>map){
  if(map==null){
    return;
  }
  name = map['name'];
  pass=map['pass'];
  email = map['email'];
  userId = map['userId'];
  pic = map['pic'];

}
toJson(){
  return {
    'name': name,
    'pass':pass,
    'email': email,
    'userId': userId,
    'pic': pic,

  };

}
}



