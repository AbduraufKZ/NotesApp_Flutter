import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lesson3/domain/provider/note_provider.dart';
import 'package:lesson3/generated/locale_keys.g.dart';
import 'package:lesson3/ui/components/app_bar_widget.dart';
import 'package:lesson3/ui/components/notes_body.dart';
import 'package:lesson3/ui/routes/app_routes.dart';
import 'package:lesson3/ui/style/app_colors.dart';
import 'package:lesson3/ui/style/app_style.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NoteProvider>();
    return Scaffold(
      drawer: DrawerItems(model: model),
      appBar: AppBarWidget(
        leading: const DrawerButton(),
        title: Text(
          LocaleKeys.notes.tr(),
          style: AppStyle.fontStyle,
        ),
        action: IconButton(
          onPressed: () {
            context.go(AppRoutes.searchNotes);
          },
          icon: const Icon(Icons.search),
        ),
      ),
      body: const NotesBody(),
      floatingActionButton: SizedBox(
        width: 56,
        height: 56,
        child: FloatingActionButton.extended(
          heroTag: 'add-btn',
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onPressed: () {
            context.go(AppRoutes.addNotes);
          },
          label: const Icon(
            Icons.edit_outlined,
            color: AppColors.purple,
          ),
        ),
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  const DrawerItems({
    super.key,
    required this.model,
  });
  final NoteProvider model;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 100,
      child: SafeArea(
        child: Column(
          children: [
            Switch(
              activeColor: AppColors.purple,
              activeTrackColor: AppColors.lightGrey,
              value: model.isTheme,
              onChanged: (value) {
                model.changeTheme(value);
              },
            ),
            const SizedBox(height: 16),
            IconButton(
              onPressed: () {
                model.changeLanguage(context);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.language,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
