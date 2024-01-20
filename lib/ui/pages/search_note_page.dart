import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson3/domain/hive/hive_box.dart';
import 'package:lesson3/domain/hive/notes_data.dart';
import 'package:lesson3/generated/locale_keys.g.dart';
import 'package:lesson3/ui/components/app_bar_widget.dart';
import 'package:lesson3/ui/components/card_widget.dart';
import 'package:lesson3/ui/routes/app_routes.dart';
import 'package:lesson3/ui/style/app_colors.dart';
import 'package:lesson3/ui/style/app_style.dart';

class SearchNotePage extends StatefulWidget {
  const SearchNotePage({super.key});

  @override
  State<SearchNotePage> createState() => _SearchNotePageState();
}

class _SearchNotePageState extends State<SearchNotePage> {
  final searchController = TextEditingController();
  final _notes = HiveBoxes.notes.values.toList();
  var filteredNotes = <NotesData>[];

  void _searchNotes() {
    final query = searchController.text;

    if (query.isNotEmpty) {
      filteredNotes = _notes.where((NotesData noteList) {
        return noteList.title.toLowerCase().contains(query.toLowerCase()) ||
            noteList.text.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      filteredNotes = _notes;
    }
    setState(() {});
  }

  Future<void> deleteText() async {
    searchController.clear();
  }

  @override
  void initState() {
    filteredNotes = _notes;
    searchController.addListener(_searchNotes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: IconButton(
          onPressed: () {
            context.go(AppRoutes.home);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Expanded(
          child: TextField(
            controller: searchController,
            cursorColor: AppColors.grey,
            style: AppStyle.fontStyle,
            decoration: InputDecoration(
              hintText: LocaleKeys.search.tr(),
              hintStyle: AppStyle.fontStyle,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(0),
            ),
          ),
        ),
        action: IconButton(
          onPressed: deleteText,
          icon: const Icon(Icons.close),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: HiveBoxes.notes.listenable(),
          builder: (context, Box<NotesData> box, child) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, i) {
                return CardWidget(
                  title: filteredNotes[i].title,
                  text: filteredNotes[i].text,
                  date: filteredNotes[i].date,
                );
              },
              separatorBuilder: (context, i) => const SizedBox(height: 16),
              itemCount: filteredNotes.length,
            );
          }),
    );
  }
}
