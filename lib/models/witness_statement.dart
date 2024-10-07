
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/enum/classes.dart';

class WitnessStatement{
  KillerCharacter character;
  QuestionStatement sexMale = QuestionStatement('assets/icon/sex_m.png');
  QuestionStatement sexFemale = QuestionStatement('assets/icon/sex_f.png');
  QuestionStatement age20 = QuestionStatement('assets/icon/age_20.png');
  QuestionStatement age40 = QuestionStatement('assets/icon/age_40.png');
  QuestionStatement age60 = QuestionStatement('assets/icon/age_60.png');
  QuestionStatement sizeS = QuestionStatement('assets/icon/size_s.png');
  QuestionStatement sizeM = QuestionStatement('assets/icon/size_m.png');
  QuestionStatement sizeL = QuestionStatement('assets/icon/size_l.png');
  QuestionStatement heightS = QuestionStatement('assets/icon/height_s.png');
  QuestionStatement heightM = QuestionStatement('assets/icon/height_m.png');
  QuestionStatement heightL = QuestionStatement('assets/icon/height_l.png');

  WitnessStatement({required this.character});
}

class QuestionStatement{
  String icon;
  KillerStatement answer = KillerStatement.empty;
  List<Guess> guess= [];

  QuestionStatement(this.icon);
}

enum KillerStatement{
  yes,no,empty;
}

enum Guess{
  empty;
}