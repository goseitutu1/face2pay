class UserNameModel {
 
  UserNameModel({this.username});

  String username;
  UserNameModel.db(Map<String, dynamic> user){
    username = user['username'];
  }

  Map<String, dynamic> toMapForDb(){
    return <String, dynamic>{
      'username': username,
    };
  }
}

