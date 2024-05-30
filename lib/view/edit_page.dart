import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_note/view_model/note_controller.dart';
import 'package:test_note/model/note_model.dart';
import 'package:test_note/routes/app_pages.dart';

final _formKey = GlobalKey<FormState>();

class EditPage extends StatefulWidget {
  final NoteModel? note;

  EditPage(
    this.note
  );

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final NoteController controller = Get.find<NoteController>();

  @override
  void initState() {
    super.initState();
    controller.fetchCurrentNote(widget.note!);
  }

  @override
  void dispose() {
    super.dispose();
    controller.clearCurrent();
    controller.onClose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // note's title
        automaticallyImplyLeading: true,
        toolbarHeight: 80,
        title: const Text(
          'Edit Note',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
        padding:const EdgeInsets.all(20),
        height: size.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Set border radius
          border: Border.all(
            color: Colors.grey, // Set border color
            width: 1.0,
          ),
          color: Color(int.parse(widget.note!.color!)), // Set background color
        ),
        child: SingleChildScrollView(
          padding:const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // title
                Obx(
                  () => TextFormField(
                    controller: controller.titleController,
                    validator: (value) =>
                        value!.isEmpty ? 'Title is required' : null,
                    decoration: const InputDecoration(
                        border: InputBorder.none, label: Text('Title')),
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        decorationThickness: 0,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    maxLines: null,
                  ),
                ),

                // content
                Obx(
                  () => TextFormField(
                    controller: controller.contentController,
                    validator: (value) =>
                        value!.isEmpty ? 'Content is required' : null,
                    decoration: const InputDecoration(
                        border: InputBorder.none, label: Text('Content')),
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    maxLines: null,
                    clipBehavior: Clip.antiAlias,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.saveEdit(widget.note!);
          }
          Get.offAllNamed(Routes.HOMEPAGE);
        },
        label: const Text('Save Note'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
