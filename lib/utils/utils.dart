import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qoiu_utils/navigation.dart';

const EdgeInsets topLeftPadding = EdgeInsets.only(top: 10, left: 10);


AppLocalizations getString([BuildContext? context])=>AppLocalizations.of(context??rootNavigatorKey.currentContext!)!;

extension ShowModal on StatelessWidget  {
  Future<T?> show<T extends Object>()=>showAdminModal(this);
}


Future<T?> showAdminCenterModal<T extends Object?>(
    Widget Function(BuildContext, Animation<double>, Animation<double>)
    pageBuilder,
    [bool autoClosable = true]) {
  return showGeneralDialog(
      context: rootNavigatorKey.currentContext!,
      pageBuilder: pageBuilder,
      barrierDismissible: autoClosable,
      barrierLabel: "modal",
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0).animate(anim1),
          child: Center(child: child),
        );
      });
}


Future<T?> showAdminModal<T extends Object?>(
    Widget child,
    [bool autoClosable = true]) {
  return showGeneralDialog(
      context: rootNavigatorKey.currentContext!,
      pageBuilder: (_, __, ___) => child,
      barrierDismissible: autoClosable,
      barrierLabel: "modal",
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0).animate(anim1),
          child: Center(child: child),
        );
      });
}



Future<T?> showAdminModalRight<T extends Object?>(
    Widget child,
    [bool autoClosable = true]) {
  return showGeneralDialog(
      context: rootNavigatorKey.currentContext!,
      pageBuilder: (_,__,___)=>child,
      barrierDismissible: false,
      barrierLabel: "modal",
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      });
}

extension TextLetter on String{
  String letter(int i)=>substring(i,i+1);
}

extension AddRemove<T> on List<T>{
  addOrRemove(T e){
    if(contains(e)){
      remove(e);
    }else{
      add(e);
    }
  }
}

List<T> parseList<T>(dynamic json, T Function(dynamic) mapper)=>(json as List?)?.map((e)=>mapper(e)).toList()??<T>[];
