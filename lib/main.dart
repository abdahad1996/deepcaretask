import 'package:deepcaretask/domain/fetch_random_usecase_imp.dart';
import 'package:deepcaretask/infra/api_client_adapter.dart';
import 'package:deepcaretask/presentation/random_number_bloc.dart';
import 'package:deepcaretask/ui/clock_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'data/http/random_repository_imp.dart';
import 'domain/random_number_repository.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    BlocProvider(
      create: (_) => RandomNumberBloc(
        FetchRandomUsecaseImp(
          RandomNumberRepositoryImp(
            ApiClientAdapter(http.Client()),
            "http://www.randomnumberapi.com/api/v1.0/random"
          )
        ),
        prefs,
        // autoStart: true  // This is optional since it defaults to true
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ClockScreen(),
    );
  }
}

