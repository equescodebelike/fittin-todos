import 'package:fittin_todo/pages/todo_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF9900),
          primary: const Color(0xFFFF9900),
          background: const Color(0xFFEDEDED),
          surface: const Color(0xFFFFFFFF),
          secondary: const Color(0xFF45B443),
          error: const Color(0xFFF85535),
        ),
        textTheme: TextTheme(
          headlineSmall: GoogleFonts.montserrat(
            fontSize: 24,
            height: 32 / 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: GoogleFonts.montserrat(
            fontSize: 15,
            height: 20 / 16,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: GoogleFonts.montserrat(
              fontSize: 14, 
              height: 20 / 14, 
              fontWeight: FontWeight.w400
          ),
        ),
      ),
      home: const TodoListPage(),
    );
  }
}
