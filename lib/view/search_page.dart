import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_note/database/database_service.dart';
import 'package:test_note/model/note_model.dart';
import 'package:test_note/routes/app_pages.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final DatabaseService db = DatabaseService();
  Future<List<NoteModel>>? sugestNotes;

  SearchController searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              'Search Notes',
              style: TextStyle(fontSize: 20),
            ),
          ),
          body: Column(
            children: [
              // search bar
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 30),
                child: TextFormField(
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    decorationThickness: 0,
                  ),
                  controller: searchController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: searchController.text.isEmpty
                          ? null
                          : IconButton(
                              icon:
                                  const Icon(Icons.cancel, color: Colors.grey),
                              onPressed: () {
                                searchController.clear();
                              })),
                  onChanged: (value) {
                    if (value.isEmpty) {
                    } else {
                      setState(() {
                        sugestNotes = db.searchNote(value);
                      });
                    }
                  },
                ),
              ),

              // History
              Expanded(
                child: FutureBuilder(
                    future: sugestNotes,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('No Note Found'));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].title),
                            onTap: () {
                              Get.toNamed(Routes.EDITPAGE,
                                  arguments:
                                      snapshot.data![index] as NoteModel);
                            },
                            trailing: const Icon(Icons.arrow_outward),
                          );
                        },
                      );
                    }),
              )
            ],
          )),
    );
  }
}
