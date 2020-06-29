class UserContactModel {

  String contact;
  UserContactModel({this.contact});
  UserContactModel.db( Map<String, dynamic> user){
    contact = user['contact'];
  }

  Map<String, dynamic> toMapForDb(){
    return <String, dynamic>{
      'contact': contact,
    };
  }
}
