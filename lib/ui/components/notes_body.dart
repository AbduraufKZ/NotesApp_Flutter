import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson3/domain/hive/hive_box.dart';
import 'package:lesson3/domain/hive/notes_data.dart';
import 'package:lesson3/ui/components/card_widget.dart';
import 'package:lesson3/ui/components/modal_item.dart';

class NotesBody extends StatelessWidget {
  const NotesBody({super.key});

  openModalWindow(BuildContext context, int index, List<NotesData> allNotes) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ModalItem(
          index: index,
          title: allNotes[index].title,
          text: allNotes[index].text,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: HiveBoxes.notes.listenable(),
        builder: (context, Box<NotesData> notes, child) {
          final allNotes = notes.values.toList();
          return OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      openModalWindow(context, i, allNotes);
                    },
                    child: CardWidget(
                      title: allNotes[i].title,
                      date: allNotes[i].date,
                      text: allNotes[i].text,
                    ),
                  );
                },
                separatorBuilder: (context, i) => const SizedBox(height: 16),
                itemCount: allNotes.length,
              );
            } else {
              return GridView.builder(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 180,
                ),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      openModalWindow(context, i, allNotes);
                    },
                    child: CardWidget(
                      title: allNotes[i].title,
                      date: allNotes[i].date,
                      text: allNotes[i].text,
                    ),
                  );
                },
                itemCount: allNotes.length,
              );
            }
          });
        });
  }
}
