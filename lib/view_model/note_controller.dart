import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_note/database/database_service.dart';
import 'package:test_note/model/note_model.dart';
import 'package:test_note/widgets/note_color.dart';

class NoteController extends GetxController {
  DatabaseService db = DatabaseService();

  final _titleController = Rx<TextEditingController>(TextEditingController());
  final _contentController = Rx<TextEditingController>(TextEditingController());
  var _randomColor = ColorNote.randomColorHex().obs;


  //constructor

  //getter
  TextEditingController get titleController => _titleController.value;
  TextEditingController get contentController => _contentController.value;
  String get randomColor => _randomColor.value;
  set setRandomColor (RxString res) {
    _randomColor = res;
  }


  @override
  void onInit() {
    super.onInit();
    debugPrint('NoteController is initialized');
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    debugPrint('NoteController is onReady');
  }

  //fetch data if note is not null
  void fetchCurrentNote(NoteModel currentNote){
    titleController.text = currentNote.title;
    contentController.text = currentNote.content;
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clearCurrent();
    debugPrint('NoteController is onClose');
  }


  //method

  /*******************
   * SAVE NEW NOTE
   * ***************/
  Future<void> _onSave() async {
    final title = titleController.text;
    final content = contentController.text;

    await db.insertNote(
      NoteModel(
        title: title,
        content: content,
        createAt: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
        color: _randomColor.value,
      ),
    );
  }

  void saveNewNote(){
    _onSave();
    clearCurrent();
  }

  void clearCurrent(){
    titleController.clear();
    contentController.clear();
    _randomColor =  ColorNote.randomColorHex().obs;
  }


  /*******************
   * SAVE CHANGES
   * ***************/

  Future<void> _onEdit(NoteModel currentNote) async {
    final title = titleController.text;
    final content = contentController.text;

    await db.updateNote(
      NoteModel(
          id: currentNote.id,
          updateAt: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
          title: title,
          content: content,
          createAt: currentNote.createAt,
          color: currentNote.color,
          ),
    );
  }

  void saveEdit(NoteModel currentNote){
    _onEdit(currentNote);
  }

  /*******************
   * DELETE NOTE
   * ***************/
  Future<void> delete_by_index(int id) async {
    await db.deleteNote(id: id);
  }

  void deleteNote(NoteModel note){
    delete_by_index(note.id!);
  }
}