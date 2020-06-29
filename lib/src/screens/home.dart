import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/carousel_slider_images.dart';
import '../widgets/material_button.dart';
import '../blocs/home_bloc.dart';
import '../blocs/account_bloc.dart';
import '../models/home.dart';
import '../widgets/notification.dart';

class Home extends StatelessWidget {

  Widget build(BuildContext context) {
    Future<String> _user = homeBloc.getUser(); 
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          NotificationButton(),
        ],
        title: Text('HOME',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
       drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              decoration: BoxDecoration(
                color: Color(0xFFEB1555),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('face2pay',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Pacifico',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: _user,
                    builder: (context, AsyncSnapshot<String> snapshot){
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: accountBloc.image == null ? null : FileImage(accountBloc.image),
                        ),
                        title: Text('${snapshot.data}',style: TextStyle(color: Colors.black)),
                      );
                    }
                  ),
                ]
              ),
            ),
            ListTile(
              leading: Icon(Icons.perm_identity,color: Colors.black),
              title: Text('Account',style: TextStyle(color: Colors.black)),
              onTap: () {Navigator.pushNamed(context, '/account');},
            ),
            ListTile(
              leading: Icon(Icons.list,color: Colors.black),
              title: Text('Categories',style: TextStyle(color: Colors.black)),
              onTap: () {Navigator.pushNamed(context, '/categories');},
            ),
            ListTile(
              leading: Icon(Icons.people,color: Colors.black),
              title: Text('Follow Developers',style: TextStyle(color: Colors.black)),
            ),
            ListTile(
              leading: Icon(Icons.share,color: Colors.black),
              title: Text('Share'),
            ),
            ListTile(
              onTap: () async{
                final _logOut = FirebaseAuth.instance;
                await _logOut.signOut();
                Navigator.pushNamed(context, '/');
              },
              leading: Icon(Icons.exit_to_app,color: Colors.black),
              title: Text('Log out',style: TextStyle(color: Colors.black)),
            ),
          ]
        ),
      ),
      body: Card(
        color: Colors.white,
        elevation: 5.0,
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0), 
        child: ListView(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          children: <Widget>[
            ImageSliders(),
            SizedBox(height: 20.0),
            Divider(thickness: 1.0),
            _gridTile(context),
            SizedBox(height: 10.0),
            Divider(thickness: 1.0),
            _subscriberTile(context),
            Divider(thickness: 1.0),
            _whatNewTile(context),
            Divider(thickness: 1.0),
            _questionTile(context),
            Divider(thickness: 1.0),
            _appReviewTile(context),
            Divider(thickness: 1.0,),
            Button(
              description: 'Submit',
              onPressed: (){
                print(homeBloc.getReview());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridTile(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250.0,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: StreamBuilder(
        stream: homeBloc.outStream,
        builder: (context, AsyncSnapshot<List<HomeModel>> snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return GridView.builder(
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
            ), 
            itemBuilder: (context, int index){
              return ListTile(
                onTap: (){Navigator.pushNamed(context,'/categories');},
                 title: 
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  child: Image.network('${snapshot.data[index].imageURL}'),
                  ),
                subtitle: Text('${snapshot.data[index].title}',textAlign: TextAlign.center),
              );
            }
          );
        }
      ),
    );
  }

  Widget _subscriberTile(BuildContext context){
    return ListTile(
      leading: Icon(Icons.subscriptions,color: Colors.red),
      title: Text(
        'Become a subscriber?',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
      subtitle: Text('Get free updates on the latest products and discounts, straight to your in box'),
      trailing: Icon(Icons.send,color: Colors.red),
    );
  }

  Widget _whatNewTile(BuildContext context){
    return ListTile(
      onTap: (){Navigator.pushNamed(context, '/categories');},
      leading: Image(image: AssetImage('images/iphone.png')),
      title: Text(
        "What's new?",
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
      subtitle: Text('\$732.56 Apple iPhone 11 pro.'),
      trailing: Icon(Icons.send,color: Colors.red),
    );
  }

  Widget _questionTile(BuildContext context){
    return ListTile(
      leading: Icon(Icons.help_outline),
      title: Text(
        'FAQs',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(Icons.send,color: Colors.red),
    );
  } 

  Widget _appReviewTile(BuildContext context){
    return StreamBuilder(
      stream: homeBloc.appViewStream,
      builder: (context, AsyncSnapshot<String> snapshot){
        return  ListTile(
          leading: Icon(Icons.comment),
          title : TextField(   
            onChanged: homeBloc.appViewInStream, 
            keyboardType : TextInputType.multiline,    
            maxLines : 5,    
            decoration : InputDecoration(
              hintText : "Review app",
              hintStyle: TextStyle(fontSize: 20.0),
            ),  
          ),
        );
      }
    );
  }
}