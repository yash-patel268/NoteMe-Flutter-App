import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternoteme/models/note_model.dart';
import 'package:flutternoteme/screens/create_note.dart';
import 'package:flutternoteme/widget/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NoteMe"),
      ),

      body: ListView.builder(
          itemCount: notes.length,
        itemBuilder: (context, index){
            //Open note_card.dart to get design of each list item
            return NoteCard(note: notes[index], index: index, onNoteDeleted: onNoteDeleted, onEditedNote: onEditedNote,);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CreateNote(onNewNoteCreated: onNewNoteCreated,)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  //Custom function which saves the note to list
  void onNewNoteCreated(Note note){
    notes.add(note);
    setState(() {});
  }

  //Custom function which allows notes to be edited
  void onEditedNote(int index, Note note){
    notes[index].title = note.title;
    notes[index].description = note.description;
    setState(() {});
  }

  //Custom function which can delete notes
  void onNoteDeleted(int index){
    notes.removeAt(index);
    setState(() {});
  }
}
