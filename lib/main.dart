import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walpapper_task_app/feature/view/screen/home_screen.dart';
import 'package:walpapper_task_app/feature/view_model/photo_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhotoViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
