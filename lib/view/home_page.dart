import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_note/view_model/note_controller.dart';
import 'package:test_note/database/database_service.dart';
import 'package:test_note/model/note_model.dart';
import 'package:test_note/routes/app_pages.dart';
import 'dart:math';

import 'package:test_note/widgets/note_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService db = DatabaseService();
  final controller = Get.find<NoteController>();


  // Lấy notes từ local database
  Future<List<NoteModel>>? allNotes;

  @override
  void initState() {
    super.initState();
    fetchNotes();
    controller.clearCurrent();
  }

  void fetchNotes() {
    // fetch notes from database
    setState(() {
      allNotes = db.fetchAllNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 80,
          leading: Image.asset(
            'assets/image/logo_note2.png',
            width: 30,
            height: 40,
          ),
          title: const Text(
            'NOTES',
            style: TextStyle(
              fontSize: 27,
            ),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.SEARCHPAGE);
              },
              icon:const Icon(Icons.manage_search),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Divider(
              color: Colors.grey,
              height: 1,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: FutureBuilder(
                  future: allNotes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error'));
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text('No Note Found'),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.requireData.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: Key(snapshot.requireData[index].id.toString()),
                            onDismissed: (direction) {
                              controller.deleteNote(
                                  snapshot.requireData[index]);
                              fetchNotes();
                            },
                            child: NoteCard(note: snapshot.requireData[index]),
                          
                        );
                      },
                    );
                  }),
            ),
          ],
        ),

        /***********************
         * Button nổi tạo note mới
        **************************/
        floatingActionButton: FloatingActionButton(
          backgroundColor:const Color(0xFF798CBE),
          onPressed: () => Get.toNamed(Routes.CREATEPAGE)!,
          child:const Icon(
            Icons.add,
            color: Colors.white,
          ),
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}
