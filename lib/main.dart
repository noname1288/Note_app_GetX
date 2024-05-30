import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_note/binding/note_binding.dart';
import 'package:test_note/routes/app_pages.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme:const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 250, 248, 248),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 250, 248, 248),
      ),
      //theme: ThemeData.dark(),
      initialRoute: AppPages.INITIAL,
      initialBinding: NoteBinding(),
      getPages: AppPages.routes,
      
    );
  }
}
