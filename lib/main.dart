import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/screens/tabs.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

Color primaryBlue = Colors.blueAccent[400] as Color;
final kScheme = ColorScheme.fromSeed(seedColor: primaryBlue);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: kScheme,
          useMaterial3: true,
          textTheme: GoogleFonts.latoTextTheme(),
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: kScheme.surface),
              backgroundColor: kScheme.onPrimaryContainer,
              titleTextStyle: TextStyle(color: kScheme.onPrimary))),
      home: const TabsScreen(),
    );
  }
}
