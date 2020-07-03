class CategoriesModel extends Object {
  String id;
  String name;
  String childName1;
  String childName2;
  String imageURL1;
  String imageURL2;

  CategoriesModel.fromFirestore(Map<String,dynamic> json){
    name = json['name'];
    childName1 = json['childName1'];
    childName2 = json['childName2'];
    imageURL1 = json['imageURL1'];
    imageURL2 = json['imageURL2'];
  }

  CategoriesModel({this.name});
}