// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  final controller;
  VoidCallback onSave;

  AddPage({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  State<AddPage> createState() => _AddPageState();
}
// костыль ваще жесть,
// разберусь как нормально передавать DateTime
DateTime? datePick;

class _AddPageState extends State<AddPage> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        // меняем стандартную иконку закрытия
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: themeData.colorScheme.background,
        actions: [
          TextButton(
            onPressed: () {
              widget.onSave();
              Navigator.of(context).pop();
            },
            child: Text(
              'СОХРАНИТЬ',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: themeData.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 5,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18, top: 10),
              child: TextFormField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: 'Здесь будут мои заметки',
                  hintStyle: themeData.textTheme.bodyMedium,
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: 13,
              ),
            ),
          ),
          // ShowDatePicker
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    final res = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    setState(() {
                      datePick = res;
                    });
                  },
                  child: Text(
                    'Дедлайн',
                    style: themeData.textTheme.bodyLarge,
                  ),
                ),
                Text(
                  datePick != null
                      ? dateFormat.format(datePick!).toString()
                      : 'Дата',
                  style: themeData.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
