import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/enum/classes.dart';

class WitnessStatement{
  KillerCharacter? character;
  KillerClass? kClass;
  QuestionStatement sexMale = QuestionStatement();
  QuestionStatement sexFemale = QuestionStatement();
  QuestionStatement age20 = QuestionStatement();
  QuestionStatement age40 = QuestionStatement();
  QuestionStatement age60 = QuestionStatement();
  QuestionStatement sizeS = QuestionStatement();
  QuestionStatement sizeL = QuestionStatement();
  QuestionStatement sizeM = QuestionStatement();
  QuestionStatement heightS = QuestionStatement();
  QuestionStatement heightM = QuestionStatement();
  QuestionStatement heightL = QuestionStatement();
}

class QuestionStatement{
  KillerStatement answer = KillerStatement.empty;
  List<Guess> guess= [];
}

enum KillerStatement{
  yes,no,empty;
}

enum Guess{
  empty;
}