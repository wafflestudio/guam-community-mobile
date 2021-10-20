import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/home/home_provider.dart';
import 'home.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Home(),
    );
  }
}
