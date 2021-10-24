import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:untitled2/constants.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}
class _SettingScreenState extends State<SettingScreen> {

  File newProfilePic;
  String url="";

  Future getImage() async {
      var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        newProfilePic = tempImage;
      });
  }
   Future uoloadImage()async{
    var imageFile= await FirebaseStorage.instance.ref().child("path").child("/.jpg");
    UploadTask task =imageFile.putFile(newProfilePic);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    await  FirebaseFirestore.instance.collection("images").doc().set({"imageURL":url});
    print(url);
    }
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;

  return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text('Settings'),
      ),
        body: SingleChildScrollView(
          child: Container(
           child: Padding(
             padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size.width/3,
                  width: size.width/3,
                  child: Stack(
                    children:[
                      Center(
                        child: CircleAvatar(
                         radius: size.width/3,
                            child: ClipOval(
                                child: (newProfilePic!=null)?Image.file(newProfilePic,fit: BoxFit.cover,width: 100.0,height: 100.0,):Container(),
                     ),
                    ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                       child: InkWell(
                         onTap: (){getImage();},
                         child: Container(
                           decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,),
                           padding: EdgeInsets.all(2.0),

                           child: Container(
                              child: Icon(Icons.edit,size: 20,color: Colors.white,),
                            decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(5.0),
                         ),
                         ),
                       ),
                      ),
                   ],
                  ),
                ),
                SizedBox(
                  height: size.width/9,
                ),
                TextField(
                  decoration:kSettingTextField.copyWith(
                    hintText: 'Name',hintStyle: TextStyle(fontSize: 18.0, color: Colors.white38),
                    helperText: 'Enter your name and add a profile photo',helperStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                    style: TextStyle(color: Colors.white),
                ),

                SizedBox(
                  height:size.width/15),
                TextField(
                  decoration:kSettingTextField.copyWith(
                    hintText: 'Username',hintStyle: TextStyle(fontSize: 18.0, color: Colors.white38),
                    helperText: 'Tap to change your username',helperStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                 style: TextStyle(color: Colors.white),
                ),

                SizedBox(
                  height: size.width/15),
                TextField(decoration: kSettingTextField.copyWith(
                  hintText: 'Bio',hintStyle: TextStyle(fontSize: 18.0, color: Colors.white38),
                  helperText: 'Add a few words about yourself',helperStyle: TextStyle(fontSize:15.0, color: Colors.white),
                ),
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(
                  height: size.width/9,),

                ElevatedButton(onPressed: (){
                    uoloadImage();
                    },
                    child: Text('Done')
                )



            ]
           )
       )
      ),
        )
  );
  }
}


