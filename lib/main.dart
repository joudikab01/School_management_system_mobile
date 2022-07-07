import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_mobile/providers/providers.dart';
import 'package:sms_mobile/screens/screens.dart';
import 'package:sms_mobile/screens/student/exam_schedule.dart';
import 'package:sms_mobile/screens/student/quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const WelcomeScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/schedule': (context) => const Schedule(),
          '/quiz': (context) => const Quiz(),
          '/exam_schedule':(context) => const ExamSchedule(),
        },
      ),
    );
  }
}
