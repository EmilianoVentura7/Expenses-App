import 'package:flutter/material.dart';
import 'package:expenses_app/app/my_app.dart';
import 'package:expenses_app/core/di/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppModule.init();
  runApp(const MyApp());
}
