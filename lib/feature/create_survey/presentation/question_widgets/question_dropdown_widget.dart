import 'package:flutter/material.dart';

/*
class QuestionDropDownWidget extends StatefulWidget {
  final String? question;
  final List<Cevap>? options;
  final bool? isRequired;
  final List<Soru>? subQuestions;
  final Function(QuestionResponse) onAnswerSaved;
  final int? questionId;
  final int? soruTipiId;
  final int? tenantId;
  final QuestionResponse? savedAnswer;

  const QuestionDropDownWidget(
      {super.key,
      required this.question,
      required this.options,
      required this.isRequired,
      required this.subQuestions,
      required this.onAnswerSaved,
      required this.questionId,
      required this.soruTipiId,
      required this.tenantId,
      required this.savedAnswer});

  @override
  State<QuestionDropDownWidget> createState() => _QuestionDropDownWidgetState();
}

class _QuestionDropDownWidgetState extends State<QuestionDropDownWidget> {
  Cevap? _selectedOption;
  List<DropdownMenuItem<Cevap>> listItems = [];
  List<Soru> subSoru = [];
  int? userAnswerId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeListItems(); // Kaydedilmiş yanıtları yükle
      if (widget.savedAnswer != null &&
          widget.savedAnswer!.selectedIds != null &&
          widget.savedAnswer!.selectedIds!.isNotEmpty) {
        _selectedOption = widget.options?.firstWhere(
          (option) => option.id == widget.savedAnswer!.selectedIds!.first,
          orElse: () => Cevap(),
        );
        userAnswerId = widget.savedAnswer!.selectedIds!.first;
      }
    });
  }

  @override
  void didUpdateWidget(covariant QuestionDropDownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      _initializeListItems();
    }
  }

  void _initializeListItems() {
    setState(() {
      listItems = widget.options!
          .map((option) => DropdownMenuItem<Cevap>(
                value: option,
                child: Text(
                  option.content ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ))
          .toList();
      _selectedOption = null;
      subSoru.clear();
    });
  }

  @override
  void dispose() {
    listItems.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(height: context.dynamicHeight(0.05)),
          FittedBox(
            child: DropdownButton<Cevap>(
              hint: Text(
                "Select an option",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              value: _selectedOption,
              onChanged: (Cevap? newValue) {
                setState(() {
                  _selectedOption = newValue;

                  // Seçilen cevabın IDsini bulma
                  userAnswerId = newValue?.id;

                  subSoru.clear();
                  if (widget.options != null) {
                    List<int> ids = [];
                    for (int i = 0; i < widget.options!.length; i++) {
                      ids = SurveyMethods.convertStringToIntList(
                          str: widget.options?[i].subSoruIdList ?? '');
                    }
                    if (widget.subQuestions != null) {
                      for (var soru in widget.subQuestions!) {
                        if (ids.contains(soru.id)) {
                          subSoru.add(soru);
                        }
                      }
                    }
                  }

                  widget.onAnswerSaved(
                    QuestionResponse(
                      questionId: widget.questionId,
                      selectedIds: [userAnswerId ?? 0],
                      soruTipiId: widget.soruTipiId,
                      allOptionsIds: SurveyMethods.fetchQuestionOptionsIds(
                          options: widget.options),
                      cevapText: '',
                      cevapTextList: [],
                      isAnswered: true,
                      isRequired: widget.isRequired,
                      matrixResponsesMultiChoosing: [],
                      matrixResponsesSingleChoosing: [],
                      subQuestionIds:
                          SurveyMethods.fetchSubQuestionIdsOfMainQuestion(
                              subQuestions: widget.subQuestions),
                      tenantId: widget.tenantId,
                    ),
                  );
                });
              },
              items: listItems.isNotEmpty
                  ? listItems
                  : [
                      DropdownMenuItem<Cevap>(
                        value: null,
                        child: Text(
                          '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
            ),
          ),
          SizedBox(height: context.dynamicHeight(0.05)),
          Visibility(
            visible: subSoru.isNotEmpty,
            child: QuestionBuilderWidget(subSoru: subSoru),
          ),
        ],
      ),
    );
  }
}
*/