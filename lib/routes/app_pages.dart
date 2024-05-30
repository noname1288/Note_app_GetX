import 'package:get/get.dart';
import 'package:test_note/model/note_model.dart';
import 'package:test_note/view/create_page.dart';
import 'package:test_note/view/edit_page.dart';
import 'package:test_note/view/home_page.dart';
import 'package:test_note/view/search_page.dart';


part 'app_routes.dart';

class AppPages{
  AppPages._();

  static const INITIAL = Routes.HOMEPAGE;

  static final routes=[
    GetPage(name: _Paths.HOMEPAGE, page:() => HomePage()),
    GetPage(name: _Paths.CREATEPAGE, page:() => CreatePage()),
    GetPage(name: _Paths.EDITPAGE, page:(){
      final args = Get.arguments as NoteModel;
      return EditPage(args);
    
    }),
    GetPage(name: _Paths.SEARCHPAGE, page:() => SearchPage()),

  ];
}