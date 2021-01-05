import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {


  static const String id = 'timeline_screen';

  static const SecondaryColor = Color(0xFF494949);
  static const PrimaryColor = Color(0xFFffbf00);
  static const ThirdColor = Color(0xFFdedede);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  String todoTitle = "";

  createTodos() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(todoTitle);
    Map<String, String> todos = {"todoTitle": todoTitle};

    documentReference.set(todos).whenComplete(() {
      print("$todoTitle created");
    });
  }

  deleteTodos(item) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(item);

    documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Timeline.SecondaryColor,
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
                        Text('Añadir tarea',
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
                            todoTitle = value;
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
                            createTodos();
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
        children: [
          Container(
            padding:
                EdgeInsets.only(left: 30.0, top: 30.0, right: 60.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.home,
                        color: Timeline.ThirdColor,
                        size: 25.0,
                      ),
                      backgroundColor: Timeline.SecondaryColor,
                      radius: 30,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Línea del tiempo',
                      style: TextStyle(
                        color: Timeline.SecondaryColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('¡A organizar el día!',
                style: TextStyle(
                  color: Timeline.SecondaryColor,
                  fontSize: 17.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.amber.shade400,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("MyTodos").snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshots.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                            snapshots.data.documents[index];
                            return Dismissible(
                                onDismissed: (direction) {
                                  deleteTodos(documentSnapshot["todoTitle"]);
                                },
                                key: Key(documentSnapshot["todoTitle"]),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  margin: EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ListTile(
                                    title: Text(documentSnapshot["todoTitle"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    leading: Icon(
                                      Icons.keyboard_arrow_right,
                                    ),
                                    trailing: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          deleteTodos(documentSnapshot["todoTitle"]);
                                        }),
                                  ),
                                ));
                          });
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
