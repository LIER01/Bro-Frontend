import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget createBlocProviderForTesting({
  Widget child,
  Bloc bloc,
}) {
  return MaterialApp(
    home: BlocProvider(
      create: (context) => bloc,
      child: child,
    ),
  );
}
