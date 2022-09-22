import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';


class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {

  // File _image;

  File? selectedImage;
  String base64Image ="";

  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // won't have any error now
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Save Memories'),
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child:Center(
            child: ListView(
              children: [
                Image.asset(
                  'assets/images/memories.jpg',
                  height: 250,
                  alignment: Alignment.topCenter,
                ),

                   Padding(
                    padding: const EdgeInsets.all(0), // Border radius
                    child: ClipRRect(
                        child: selectedImage != null
                            ? Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        )
                            : Image.asset(
                          'assets/images/choose.jpg',
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        )),
                  ),

                Row(
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          chooseImage("camera");
                        },
                      icon: Icon(Icons.camera_alt),  //icon data for elevated button
                      label: Text("Click a Photo"), //label text
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          side: BorderSide(width:6, color:Colors.white), //border width and color
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.fromLTRB(35, 15, 35, 15) //content padding inside button
                      ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          chooseImage("Gallery");
                        },
                        icon: Icon(Icons.photo),  //icon data for elevated button
                        label: Text("Select a Photo"), //label text
                        style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                            side: BorderSide(width:4, color:Colors.white),
                            alignment: Alignment.center,//border width and color
                            elevation: 3, //elevation of button
                            shape: RoundedRectangleBorder( //to set border radius to button
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.fromLTRB(35, 15, 35, 15)//content padding inside button
                        ),
                      ),
                    ],
                  ),

            Column(
                children: [
                ElevatedButton.icon(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Saved",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
          },
            icon: Icon(Icons.save_alt),  //icon data for elevated button
            label: Text("Save"), //label text
            style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                side: BorderSide(width:6, color:Colors.white), //border width and color
                elevation: 3, //elevation of button
                shape: RoundedRectangleBorder( //to set border radius to button
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.fromLTRB(35, 15, 35, 15) //content padding inside button
            ),
                ),
          ]
        ),


                Image.asset(
                  'assets/images/points.jpg',
                  fit: BoxFit.cover,
                )
              ],
            ),
          )
        ));

    // void pickimage() async()
    // {
    //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //   setState(() {
    //     _image=image;
    //   });
    // }

    // void Saveimage(){
    //   SharedPre
    // }


  }
}