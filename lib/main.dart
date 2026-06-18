import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home_page.dart';

void main() async {
  widgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('mahasiswaBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      dedbugShowCheckedModeBanner: false,
      title: 'CRUD Hive',   
      home: const HomePage(),
    );
  }
}