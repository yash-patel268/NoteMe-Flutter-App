import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/note_model.dart';

class NoteView extends StatefulWidget {
  final Note note;
  final int index;
  final Function(int) onNoteDeleted;
  final Function(int, Note) onEditedNote;

  NoteView({
    Key? key,
    required this.note,
    required this.index,
    required this.onNoteDeleted,
    required this.onEditedNote,
  }) : super(key: key);

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    descriptionController = TextEditingController(text: widget.note.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note View"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete this Note?"),
                    content: Text("Note ${widget.note.title} will be deleted"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onNoteDeleted(widget.index);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Delete"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      )
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: descriptionController,
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text.isEmpty) {
            return;
          } else {
            widget.note.title = titleController.text;
          }
          if (descriptionController.text.isEmpty) {
            return;
          } else {
            widget.note.description = descriptionController.text;
          }

          widget.onEditedNote(widget.index, widget.note);
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
