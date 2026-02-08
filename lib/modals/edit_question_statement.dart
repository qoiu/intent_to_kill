import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/enum/characters.dart';
import 'package:intent_to_kill/models/witness_statement.dart';
import 'package:intent_to_kill/utils/app_settings.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

class EditQuestionStatementModal extends StatefulWidget {
  final QuestionStatement statement;
  final KillerCharacter from;
  final VoidCallback? onTap;

  const EditQuestionStatementModal({super.key, required this.statement, required this.from, this.onTap});

  @override
  State<EditQuestionStatementModal> createState() => _EditQuestionStatementModalState();
}

class _EditQuestionStatementModalState extends State<EditQuestionStatementModal> {
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    ['state',widget.statement.toJson()].print();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var itemWidth = (MediaQuery.of(context).size.width - 100) / 3;
    return SizedBox(
      width: MediaQuery.of(context).size.width - (AppSettings.useNewStyle?20:100),
      child: AppCard(
        intrinsicWidth: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBuilder(getString().killer_question(context.tr(widget.from.name))).titleMedium().build(),
                  Image.asset(widget.statement.icon, width: 30, height: 30),
                  TextBuilder('?').titleMedium().build(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSettings.useNewStyle?20:0),
              child: Row(
                children: [
                  mainItem(itemWidth, KillerStatement.empty,'assets/icon/cancel.png'),
                  mainItem(itemWidth, KillerStatement.yes,'assets/icon/yes.png'),
                  mainItem(itemWidth, KillerStatement.no,'assets/icon/no.png'),
                ],
              ),
            ),
            if(AppSettings.useNewStyle)...{
              const SizedBox(height: 40),
            }
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: Row(children: Guess.values.map((e)=>Icon(IconData(e.hash, fontFamily: 'MaterialIcons'))).toList()),
            // ),
          ],
        ),
      ),
    );
  }

  Widget mainItem(double itemWidth, KillerStatement require, String image) {
    return GestureDetector(
      onTap: (){
        setState(() {
          widget.statement.answer = require;
        });
        widget.onTap?.let((it)=>it());
      },
      child: Container(
                    width: itemWidth,
                    height: itemWidth,
                    decoration: BoxDecoration(
                        border: widget.statement.answer == require
                            ? Border.all(color: getColorScheme().primary)
                            : null,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(image,
                        fit: BoxFit.cover)),
    );
  }
}
