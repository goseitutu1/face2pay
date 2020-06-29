import 'package:flutter/material.dart';
import '../blocs/checkout_bloc.dart';

class NotificationButton extends StatelessWidget {

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          onPressed: (){Navigator.pushNamed(context, '/transaction');},
          icon: Icon(Icons.notifications),
        ),
        Positioned(
          top: 5.0,
          right: 5.0,
          child: CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.red,
            child: StreamBuilder(
              stream: checkoutBloc.notificationCount,
              initialData: 0,
              builder: (context, AsyncSnapshot<int> snapshot) {
                return Text('${snapshot.data}', style: TextStyle(fontSize: 12.0));
              }
            ),
          ),
        ),
      ]
    );
  }
}