import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/utils/utils.dart';

enum KillerCharacter {
  actr(KillerClass.boh,'f2sm'),
  agnt(KillerClass.rule,'m2ml'),
  ambas(KillerClass.rule,'f4mm'),
  artist(KillerClass.boh,'f4ll'),
  bart(KillerClass.crime,'f4lm'),
  basb(KillerClass.boh,'m2ls'),
  briolin(KillerClass.marg,'m2ls'),
  catw(KillerClass.marg,'f6mm'),
  congr(KillerClass.rule,'m6lm'),
  coro(KillerClass.med,'f6ss'),
  dict(KillerClass.press,'m6ms'),
  disp(KillerClass.law,'m6ml'),
  dncr(KillerClass.marg,'f2sl'),
  don(KillerClass.crime,'m6sm'),
  dorm(KillerClass.crime,'m2ll'),
  driver(KillerClass.work,'m6ls'),
  edit(KillerClass.press,'f6lm'),
  fila(KillerClass.boh,'m4mm'),
  fire(KillerClass.work,'m4sl'),
  fortn(KillerClass.imm,'f2ms'),
  gangstr(KillerClass.crime,'m4ms'),
  homls(KillerClass.marg,'m6ss'),
  iccrm(KillerClass.work,'m2mm'),
  inform(KillerClass.crime,'f2ss'),
  inspctr(KillerClass.law,'f2mm'),
  jrnlst(KillerClass.press,'f2ml'),
  judg(KillerClass.law,'f6ls'),
  lawr(KillerClass.law,'f4sl'),
  libr(KillerClass.press,'f6sm'),
  lobb(KillerClass.rule,'f6sl'),
  mayr(KillerClass.rule,'m4ss'),
  monc(KillerClass.imm,'f6ll'),
  muzic(KillerClass.imm,'m4ls'),
  nurf(KillerClass.med,'f4ml'),
  nurm(KillerClass.med,'m2ms'),
  nwsp(KillerClass.press,'m2sm'),
  pharm(KillerClass.med,'f2lm'),
  phto(KillerClass.press,'m4ll'),
  post(KillerClass.work,'f4ss'),
  prof(KillerClass.imm,'m6mm'),
  prosec(KillerClass.law,'m4lm'),
  psych(KillerClass.boh,'m6sl'),
  ptrl(KillerClass.law,'m2ss'),
  rest(KillerClass.boh,'f6ms'),
  sail(KillerClass.imm,'m2sl'),
  secr(KillerClass.rule,'f2ls'),
  spclnt(KillerClass.crime,'f6ml'),
  stew(KillerClass.imm,'f4sm'),
  surg(KillerClass.med,'m4sm'),
  vet(KillerClass.marg,'m4ml'),
  wait(KillerClass.work,'f4ms'),
  wdow(KillerClass.marg,'f4ls'),
  weld(KillerClass.work,'f2ll'),
  wete(KillerClass.med,'m6ll');

  const KillerCharacter(this.kClass, this.stat);
  final KillerClass kClass;
  final String stat;

  String get imgSex=>'assets/icon/sex_${stat.letter(0)}.png';
  String get imgAge=>'assets/icon/age_${stat.letter(1)}0.png';
  String get imgSize=>'assets/icon/size_${stat.letter(2)}.png';
  String get imgHeight=>'assets/icon/height_${stat.letter(3)}.png';
}
