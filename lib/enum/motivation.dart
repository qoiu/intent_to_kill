import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

enum KillerMotivation {
  vigilant,
  radical,
  cultist,
  sadist,
  robber,
  maniac,
  terrorist,
  psychopath,
  cannibal,
  killer,
  spy,
  thug;

  String title(BuildContext context)=> context.tr(name);
  String description(BuildContext context)=> context.tr('${name}_description');
  String image()=> 'assets/motive/small/$name.jpg';
  String imageFull()=> 'assets/motive/${name}_full.jpg';
}
