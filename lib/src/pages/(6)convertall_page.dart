




import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:monex/src/pages/(3)addding_page.dart';
import 'package:monex/entities/expense.dart';


class ConvertAllPage extends StatefulWidget {
  final String value;

  ConvertAllPage({Key key, this.value}) : super(key: key);

  @override
  _ConvertAllPageState createState() => _ConvertAllPageState();
}


class _ConvertAllPageState extends State<ConvertAllPage> {


List<ExpenseConvert> _expenses = List<ExpenseConvert>(); 


  Future<List<ExpenseConvert>> loadListExpenseConverts() async{

    //CREATE AN IF FOR AVOIDING NULL
    //String selectedCurrency = '${widget.value}';
    
    String url = 'http://localhost:3000/convertExpenses?currency=${widget.value}';
    // String url = 'http://10.0.2.2:3000/convertExpenses?currency=${widget.value}';
    print(url);
    var response = await http.get(url);
 
    var expenses = List<ExpenseConvert>();

    if (response.statusCode == 200) {
      var responsesBody = json.decode(response.body);
      print(responsesBody['expenses']);
      for(var responseBody in responsesBody['expenses']){
        expenses.add(ExpenseConvert.fromJson(responseBody));
      }
    }
  
    return expenses;
  }

  @override
  void initState() {
     loadListExpenseConverts().then((value){
      setState((){
        _expenses.addAll(value);
        // print(_expenses);
        // print(_expenses[0].friend);
        }); 
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('(6)ConvertAll'),
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
        : ListView.builder(
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
                      
                      Text('${widget.value}', 
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
        
        )
    );
  }

 

 
}