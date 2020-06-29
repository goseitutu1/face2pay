import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSliders extends StatelessWidget {
   
  static List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/face_reg.jpg?alt=media&token=e3b0d8be-8933-46c5-ab4b-c3608dd81a02',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/pay-online.png?alt=media&token=814c76ac-94e8-4be1-9f3e-949ecc80e15a',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/2413612.png?alt=media&token=1eacec7c-7652-4bf4-9c74-bfc0056c715f',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/Ecommerce-PNG-File.png?alt=media&token=bfeca453-6c59-4a23-a360-31b7bac41a08',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/warranty-hd-png-today-s-deal-340.png?alt=media&token=93fe54c1-2d14-49a5-a05d-4e7cf35eddae',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/applia.png?alt=media&token=bab908ba-5d5a-48c3-8bc7-0242a2d7c9b3',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/smartphone-xiaomi-phones-transparent-png-10.png?alt=media&token=31be7e8d-89e0-46af-a9d9-ef5abd46d8fe',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/download.jpg?alt=media&token=bec9cd33-30e7-418f-afc5-2f05db950f43',
];
  
  final List<Widget> imageList = imgList.map((item) =>(
        Image.network(item, fit: BoxFit.fill)
  )).toList();

  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 1.9,
          scrollDirection: Axis.horizontal,
          autoPlay: true,
        ),
      items: imageList,
      ),
    );
  }
}


 
//   final List<Widget> imageList = imgList.map((item) => Container(
//   child: Container(
//     margin: EdgeInsets.all(5.0),
//     child: ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(5.0)),
//       child: Stack(
//         children: <Widget>[
//           Image.network(item, fit: BoxFit.cover, width: 1000.0),
//           Positioned(
//             bottom: 0.0,
//             left: 0.0,
//             right: 0.0,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromARGB(200, 0, 0, 0),
//                     Color.fromARGB(0, 0, 0, 0)
//                   ],
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                 ),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Text(
//                 'No. ${imgList.indexOf(item)} image',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       )
//     ),
//   ),
// )).toList();