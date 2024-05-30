
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_note/model/note_model.dart';
import 'package:test_note/routes/app_pages.dart';

/*******************
 * Note Card Widget
 *******************/

class NoteCard extends StatelessWidget {
  final NoteModel note;

  NoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    String res = note.updateAt != null ? note.updateAt! : note.createAt;
    String displayDate = res.substring(0, 11);
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(int.parse(note.color!)), 
          width: 5.0,
        ),
        //color: Color(int.parse(note.color!)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 30),
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.EDITPAGE, arguments: note);
          },
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.title,
                  style:const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),maxLines: 2),
              Container(
                width: 200,
                padding: const EdgeInsets.only(left: 3.0),
                child:const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 50),
                child: Text(
                  note.content,
                  style:const TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 3,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(displayDate,
                  style:const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
