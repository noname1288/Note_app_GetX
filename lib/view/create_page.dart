import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_note/view_model/note_controller.dart';
import 'package:test_note/model/note_model.dart';
import 'package:test_note/routes/app_pages.dart';

final _formKey = GlobalKey<FormState>();

class CreatePage extends StatefulWidget {

  NoteModel? note;

  @override
  CreatePageState createState () => CreatePageState();
//const CreatePage({Key? key}) : super(key: key);

}

class CreatePageState extends State<CreatePage> {
  final NoteController controller = Get.find<NoteController>();


  @override
  void initState() {
    controller.clearCurrent();
    super.initState();
  }

  @override
  void dispose() {
    controller.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Get screen size


    return Scaffold(
      appBar: AppBar(
        // note's title
        automaticallyImplyLeading: true,
        toolbarHeight: 80,
        title: const Text(
          'Create Note',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Obx(
        () => Container(
          margin:
              const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 20),
          padding: const EdgeInsets.all(20),
          height: size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // Set border radius
            border: Border.all(
              color: Colors.grey, // Set border color
              width: 1.0,
            ),
            color: Color(int.parse(
                controller.randomColor)), // Set background color
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // title
                  TextFormField(
                      controller: controller.titleController,
                      validator: (value) =>
                          value!.isEmpty ? 'Title is required' : null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                      ),
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          decorationThickness: 0,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      maxLines: null),

                  // content
                  TextFormField(
                    controller: controller.contentController,
                    validator: (value) =>
                        value!.isEmpty ? 'Content is required' : null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Content',
                    ),
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    maxLines: null,
                    clipBehavior: Clip.antiAlias,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      /**************************
       * SAVE NOTE BUTTON
       ************************/

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) { //?????? how to check validation
            controller.saveNewNote();
            Get.offAllNamed(Routes.HOMEPAGE);
          }
        },
        label:const Text('Save'),
        icon:const Icon(Icons.save),
      ),
    );
  }
}
