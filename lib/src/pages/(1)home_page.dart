

import 'package:flutter/material.dart';




class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MoneX'),
        leading: Container(),
      ), 
      body: Center( 
        child: Column(
          children: <Widget>[
            SizedBox(height: 120.0,),
            Text('Welcome to MoneX',
              style: TextStyle(fontSize: 40.0)),
            SizedBox(height: 10.0,),
            Text("Keep track of your friends's ",
              style: TextStyle(fontSize: 15.0)),
            Text("expenses in any currency",
              style: TextStyle(fontSize: 15.0)),
            SizedBox(height: 20.0,),
            Image(
              image: AssetImage('assets/monex_logo_grey.png'),
              height: 70.0,
              fit: BoxFit.cover,

            )
          ],
        ),
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 400.0,),
          _myExpensesButton(context),
          SizedBox(height: 30.0,),
          _plusButton(context)
        ],
      ),
    );
  }

  Widget _myExpensesButton(context) {

    return Container(
        //alignment: Alignment(0.17, 0.5),
        child: FloatingActionButton.extended(
          heroTag: 'myExpensesButton',
          onPressed: (){
            Navigator.pushNamed(context, 'display');
            },
          icon: Icon(Icons.add_shopping_cart),
          label: Text('My Expenses', 
            style: TextStyle(
              fontSize: 20.0
            ),
            ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
  }
  Widget _plusButton(context) {

    return Container(
         //alignment: Alignment(0.10, 0.0),
          child: FloatingActionButton(
            heroTag: 'plusButton',
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.pushNamed(context, 'scan');
            },  
            backgroundColor: Theme.of(context).primaryColor, 
          ),

      
      );
  }
}