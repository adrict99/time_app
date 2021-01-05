import 'package:flutter/material.dart';
import 'package:time_app/notes_brain/firestore_service.dart';
import 'package:time_app/notes_brain/add_note.dart';
import 'package:time_app/notes_brain/note_details.dart';
import 'package:time_app/notes_brain/notes.dart';

class Notes extends StatelessWidget {
  static const String id = 'notes_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.amber.shade400,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  left: 25.0, top: 30.0, right: 120.0, bottom: 30.0),
              margin: EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.note,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        backgroundColor: Colors.grey,
                        radius: 30.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Notas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '¡Más vale pájaro en mano que ciento volando!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirestoreService().getNotes(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                if (snapshot.hasError || !snapshot.hasData)
                  return CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Note note = snapshot.data[index];
                    return ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            color: Colors.green,
                            icon: Icon(Icons.edit),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddNotePage(note: note),
                                )),
                          ),
                          IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteNote(context, note.id),
                          ),
                        ],
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NoteDetailsPage(
                            note: note,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Color(0xFF494949)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNotePage()));
        },
      ),
    );
  }

  void _deleteNote(BuildContext context, String id) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await FirestoreService().deleteNote(id);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("¿Seguro que quieres borrar esta nota?"),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("Borrar"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}
