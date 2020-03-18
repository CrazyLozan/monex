


import 'dart:async';
import 'dart:convert';
//import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monex/src/pages/(4)display_page.dart';

class AddPage extends StatefulWidget {
 final String value;

 AddPage({Key key, this.value}) : super (key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

String inputCurrency = "USD"; //fromCurrency
String inputFriend = "David";
double inputAmount = 0.0;


//extEditingController _controller;

List<String> myListOfCurrency;
List<String> myListOfFriends;


  @override
  void initState() {
    super.initState();
    loadListCurrencies();
    loadListFriends();
 
    //_controller = new TextEditingController(text: '16');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('(3)adding')
      ),
      body: myListOfCurrency == null || myListOfFriends == null
        ? Center(child: CircularProgressIndicator())
        : Container(
        margin: EdgeInsets.symmetric(vertical: 10.0 , horizontal :10.0),
        child: 
       
          Card(
          elevation: 10.0,
          
          
      
            child: Column(
               mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10,),
                Row(
                  children: <Widget>[
                    SizedBox(width: 20.0,),
                    Container(

                      width: 310.0,
                      child: _buildTextField()),
                  ],
                ),
                SizedBox(height: 10,),
                Divider(thickness: 10.0,
                          indent: 30.0,
                          endIndent: 30.0,
                          ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 20.0,),
                    Text("Select the currency: ",
                       style: TextStyle(fontSize: 18.0)
                    ),
                    SizedBox(width: 85.0,),
                    _buildCurrencyDropDownButton(inputCurrency),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 20.0,),
                    Text("Select the friend: ",
                       style: TextStyle(fontSize: 18.0)
                    ),
                    SizedBox(width: 90.0,),
                    _buildFriendDropDownButton(inputFriend),
                  ],
                ),
              
              SizedBox(height: 10,),
              
              ],
            ),
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          _postExpense();
          var route = MaterialPageRoute(
                  builder: (BuildContext context) => DisplayPage(),
                );
                Navigator.of(context).push(route);
        }, 
        label: Text('Add', 
            style: TextStyle(
              fontSize: 20.0
            ),
         ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );

  }



///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

 //FOR CURRENCY LIST

  Widget _buildCurrencyDropDownButton( String currencyCategory){
    return DropdownButton(
      value: currencyCategory,
      items: myListOfCurrency
        .map((String value) => DropdownMenuItem(
            value: value, 
            child: Row(
                children: <Widget>[
                  Text(value),
                ],
            ),
          ))
          .toList(),
        onChanged: (String value) {
          _onCurrencyChange(value);
        },
      );
  }

  _onCurrencyChange(String value){
    setState(() {
      inputCurrency = value;
    });
  }

   Future<String> loadListCurrencies() async{
    String uri = "http://localhost:3000/listCurrencies";
    // String uri = "http://10.0.2.2:3000/listCurrencies";
    
    var response = await http.get(Uri.encodeFull(uri), headers: {'Accept' : 'application/json'});
    var responseBody = json.decode(response.body);
    myListOfCurrency = responseBody['currencies'].cast<String>().toList();
    setState(() {}); 
    return 'Success';
  }

/////////////////////////////////////////////////////////
// FOR FRIEND LIST

    Widget _buildFriendDropDownButton( String friendCategory){
    return DropdownButton(
      value: friendCategory,
      items: myListOfFriends
        .map((String value) => DropdownMenuItem(
            value: value, 
            child: Row(
                children: <Widget>[
                  Text(value),
                ],
            ),
          ))
          .toList(),
        onChanged: (String value) {
          _onFriendChange(value);
        },
      );
  }

  _onFriendChange(String value){
    setState(() {
      inputFriend = value;
    });
  }

   Future<String> loadListFriends() async{
    String uri = "http://localhost:3000/listFriends";
    // String uri = "http://10.0.2.2:3000/listFriends";
    
    var response = await http.get(Uri.encodeFull(uri), headers: {'Accept' : 'application/json'});
    var responseBody = json.decode(response.body);
    myListOfFriends = responseBody['friends'].cast<String>().toList();
    setState(() {}); 
    return 'Success';
  }


  _postExpense() async{

    inputAmount = double.parse(widget.value);

    String url = "http://localhost:3000/addExpense";
    // String url = "http://10.0.2.2:3000/addExpense";
    
    Map <String,String> headers = {'Content-type' : 'application/json'};
    String json = '{"friend": "$inputFriend", "amount": $inputAmount, "currency": "$inputCurrency"}';

    var response = await http.post(url, headers: headers, body: json);

    int statusCode = response.statusCode;
    print(statusCode);
    String body = response.body;
    print(body);

    return response;
  }

/////////////////////////////////////////////////////////
// FOR TEXT FIELD

  Widget _buildTextField() {

    return  TextField(
              enabled: false,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  
                  borderRadius: BorderRadius.circular(20.0)
                ),
                labelText: "Your expense:                   ${widget.value}",
                icon: Icon(Icons.panorama_fish_eye),
                
              ) ,
              
            );

  }

}


