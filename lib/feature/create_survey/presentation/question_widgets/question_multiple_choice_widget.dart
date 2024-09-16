import 'package:flutter/material.dart';
/*

class QuestionMultipleChoiceWidget extends StatefulWidget {
  final String? question;
  final List<Cevap>? options;
  final bool? isRequired;
  final int? inputType;
  final String? imageUrl;
  final List<Soru>? subQuestions;
  final Function(QuestionResponse) onAnswerSaved;
  final int? questionId;
  final int? soruTipiId;
  final int? tenantId;
  final QuestionResponse? savedAnswer;

  const QuestionMultipleChoiceWidget({
    super.key,
    required this.question,
    required this.options,
    required this.inputType,
    required this.isRequired,
    required this.imageUrl,
    required this.subQuestions,
    required this.onAnswerSaved,
    required this.questionId,
    required this.soruTipiId,
    required this.tenantId,
    required this.savedAnswer,
  });

  @override
  State<QuestionMultipleChoiceWidget> createState() =>
      _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<QuestionMultipleChoiceWidget> {
  List<int> userAnswers = [];
  String? userAnswer;
  List<Soru> subSoru = [];

  @override
  void initState() {
    super.initState();
    // Kaydedilmiş yanıtları yükle
    if (widget.savedAnswer != null) {
      userAnswers = widget.savedAnswer!.selectedIds ?? [];

      if (widget.savedAnswer!.selectedIds?.isNotEmpty ?? false) {
        userAnswer = widget.options
            ?.firstWhere(
                (option) => option.id == widget.savedAnswer!.selectedIds?.first,
                orElse: () => Cevap())
            .content;
        //   fetchSubQuestions(index: widget.savedAnswer!.questionId!, value: true);
      } else {
        userAnswer = null;
      }
    }
  }

  @override
  void didUpdateWidget(covariant QuestionMultipleChoiceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionId != widget.questionId) {
      subSoru.clear();
      if (widget.savedAnswer != null) {
        userAnswers = widget.savedAnswer!.selectedIds ?? [];

        if (widget.savedAnswer!.selectedIds?.isNotEmpty ?? false) {
          userAnswer = widget.options
              ?.firstWhere(
                  (option) =>
                      option.id == widget.savedAnswer!.selectedIds?.first,
                  orElse: () => Cevap())
              .content;
          //   fetchSubQuestions(index: widget.savedAnswer!.questionId!, value: true);
        } else {
          userAnswer = null;
        }
      }
      /* if (widget.savedAnswer != null) {
        userAnswers = widget.savedAnswer!.selectedIds ?? [];
        userAnswers.isNotEmpty ? null : subSoru.clear();
      }*/
    }
  }

  void fetchSubQuestions({required int index, required bool value}) {
    subSoru.clear();
    List<int> ids = SurveyMethods.convertStringToIntList(
        str: widget.options?[index].subSoruIdList ?? '');
    if (widget.subQuestions != null && value != false) {
      for (var soru in widget.subQuestions!) {
        if (ids.contains(soru.id)) {
          subSoru.add(soru);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sorunun texti
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
          context.verticalSizedBox(0.01),
          // Sorunun imagesi
          buildQuestionImage(),
          context.verticalSizedBox(0.005),
          // Seçenekler
          buildOptions(context),
          Visibility(
            visible: subSoru.isNotEmpty,
            child: Row(
              children: [
                SizedBox(
                  height: context.dynamicHeight(0.08),
                ),
                Expanded(
                  child: Divider(
                    color: AppColors.appGreyColor,
                    height: 2,
                  ),
                ),
                Text('  Alt Sorular   '),
                Expanded(
                  child: Divider(
                    color: AppColors.appGreyColor,
                    height: 2,
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: subSoru.isNotEmpty,
            child: QuestionBuilderWidget(subSoru: subSoru),
          ),
          context.verticalSizedBox(0.035),
        ],
      ),
    );
  }

  ClipRRect buildQuestionImage() {
    return ClipRRect(
      borderRadius: AppBorderRadius.circularTen,
      child: Image.asset(widget.imageUrl ?? ImageEnums.zzzz.toPathPng),
    );
  }

  Column buildOptions(BuildContext context) {
    return Column(
      children: List.generate(
        widget.options?.length ?? 0,
        (index) => Padding(
          padding: context.paddingVertAllLow,
          child: (widget.soruTipiId == 8 || widget.soruTipiId == 16)
              ? CheckboxListTile(
                  shape: ContinuousRectangleBorder(
                      borderRadius: AppBorderRadius.circularTfive,
                      side: BorderSide(color: AppColors.appGreyColor)),
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: Text(widget.options?[index].content ?? ''),
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: false,
                  value: userAnswers.contains(widget.options?[index].id),
                  onChanged: (bool? value) {
                    if (value != null) {
                      setState(() {
                        if (value) {
                          userAnswers.add(widget.options?[index].id ?? 0);
                        } else {
                          userAnswers.remove(widget.options?[index].id ?? 0);
                        }
                        fetchSubQuestions(index: index, value: value);
                        if (subSoru.isNotEmpty) {
                          CustomDialogs.showCustomDialog(
                              context: context,
                              dialogText:
                                  "Bu sorunun altında daha fazla alt soru bulunmakta. Ekranı kaydırarak bunları görebilir ve cevaplayabilirsiniz.",
                              imagePath: ImageEnums.alertImg.toPathPng,
                              continueBtn: () {
                                Navigator.pop(context);
                              },
                              continueBtnText: 'Devam Et');
                        }
                        widget.onAnswerSaved(
                          QuestionResponse(
                            questionId: widget.questionId,
                            selectedIds: userAnswers,
                            allOptionsIds:
                                SurveyMethods.fetchQuestionOptionsIds(
                                    options: widget.options),
                            cevapText: '',
                            cevapTextList: [],
                            isAnswered: value,
                            isRequired: widget.isRequired,
                            matrixResponsesMultiChoosing: [],
                            matrixResponsesSingleChoosing: [],
                            soruTipiId: widget.soruTipiId,
                            subQuestionIds:
                                SurveyMethods.fetchSubQuestionIdsOfMainQuestion(
                                    subQuestions: widget.subQuestions),
                            tenantId: widget.tenantId,
                          ),
                        );
                      });
                    }
                  },
                )
              : (widget.soruTipiId == 2 || widget.soruTipiId == 15)
                  ? RadioListTile<String?>(
                      shape: ContinuousRectangleBorder(
                          borderRadius: AppBorderRadius.circularTfive,
                          side: BorderSide(color: AppColors.appGreyColor)),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: Text(widget.options?[index].content ?? ''),
                      value: widget.options?[index].content,
                      groupValue: userAnswer,
                      toggleable: true,
                      onChanged: (String? value) {
                        setState(() {
                          userAnswer = value;
                          subSoru.clear();

                          fetchSubQuestions(
                              index: index,
                              value: value == null ? false : true);
                          if (subSoru.isNotEmpty) {
                            CustomDialogs.showCustomDialog(
                                context: context,
                                dialogText:
                                    "Bu sorunun altında daha fazla alt soru bulunmakta. Ekranı kaydırarak bunları görebilir ve cevaplayabilirsiniz.",
                                imagePath: ImageEnums.alertImg.toPathPng,
                                continueBtn: () {
                                  Navigator.pop(context);
                                },
                                continueBtnText: 'Devam Et');
                          }
                          widget.onAnswerSaved(
                            QuestionResponse(
                              questionId: widget.questionId,
                              selectedIds: [widget.options?[index].id ?? 0],
                              allOptionsIds:
                                  SurveyMethods.fetchQuestionOptionsIds(
                                      options: widget.options),
                              cevapText: '',
                              cevapTextList: [],
                              isAnswered:
                                  value != null && value != '' ? true : false,
                              isRequired: widget.isRequired,
                              matrixResponsesMultiChoosing: [],
                              matrixResponsesSingleChoosing: [],
                              soruTipiId: widget.soruTipiId,
                              subQuestionIds: SurveyMethods
                                  .fetchSubQuestionIdsOfMainQuestion(
                                      subQuestions: widget.subQuestions),
                              tenantId: widget.tenantId,
                            ),
                          );
                        });
                      },
                    )
                  : const SizedBox.shrink(),
        ),
      ),
    );
  }
}*/
