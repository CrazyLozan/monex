





import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:monex/src/pages/(3)addding_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}



class _ScanPageState extends State<ScanPage> {

  File pickedImage;
  bool isImageLoaded = false;

  var _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //title: Text('(2)scaning')
      ),
      body: ListView(
        children: <Widget>[

          isImageLoaded 
          ? Center(
                child: Container(
                    height: 300.0,
                    //width: 200.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(pickedImage), fit: BoxFit.cover))
                ),
            )

          : Center(child: Container(
                    height: 300.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/noimage_text.png'), 
                            fit: BoxFit.cover
                        )
                    ),
        //                   image: AssetImage('assets/noimage.png'),
        //                    height: 300.0,
        //                    fit: BoxFit.cover,
                  ),
            ),
          ListTile(
            title: RaisedButton(
              child: Text('Pick Image'),
              onPressed: pickImage, 
            )   
          ),
          ListTile(
            title: RaisedButton(
              child: Text('Open Camera'),
              onPressed: cameraImage, 
            )   
          ),
          ListTile(
            title: FloatingActionButton.extended(
              heroTag: 'readNumber',
              label: Text('Read Number'),
              onPressed: readText,
              backgroundColor: Theme.of(context).primaryColor, 
            )   
          ),
          customDivider(),
          ListTile(
            title: TextField(
              
              style: TextStyle(fontSize: 20.0),
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                hintText: 'example: 127',
                labelText: 'Add your new expense manually',
                helperText: 'When the amount is introduced press OK',
                suffixIcon: Icon(Icons.insert_comment),
                icon: Icon(Icons.panorama_fish_eye),
              ) ,
              
            )
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'okTag',
        onPressed: (){
                var route = MaterialPageRoute(
                  builder: (BuildContext context) => AddPage(value: _textController.text),
                );
                Navigator.of(context).push(route);
              },
        label: Text('OK'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
        
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

    
  }

  Future pickImage() async{

    var tempStore = await ImagePicker.pickImage(
      source: ImageSource.gallery
      //source: ImageSource.camera
      );

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });

  }
   Future cameraImage() async{

    var tempStore = await ImagePicker.pickImage(
      source: ImageSource.camera
      );

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });

  }

  Future readText() async {

    if(isImageLoaded){
      FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
      TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
      VisionText readText = await recognizeText.processImage(ourImage);

      for (TextBlock block in readText.blocks) {
        for (TextLine line in block.lines) {
          for (TextElement word in line.elements) {
            print(word.text);
            _textController.text = "${word.text}";
            return;
          }
        }
      }
    }
    
  }

  customDivider() {

    return Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
              Text("OR"),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ]);

  }

}




