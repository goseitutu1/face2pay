import '../models/home.dart';

class HomeProvider {

List<HomeModel> buildGridTile(List<String> _imageList, List<String> _titleList){
  List<HomeModel> tempList = [];
  for(var i = 0; i < _imageList.length; i++){
    HomeModel _homeModel = HomeModel(imageURL: _imageList[i], title: _titleList[i]);
    tempList.add(_homeModel);
  }

  return tempList;
}

}