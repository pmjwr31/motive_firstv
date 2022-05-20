import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'settingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
class nameinput extends StatefulWidget {
  @override
  State<nameinput> createState() => _nameinputState();
}

class _nameinputState extends State<nameinput> {
  final myController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/logo.png',
            fit: BoxFit.contain,
            height: 35,)
          ],
        ),
        backgroundColor: Colors.white,
      ),

        body: Material(
          child:Center(
              child : Column(
                  children:[
                Container(
                  margin : EdgeInsets.only(bottom: 40, top:10),
                  height: 56, width: 323,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(70),),
                      border: Border.all(
                        color: const Color(0xffb936DFF),
                        width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text("Do not try to be original"),

                  )),
                Container(
                  child: SizedBox(
                    height: 380,
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection(user!.uid).orderBy("priority").snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting){
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final docs = snapshot.data!.docs;
                                final List<Color> colors = [
                                  Color(0xffb003399),
                                  Color(0xffb1F62C7),
                                  Color(0xffb7C91DB),
                                  Color(0xffbC6CEF8),
                                  Color(0xffbDCE4FF)
                                ];
                                return Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: docs.length ,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: colors[docs[index]['priority']],
                                          padding: EdgeInsets.all(8),
                                          child: Text(docs[index]['Title']),
                                        );
                                      }
                                  ),
                                );
                              },

                            ),
                          ],

                        )
                    ),
                  ),
                ),
                    Container(
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                              flex:5,
                              child: Text(" ")
                          ),
                          Expanded(
                            flex: 3,
                            child:  FloatingActionButton(
                              backgroundColor: const Color(0xffb936DFF),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Settingpage()),
                                );
                              },
                              child: Icon(Icons.add,size: 40,),
                            ),)
                        ],
                      ),
                    )
              ]
        ))));
  }
}
