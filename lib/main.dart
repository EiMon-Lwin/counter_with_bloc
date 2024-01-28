import 'package:counter_with_bloc/bloc/get/cubit/get_contact_cubit.dart';
import 'package:counter_with_bloc/module.dart';
import 'package:counter_with_bloc/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  locator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<GetContactCubit>(
        create: (context) => getIt.call(),
        child: HomePage(

        ),
      ),
    );
  }
}
