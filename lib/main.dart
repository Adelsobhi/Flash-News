import 'package:flash_news/home/category/category_details.dart';
import 'package:flash_news/home/home_screen.dart';
import 'package:flash_news/provider/theme_provider.dart';
import 'package:flash_news/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName :(context)=>HomeScreen(),
      },
      theme:AppTheme.lightTheme,
      darkTheme:AppTheme.darkTheme ,
      themeMode: appTheme.themeMode,
    ) ;
  }
}
