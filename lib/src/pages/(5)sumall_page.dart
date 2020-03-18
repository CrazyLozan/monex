




import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:monex/src/pages/(3)addding_page.dart';
import 'package:monex/entities/expense.dart';
import 'package:monex/src/pages/(6)convertall_page.dart';

class SumPage extends StatefulWidget {
  @override
  _SumPageState createState() => _SumPageState();
}


class _SumPageState extends State<SumPage> {
 var _textController = TextEditingController();

String inputCurrency = "USD";
List<String> myListOfCurrency;
List<Expense> _expenses = List<Expense>(); 

@override
  void initState() {
    super.initState();
    loadListCurrencies();
      loadListExpenses().then((value){
      setState((){
        _expenses.addAll(value);
      
        }); 
    });
  }


  Future<List<Expense>> loadListExpenses() async{
    String url = "http://localhost:3000/sumExpenses";
    // String url = "http://10.0.2.2:3000/sumExpenses";
    
    var response = await http.get(url);
 
    var expenses = List<Expense>();

    if (response.statusCode == 200) {
      var responsesBody = json.decode(response.body);
      print(responsesBody['expenses']);
      for(var responseBody in responsesBody['expenses']){
        expenses.add(Expense.fromJson(responseBody));
      }
    }
  
    return expenses;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('(5)sumall'),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: (){
              Navigator.pushReplacementNamed(context, 'home');
              }
            )
          ],
      ),
      body: _expenses == null 
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: <Widget>[
              Column(
              children: <Widget>[
             
              myListOfCurrency == null 
              ? Center(child: CircularProgressIndicator())
              : Container(
                height: 400.0,
                child: ListView.builder(
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical:1.0),
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(_expenses[index].friend,
                                    style: TextStyle(fontSize: 18.0)), 
                                SizedBox(width: 200,), 
                                Text((_expenses[index].amount).toString(),
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                
                                Text(_expenses[index].currency, 
                                    style: TextStyle(fontSize: 18.0, color: Colors.blue, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _expenses.length,
                  
                  ),
              ),
              SizedBox(height: 30,),
              Card(
              margin: EdgeInsets.symmetric(vertical: 00.0 , horizontal :30.0),
              color: Colors.grey,
              child:   Row(
                  children: <Widget>[
                    SizedBox(width: 20.0,),
                    Text("Select the currency: ",
                       style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)
                    ),
                    SizedBox(width: 85.0,),
                    _buildCurrencyDropDownButton(inputCurrency),
                  ],
                ),
              ),

            ],
          ),
        ],
     ),
     floatingActionButton: FloatingActionButton.extended(
       onPressed: () {
                  var route = MaterialPageRoute(
                    builder: (BuildContext context) =>
                         ConvertAllPage(value: inputCurrency),
                  );
                  Navigator.of(context).push(route);
                }, 
       label: Text('Convert all',
            style: TextStyle(fontWeight: FontWeight.bold)),
       icon: Icon(Icons.loop),
       backgroundColor: Theme.of(context).primaryColor,
       
       ),
       
   );
  }

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

 
}