import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'notes.dart';

class AddNotePage extends StatefulWidget {
  final Note note;

  const AddNotePage({Key key, this.note}) : super(key: key);
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  FocusNode _descriptionNode;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: isEditMote ? widget.note.title : '');
    _descriptionController =
        TextEditingController(text: isEditMote ? widget.note.description : '');
    _descriptionNode = FocusNode();
  }

  get isEditMote => widget.note != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(isEditMote ? 'Editar nota' : 'Añadir nota'),
        backgroundColor: Colors.amber,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_descriptionNode);
                },
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "El título no puede estar vacío";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _descriptionNode,
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Descripción",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: RaisedButton(
                  color: Colors.amber,
                  textColor: Colors.black,
                  child: Text(isEditMote ? "Actualizar" : "Guardar",
                    style: TextStyle(
                      fontSize: 16.0,
                      ),
                    ),
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      try {
                        if (isEditMote) {
                          Note note = Note(
                            description: _descriptionController.text,
                            title: _titleController.text,
                            id: widget.note.id,
                          );
                          await FirestoreService().updateNote(note);
                        } else {
                          Note note = Note(
                            description: _descriptionController.text,
                            title: _titleController.text,
                          );
                          await FirestoreService().addNote(note);
                        }
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}