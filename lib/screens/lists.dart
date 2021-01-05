import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Lists extends StatefulWidget {

  static const String id = 'lists_screen';

  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {

  String listTitle = "";
  String pointTitle = "";
  String pointTitleTwo = "";
  String pointTitleThree = "";
  String pointTitleFour = "";
  String pointTitleFive = "";

  createList() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("myLists").doc(listTitle);
    Map<String, dynamic> lists = {"listTitle":listTitle,"pointTitle":pointTitle,"pointTitleTwo":pointTitleTwo,"pointTitleThree":pointTitleThree,"pointTitleFour":pointTitleFour,"pointTitleFive":pointTitleFive};

    documentReference.set(lists).whenComplete(() => print("$listTitle created with $pointTitle"));
  }

  deleteList(item) {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("myLists").doc(item);

    documentReference.delete().whenComplete(() => print("$item deleted"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF494949),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  color: Color(0xff745800),
                  child:
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Añadir lista',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF494949),
                            fontSize: 21.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextField(
                            autofocus: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: '¿Algo nuevo?',
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF494949)),
                              ),
                            ),
                            onChanged: (String value) {
                              listTitle = value;
                            }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                            autofocus: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: '¡Añade el primer punto ahora!',
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF494949)),
                              ),
                            ),
                            onChanged: (String value) {
                              pointTitle = value;
                            }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                            autofocus: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: '¡Añade el segundo punto ahora!',
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF494949)),
                              ),
                            ),
                            onChanged: (String value) {
                              pointTitleTwo = value;
                            }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                            autofocus: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: '¡Añade el tercer punto ahora!',
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF494949)),
                              ),
                            ),
                            onChanged: (String value) {
                              pointTitleThree = value;
                            }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                            autofocus: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: '¡Añade el cuarto punto ahora!',
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF494949)),
                              ),
                            ),
                            onChanged: (String value) {
                              pointTitleFour = value;
                            }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                            autofocus: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: '¡Añade el quinto punto ahora!',
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF494949)),
                              ),
                            ),
                            onChanged: (String value) {
                              pointTitleFive = value;
                            }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton(
                          child: Text('Añadir',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF494949),
                            ),
                          ),
                          color: Color(0xFFffbf00),
                          onPressed: () {
                            createList();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 200.0,
                width: 320.0,
                padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 0.0, top: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70.0,
                      ),
                      Text('Lis',
                       textAlign: TextAlign.right,
                       style: TextStyle(
                       color: Colors.white,
                       fontSize: 40.0,
                       fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('¡No te olvides ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                height: 200.0,
                width: 91.4,
                padding: EdgeInsets.only(bottom: 10.0, left: 0.0, right: 10.0, top: 10.0),
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.list,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      backgroundColor: Colors.amber,
                      radius: 30.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('tas',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                        Text('de nada!',
                         style: TextStyle(
                           color: Colors.grey.shade600,
                           fontSize: 17.0,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.amber.shade400,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                ),
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("myLists").snapshots(),
                builder: (context, snapshots){
                  if(snapshots.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshots.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot = snapshots.data.documents[index];
                          return Dismissible(
                            onDismissed: (direction) {
                              deleteList(documentSnapshot["listTitle"]);
                            },
                            key: Key(documentSnapshot["listTitle"]),
                            child: Card(
                              color: Colors.white,
                              elevation: 5.0,
                              margin: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                              child: ListTile(
                                title: Text(documentSnapshot["listTitle"],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(documentSnapshot["pointTitle"],),
                                    Text(documentSnapshot["pointTitleTwo"],),
                                    Text(documentSnapshot["pointTitleThree"],),
                                    Text(documentSnapshot["pointTitleFour"],),
                                    Text(documentSnapshot["pointTitleFive"],),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
                    } else {
                      return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(),
                      );
                  }
                }),
            ),
          ),
        ],
      ),
    );
  }
}
