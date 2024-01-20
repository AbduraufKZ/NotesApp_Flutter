import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lesson3/domain/hive/hive_box.dart';
import 'package:lesson3/domain/hive/notes_data.dart';
import 'package:lesson3/generated/locale_keys.g.dart';
import 'package:lesson3/ui/routes/app_routes.dart';

class NoteProvider extends ChangeNotifier {
  //controllers
  final titleController = TextEditingController();
  final textController = TextEditingController();

  //scroll
  final scrollController = ScrollController();

  //add notes

  Future<void> onAddNote(BuildContext context) async {
    await HiveBoxes.notes
        .add(
          NotesData(
            title: titleController.text.isNotEmpty
                ? titleController.text
                : LocaleKeys.title.tr(),
            text: textController.text.isNotEmpty
                ? textController.text
                : LocaleKeys.note.tr(),
          ),
        )
        .then((value) => context.go(AppRoutes.home))
        .then(
          (value) => clearControllers(),
        );
  }

  //очищение контроллеров

  clearControllers() async {
    titleController.clear();
    textController.clear();
  }

  //удаление заметок
  Future<void> deleteNote(BuildContext context, int index) async {
    await HiveBoxes.notes
        .deleteAt(index)
        .then((value) => Navigator.pop(context));
  }

  //редактирование заметки
  Future<void> changeNote(BuildContext context, int index) async {
    await HiveBoxes.notes
        .putAt(
          index,
          NotesData(
            title: titleController.text.isNotEmpty
                ? titleController.text
                : LocaleKeys.title.tr(),
            text: textController.text.isNotEmpty
                ? textController.text
                : LocaleKeys.note.tr(),
          ),
        )
        .then((value) => clearControllers())
        .then((value) => context.go(AppRoutes.home));
  }

  //установка значений в поля редактирования
  Future<void> setControllers(int index) async {
    titleController.text =
        HiveBoxes.notes.getAt(index)?.title ?? LocaleKeys.title.tr();
    textController.text =
        HiveBoxes.notes.getAt(index)?.title ?? LocaleKeys.note.tr();
  }

  //изменение темы
  bool isTheme = false;

  changeTheme(bool value) {
    isTheme = value;
    notifyListeners();
  }

  changeLanguage(BuildContext context) {
    if (context.locale == const Locale('ru')) {
      context.setLocale(
        const Locale('en'),
      );
    } else {
      context.setLocale(
        const Locale('ru'),
      );
    }
    notifyListeners();
  }
}
