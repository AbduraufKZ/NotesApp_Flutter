import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lesson3/domain/provider/note_provider.dart';
import 'package:lesson3/generated/locale_keys.g.dart';
import 'package:lesson3/ui/style/app_colors.dart';
import 'package:lesson3/ui/style/app_style.dart';
import 'package:provider/provider.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.btnName,
    required this.func,
  });

  final String btnName;
  final Function func;
  @override
  Widget build(BuildContext context) {
    final titleView = context.watch<NoteProvider>().titleController;
    final textView = context.watch<NoteProvider>().textController;
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: [
          TextFormWidget(
            labelText: LocaleKeys.title.tr(),
            hintText: LocaleKeys.title.tr(),
            formController: titleView,
          ),
          const SizedBox(height: 16),
          TextFormWidget(
            labelText: LocaleKeys.note.tr(),
            hintText: LocaleKeys.note.tr(),
            formController: textView,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FloatingActionButton.extended(
              backgroundColor: AppColors.backgroundColor,
              onPressed: () {
                func();
              },
              label: Text(
                btnName,
                style: AppStyle.fontStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.formController,
  });

  final String labelText, hintText;
  final TextEditingController formController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: formController,
      cursorColor: AppColors.grey,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppStyle.fontStyle.copyWith(
          fontSize: 12,
          color: AppColors.grey,
        ),
        hintText: hintText,
        hintStyle: AppStyle.fontStyle.copyWith(
          fontSize: 16,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
