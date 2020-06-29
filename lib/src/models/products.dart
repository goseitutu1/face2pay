class ProductsModel extends Object {
  String id;
  String name;
  double price;
  String description;
  String imageURL;
  int itemCount = 0;
  
  ProductsModel();
  ProductsModel.fromFirestore(Map<String,dynamic> json){
    name = json['name'];
    price = json['price'];
    description = json['description'];
    imageURL = json['imageURL'];
  }

  @override
  bool operator ==(o) => o is ProductsModel && o.id == id && o.name == name && o.price == price && o.description == description && o.imageURL == imageURL && o.itemCount == itemCount;
  
  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode ^ description.hashCode ^ imageURL.hashCode ^ itemCount.hashCode;

}
