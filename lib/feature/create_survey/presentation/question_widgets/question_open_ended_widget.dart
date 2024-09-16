import 'package:flutter/material.dart';

/*
class QuestionOpenEndedWidget extends StatefulWidget {
  final String? question;
  final int? maxLines;
  final int? fieldCount;
  final bool? isRequired;
  final Function(QuestionResponse) onAnswerSaved;
  final int? questionId;
  final int? soruTipiId;
  final int? tenantId;
  final QuestionResponse? savedAnswer;

  const QuestionOpenEndedWidget(
      {super.key,
      required this.question,
      required this.maxLines,
      required this.fieldCount,
      required this.isRequired,
      required this.onAnswerSaved,
      required this.questionId,
      required this.soruTipiId,
      required this.tenantId,
      required this.savedAnswer});

  @override
  State<QuestionOpenEndedWidget> createState() =>
      _QuestionOpenEndedWidgetState();
}

class _QuestionOpenEndedWidgetState extends State<QuestionOpenEndedWidget> {
  List<TextEditingController> _controllers = [];
  List<String> cevapTextList = [];

  @override
  void initState() {
    super.initState();
    int count = widget.fieldCount ?? 1; // fieldCount en az 1 olmalı
    cevapTextList = List.generate(count, (index) => '');
    _controllers = List.generate(count, (index) => TextEditingController());

    // Kaydedilmiş yanıtları yükle
    if (widget.savedAnswer != null) {
      if (widget.savedAnswer!.cevapTextList != null &&
          widget.savedAnswer!.cevapTextList!.isNotEmpty) {
        for (int i = 0; i < count; i++) {
          if (i < widget.savedAnswer!.cevapTextList!.length) {
            _controllers[i].text = widget.savedAnswer!.cevapTextList![i];
            cevapTextList[i] = widget.savedAnswer!.cevapTextList![i];
          }
        }
      } else if (widget.savedAnswer!.cevapText != null) {
        _controllers[0].text = widget.savedAnswer!.cevapText!;
        cevapTextList[0] = widget.savedAnswer!.cevapText!;
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveAnswer() {
    if ((widget.fieldCount == 1) || (widget.fieldCount == null)) {
      widget.onAnswerSaved(QuestionResponse(
        questionId: widget.questionId,
        selectedIds: [],
        soruTipiId: widget.soruTipiId,
        cevapText: _controllers[0].text,
        cevapTextList: [],
        allOptionsIds: [],
        isAnswered: true,
        isRequired: widget.isRequired,
        matrixResponsesMultiChoosing: [],
        matrixResponsesSingleChoosing: [],
        subQuestionIds: [],
        tenantId: widget.tenantId,
      ));
    } else {
      widget.onAnswerSaved(QuestionResponse(
        questionId: widget.questionId,
        selectedIds: [],
        soruTipiId: widget.soruTipiId,
        cevapText: '',
        cevapTextList: cevapTextList,
        allOptionsIds: [],
        isAnswered: true,
        isRequired: widget.isRequired,
        matrixResponsesMultiChoosing: [],
        matrixResponsesSingleChoosing: [],
        subQuestionIds: [],
        tenantId: widget.tenantId,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            SurveyMethods.stripHtml(widget.question ?? ''),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            (widget.isRequired ?? false)
                ? '*Bu soruyu yanıtlamadan ilerleyemezsiniz, lütfen yanıtlayınız.'
                : '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: context.dynamicHeight(0.05),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            itemCount: widget.fieldCount ?? 1,
            itemBuilder: (context, index) => Padding(
              padding: context.paddingVertAllLow,
              child: TextField(
                controller: _controllers[index],
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                  hintText: 'Cevabınızı buraya yazınız...',
                  border: const OutlineInputBorder(),
                ),
                maxLines: widget.maxLines,
                minLines: 3,
                onChanged: (value) {
                  setState(() {
                    cevapTextList[index] = value;
                  });
                  _saveAnswer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/