import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/constants.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  Map<String, dynamic> userMap;
  final TextEditingController _search = TextEditingController();

  void onSearch()async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection("users").where("username", isEqualTo: _search.text)
        .get().then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          userMap=value.docs[0].data();
        });
      } else {
        print('Not Found!');
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),

      ),
      body: Container( constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/e.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children:  <Widget>[

            SizedBox(
              height: size.height / 20,
            ),

            Container(
              height:  size.height / 14,
              width:size.width,
              alignment: Alignment.center,

              child: Container(
                height:  size.height / 14,
                width:size.width /1.15,
                child: TextField(
                  controller: _search,
                  maxLines: 1,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Search For Users",
                      hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                      prefixIcon: Icon(Icons.search,color: Colors.white,)
                    ),
                    style: TextStyle(color: Colors.white),

                  ),
                ),
              ),

            SizedBox(height:size.height /50),

            ElevatedButton(
              onPressed: () => onSearch(),
              child: Text("Search"),
            ),

            SizedBox(height:size.height /50),

            ((userMap ?? {}).isNotEmpty) ?
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatScreen(res: userMap)),
                ),
                child: Text(userMap['name'])
            )
                : SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: (){
          setState(() {
            Navigator.pushNamed(context, 'setting_screen');
          });
        },
      ),
    );
  }
}
