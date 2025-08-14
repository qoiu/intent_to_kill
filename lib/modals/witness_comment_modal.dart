import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/components/text_field.dart';
import 'package:intent_to_kill/modals/bottom_sheet_template.dart';
import 'package:intent_to_kill/models/witness_statement.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

final List<String> _colors = [
  ''
      "DFF2AE",
  "FFDEAD",
  "F4A460",
  "FA8072",
  "ADD8E6",
  "DDA0DD",
  "9ACD32"
];

class WitnessCommentModal extends StatefulWidget {
  final WitnessStatement witness;

  const WitnessCommentModal(this.witness, {super.key});

  @override
  State<WitnessCommentModal> createState() => _WitnessCommentModalState();
}

class _WitnessCommentModalState extends State<WitnessCommentModal> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focuses = [];

  @override
  void initState() {
    controllers = widget.witness.comments
        .map((e) => TextEditingController(text: e.comment))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTemplate(SingleChildScrollView(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBuilder('Комментарии').titleMedium().build(),
          ...List.generate(widget.witness.comments.length,
              (i) => _Comment(widget.witness.comments[i], onChange: (text) {
                widget.witness.comments[i].comment=text;
              }, onDelete: (){
                widget.witness.comments.removeAt(i);
                setState(() {});
              },key: Key(widget.witness.comments[i].comment+i.toString()),)),
          MainButton('Добавить комментарий', () {
            widget.witness.comments.add(WitnessComment());
            setState(() {});
          }),
          MainButton('Сохранить', () {
            Navigator.of(context).pop('save');
          }),
          MainButton('Изменить персонажа', () {
            Navigator.of(context).pop('change');
          }),
        ],
      ),
    ));
  }
}

class _Comment extends StatefulWidget {
  final WitnessComment comment;
  final bool lastItem;
  final Function(String) onChange;
  final Function() onDelete;

  const _Comment(this.comment,
      {this.lastItem = false, required this.onChange,  required this.onDelete, super.key});

  @override
  State<_Comment> createState() => _CommentState();
}

class _CommentState extends State<_Comment> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.comment.comment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CommonTextField(
                    autofocus: widget.lastItem,
                    controller: controller,
                    onSubmitted: widget.onChange
                    ),
              ),
              const SizedBox(width: 10),
              GestureDetector(onTap: widget.onDelete,child: Icon(Icons.delete, color: getColorScheme().primary,))
            ],
          ),
          const SizedBox(height: 5),
          Row(
            spacing: 5,
            children: _colors
                .map((e) => GestureDetector(
              onTap: (){
                widget.comment.colorCode = e;
                setState(() {});
              },
                  child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: ColorExtension.fromCode(e),
                          borderRadius: BorderRadius.circular(5),
                          border: widget.comment.colorCode == e
                              ? Border.all(color: getColorScheme().primary)
                              : null)),
                ))
                .toList(),
          )
        ],
      ),
    );
  }
}
