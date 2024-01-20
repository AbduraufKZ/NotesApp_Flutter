import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lesson3/domain/provider/note_provider.dart';
import 'package:lesson3/generated/locale_keys.g.dart';
import 'package:lesson3/ui/routes/app_routes.dart';
import 'package:lesson3/ui/style/app_colors.dart';
import 'package:lesson3/ui/style/app_style.dart';
import 'package:provider/provider.dart';

class ModalItem extends StatelessWidget {
  const ModalItem({
    super.key,
    required this.index,
    required this.title,
    required this.text,
  });
  final int index;
  final String title, text;

  Widget modalLine() {
    return Center(
      child: Container(
        width: 34,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFFDEDEDE),
          borderRadius: BorderRadius.circular(19),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NoteProvider>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 34, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          modalLine(),
          const SizedBox(height: 10),
          Center(
            child: Text(
              title,
              style: AppStyle.fontStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: AppStyle.fontStyle.copyWith(
              fontSize: 14,
              color: AppColors.grey,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 28),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.lightPurple,
            ),
            onPressed: () {
              context.go(AppRoutes.changeNotes, extra: index);
              model.setControllers(index);
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: AppColors.purple,
            ),
            label: Text(
              LocaleKeys.edit.tr().toUpperCase(),
              style: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.purple,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.lightRed,
            ),
            onPressed: () {
              model.deleteNote(context, index);
            },
            icon: const Icon(
              Icons.delete,
              color: AppColors.red,
            ),
            label: Text(
              LocaleKeys.delete.tr().toUpperCase(),
              style: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
