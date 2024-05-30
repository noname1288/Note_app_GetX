import 'package:get/get.dart';
import 'package:test_note/view_model/note_controller.dart';

class NoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NoteController(), permanent: false);
  }
}