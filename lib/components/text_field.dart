
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class CommonTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final String? title;
  final bool enabled;
  final Function()? onCLick;
  final Function(PointerDownEvent)? onTapOutside;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization = TextCapitalization.sentences;
  final TextAlign textAlign;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final EdgeInsets contentPadding;
  final String? textSuffix;
  final bool autofocus;
  final bool notifyIfEmpty;
  final bool Function()? notifyCondition;

  const CommonTextField(
      {super.key,
      this.onSubmitted,
      this.hint,
      this.inputFormatters,
      this.controller,
      this.title,
      this.enabled = true,
      this.onCLick,
      this.onTapOutside,
      this.keyboardType,
      this.minLines,
      this.maxLines = 1,
        this.textAlign = TextAlign.left,
      this.maxLength,
        this.textSuffix,
        this.autofocus=false,
        this.notifyCondition,
      this.notifyIfEmpty = false,
      this.contentPadding = const EdgeInsets.all(15)});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      title != null
          ? Text(
              title!,
              style: getTextStyle()
                  .bodySmall
                  ?.copyWith(color: getColorScheme().onSurface),
              textAlign: TextAlign.start,
            )
          : Container(),
      title != null
          ? const SizedBox(
              height: 10,
            )
          : Container(),
      Stack(
        children: [
          TextField(
            onSubmitted: onSubmitted,
            onChanged: onSubmitted,
            onTapOutside: onTapOutside,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            maxLength: maxLength,
            autofocus: autofocus,
            textAlign: textAlign,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppTheme.grayFon2Color)),
              disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppTheme.grayFon2Color)),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppTheme.grayFon2Color)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppTheme.grayFon2Color)),
              counterText: "",
              focusColor: null,
              hoverColor: null,
              suffixText: textSuffix,
              suffixStyle: getTextStyle().bodyMedium,
              fillColor: null,
              isDense: true,
              hintStyle: getTextStyle()
                  .bodySmall
                  ?.copyWith(color: getColorScheme().onSurface),
              hintText: hint,
              contentPadding: contentPadding,
            ),
            readOnly: !enabled,
            onTap: onCLick,
            style: AppTheme.noteStyle,
            inputFormatters: inputFormatters,
            controller: controller,
            minLines: minLines,
            maxLines: maxLines,
          ),
          if((notifyCondition!=null && notifyCondition!()) || (notifyIfEmpty && controller?.text.isEmpty==true))...{
            Transform(
                transform: Transform
                    .translate(offset: const Offset(5, 5))
                    .transform,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.extraRedColor,
                  ),
                )),
          }
        ],
      )
    ]);
  }
}
