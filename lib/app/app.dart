import 'package:dingn/account/account_model.dart';
import 'package:dingn/app/router.dart';
import 'package:dingn/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  const MyApp(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountModel>(
      builder: (context)=>AccountModel(),
      child: MaterialApp(
        title: title,
        theme: AppTheme.theme(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      )
    );
  }
}