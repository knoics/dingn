import 'package:dingn/account/account_model.dart';
import 'package:flutter/material.dart';
import 'package:dingn/themes.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final accountModel = Provider.of<AccountModel>(context);
    return AppBar(
      leading: IconButton(
        onPressed: (){
        },
        icon: Icon(Icons.menu)
      ),
      titleSpacing: 0,
      title: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/account', (Route<dynamic> route) => false);
        },
        child: const Text(
          'dingn',
          style: TextStyle(color: AppTheme.accentColor, fontWeight: FontWeight.bold,
          fontSize: AppTheme.fontSizeBrand),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 1,
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/word', (Route<dynamic> route) => false);
          },
          child: Column(
            children: <Widget>[
              Icon(Icons.library_books, color: AppTheme.accentColor,),
              const Text('words', style: TextStyle(color: AppTheme.accentColor, fontSize: AppTheme.fontSizeIconButtonText)),
            ]
          )
        ),
        FlatButton(
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/number', (Route<dynamic> route) => false);
          },
          child: Column(
            children: <Widget>[
              Icon(Icons.subject, color: AppTheme.accentColor),
              const Text('numbers', style: TextStyle(color: AppTheme.accentColor, fontSize: AppTheme.fontSizeIconButtonText)),
            ]
          )
        ),
        _getAccountButton(context, accountModel),
      ],
      
      // bottom: const TabBar(
      //   tabs: [  
      //     Tab(icon: Icon(Icons.view_list)),
      //     Tab(icon: Icon(Icons.language)),
      //   ],
      // ),
    );
  }

  Widget _getAccountButton(BuildContext context, AccountModel accountModel){
    if (accountModel.isSignedIn) 
      return FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/account', (Route<dynamic> route) => false);
        },
        shape: const CircleBorder(side: BorderSide.none),
        child: CircleAvatar(
          backgroundColor: AppTheme.accentColor,
          foregroundColor: Colors.white,
          backgroundImage: accountModel.account.photoURL!=null?NetworkImage(accountModel.account.photoURL):null,
          child: Text(accountModel.account.photoURL!=null?'':accountModel.account.initials),
        ),
      );
    else
      return FlatButton(
        onPressed: (){
            Navigator.of(context).pushNamed('/signin');
        },
        child: Column(
          children: <Widget>[
            Icon(Icons.account_box, color: AppTheme.accentColor,),
            const Text('signin', style: TextStyle(color: AppTheme.accentColor, fontSize: AppTheme.fontSizeIconButtonText)),
          ]
        )
      );
  } 


  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

