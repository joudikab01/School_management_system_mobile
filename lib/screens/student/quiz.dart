import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sms_mobile/providers/providers.dart';
import 'package:sms_mobile/utill/utill.dart';
import '../../models/models.dart';
import '../../services/api_response.dart';
import '../../components/error.dart' as err;

class QuizScreen extends StatefulWidget {
  final int quizId;
  const QuizScreen({required this.quizId, Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Answer> answers = [];
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  initState() {
    String token = Provider.of<AppProvider>(context, listen: false).getToken();
    Provider.of<AppProvider>(context, listen: false)
        .getStudentQuiz(widget.quizId, 'Bearer $token');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(251, 250, 250, 1),
        elevation: 0,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    days[DateTime.now().weekday - 1],
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'ChakraPetch',
                        letterSpacing: 0.5),
                  ),
                  Text(
                    '${months[DateTime.now().month - 1]} ${DateTime.now().year.toString().substring(2)}',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'ChakraPetch',
                        letterSpacing: 0.5),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                DateTime.now().day.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 48,
                    fontFamily: 'ChakraPetch'),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Consumer<AppProvider>(builder: (context, provider, child) {
        if (provider.getStudentQuizResponse != null) {
          switch (provider.getStudentQuizResponse!.status) {
            case Status.LOADING:
              return CircularProgressIndicator(
                color: Colors.orange[400],
              );
            case Status.COMPLETED:
              return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: provider
                      .getStudentQuizResponse!.data!.data![0].questions!.length,
                  itemBuilder: (context, index) {
                    if (answers.length < index + 1) {
                      answers.add(
                        Answer(
                          questionId: provider.getStudentQuizResponse!.data!
                              .data![0].questions![index].id!,
                          choiceId: 0,
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Question : ${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${provider.getStudentQuizResponse!.data!.data![0].end!.difference(DateTime.now()).inMinutes} min',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          height: 15,
                          endIndent: 15,
                          indent: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 20),
                          child: Text(
                            '${index + 1}. ${provider.getStudentQuizResponse!.data!.data![0].questions![index].text} ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                  .data![0].questions![index].choices![0].id) {
                                answers[index].choiceId = 0;
                              } else {
                                answers[index].choiceId = provider.getStudentQuizResponse!.data!
                                    .data![0].questions![index].choices![0].id;
                              }
                            });
                          },
                          onPanStart: (details) {
                            setState(() {
                              if (answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                  .data![0].questions![index].choices![0].id) {
                                answers[index].choiceId = 0;
                              } else {
                                answers[index].choiceId = provider.getStudentQuizResponse!.data!
                                    .data![0].questions![index].choices![0].id;
                              }
                            });
                          },
                          child: Stack(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                      .data![0].questions![index].choices![0].id
                                      ? Colors.orange[400]
                                      : const Color.fromRGBO(70, 73, 81, 1),
                                ),
                                constraints: BoxConstraints.expand(
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 60,
                                ),
                                child: Center(
                                  child: Text(
                                    provider
                                        .getStudentQuizResponse!
                                        .data!
                                        .data![0]
                                        .questions![index]
                                        .choices![0]
                                        .text!,
                                    style: TextStyle(
                                      color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![0].id
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                left: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                    .data![0].questions![index].choices![0].id
                                    ? width - 85
                                    : 5,
                                top: 5,
                                duration: const Duration(milliseconds: 500),
                                child: AnimatedRotation(
                                  turns: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                      .data![0].questions![index].choices![0].id ? 1 : 0,
                                  duration: const Duration(milliseconds: 500),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: answers[index].choiceId ==provider.getStudentQuizResponse!.data!
                                            .data![0].questions![index].choices![0].id
                                            ? const Color.fromRGBO(
                                                70, 73, 81, 1)
                                            : Colors.orange[400]),
                                    child: Center(
                                      child: Text(
                                        'A',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                              .data![0].questions![index].choices![0].id
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                  .data![0].questions![index].choices![1].id) {
                                answers[index].choiceId = 0;
                              } else {
                                answers[index].choiceId = provider.getStudentQuizResponse!.data!
                                    .data![0].questions![index].choices![1].id;
                              }
                            });
                          },
                          onPanStart: (details) {
                            setState(() {
                              if (answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                  .data![0].questions![index].choices![1].id) {
                                answers[index].choiceId = 0;
                              } else {
                                answers[index].choiceId = provider.getStudentQuizResponse!.data!
                                    .data![0].questions![index].choices![1].id;
                              }
                            });
                          },
                          child: Stack(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                      .data![0].questions![index].choices![1].id
                                      ? Colors.orange[400]
                                      : const Color.fromRGBO(70, 73, 81, 1),
                                ),
                                constraints: BoxConstraints.expand(
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 60,
                                ),
                                child: Center(
                                  child: Text(
                                    provider
                                        .getStudentQuizResponse!
                                        .data!
                                        .data![0]
                                        .questions![index]
                                        .choices![1]
                                        .text!,
                                    style: TextStyle(
                                      color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![1].id
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                left: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                    .data![0].questions![index].choices![1].id
                                    ? width - 85
                                    : 5,
                                top: 5,
                                duration: const Duration(milliseconds: 500),
                                child: AnimatedRotation(
                                  turns: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                      .data![0].questions![index].choices![1].id ? 1 : 0,
                                  duration: const Duration(milliseconds: 500),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                            .data![0].questions![index].choices![1].id
                                            ? const Color.fromRGBO(
                                                70, 73, 81, 1)
                                            : Colors.orange[400]),
                                    child: Center(
                                      child: Text(
                                        'B',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                              .data![0].questions![index].choices![1].id
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: provider
                                      .getStudentQuizResponse!
                                      .data!
                                      .data![0]
                                      .questions![index]
                                      .choices!
                                      .length >
                                  2
                              ? 10
                              : 0,
                        ),
                        provider.getStudentQuizResponse!.data!.data![0]
                                    .questions![index].choices!.length >
                                2
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                        .data![0].questions![index].choices![2].id) {
                                      answers[index].choiceId = 0;
                                    } else {
                                      answers[index].choiceId = provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![2].id;
                                    }
                                  });
                                },
                                onPanStart: (details) {
                                  setState(() {
                                    if (answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                        .data![0].questions![index].choices![2].id) {
                                      answers[index].choiceId = 0;
                                    } else {
                                      answers[index].choiceId = provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![2].id;
                                    }
                                  });
                                },
                                child: Stack(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                            .data![0].questions![index].choices![2].id
                                            ? Colors.orange[400]
                                            : const Color.fromRGBO(
                                                70, 73, 81, 1),
                                      ),
                                      constraints: BoxConstraints.expand(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        height: 60,
                                      ),
                                      child: Center(
                                        child: Text(
                                          provider
                                              .getStudentQuizResponse!
                                              .data!
                                              .data![0]
                                              .questions![index]
                                              .choices![2]
                                              .text!,
                                          style: TextStyle(
                                            color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                                .data![0].questions![index].choices![2].id
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    AnimatedPositioned(
                                      left: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![2].id
                                          ? width - 85
                                          : 5,
                                      top: 5,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: AnimatedRotation(
                                        turns: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                            .data![0].questions![index].choices![2].id
                                            ? 1
                                            : 0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                                      .data![0].questions![index].choices![2].id
                                                      ? const Color.fromRGBO(
                                                          70, 73, 81, 1)
                                                      : Colors.orange[400]),
                                          child: Center(
                                            child: Text(
                                              'C',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                                        .data![0].questions![index].choices![2].id
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: provider
                                      .getStudentQuizResponse!
                                      .data!
                                      .data![0]
                                      .questions![index]
                                      .choices!
                                      .length >
                                  3
                              ? 10
                              : 0,
                        ),
                        provider.getStudentQuizResponse!.data!.data![0]
                                    .questions![index].choices!.length >
                                3
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                        .data![0].questions![index].choices![3].id) {
                                      answers[index].choiceId = 0;
                                    } else {
                                      answers[index].choiceId = provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![3].id;
                                    }
                                  });
                                },
                                onPanStart: (details) {
                                  setState(() {
                                    if (answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                        .data![0].questions![index].choices![3].id) {
                                      answers[index].choiceId = 0;
                                    } else {
                                      answers[index].choiceId = provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![3].id;
                                    }
                                  });
                                },
                                child: Stack(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                            .data![0].questions![index].choices![3].id
                                            ? Colors.orange[400]
                                            : const Color.fromRGBO(
                                                70, 73, 81, 1),
                                      ),
                                      constraints: BoxConstraints.expand(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        height: 60,
                                      ),
                                      child: Center(
                                        child: Text(
                                          provider
                                              .getStudentQuizResponse!
                                              .data!
                                              .data![0]
                                              .questions![index]
                                              .choices![3]
                                              .text!,
                                          style: TextStyle(
                                            color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                                .data![0].questions![index].choices![3].id
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    AnimatedPositioned(
                                      left: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![3].id
                                          ? width - 85
                                          : 5,
                                      top: 5,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: AnimatedRotation(
                                        turns: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                            .data![0].questions![index].choices![3].id
                                            ? 1
                                            : 0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                                      .data![0].questions![index].choices![3].id
                                                      ? const Color.fromRGBO(
                                                          70, 73, 81, 1)
                                                      : Colors.orange[400]),
                                          child: Center(
                                            child: Text(
                                              'D',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                                        .data![0].questions![index].choices![3].id
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: provider
                                      .getStudentQuizResponse!
                                      .data!
                                      .data![0]
                                      .questions![index]
                                      .choices!
                                      .length >
                                  4
                              ? 10
                              : 0,
                        ),
                        provider.getStudentQuizResponse!.data!.data![0]
                                    .questions![index].choices!.length >
                                4
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                        .data![0].questions![index].choices![4].id) {
                                      answers[index].choiceId = 0;
                                    } else {
                                      answers[index].choiceId = provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![4].id;
                                    }
                                  });
                                },
                                onPanStart: (details) {
                                  setState(() {
                                    if (answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                        .data![0].questions![index].choices![4].id) {
                                      answers[index].choiceId = 0;
                                    } else {
                                      answers[index].choiceId = provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![4].id;
                                    }
                                  });
                                },
                                child: Stack(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                            .data![0].questions![index].choices![4].id
                                            ? Colors.orange[400]
                                            : const Color.fromRGBO(
                                                70, 73, 81, 1),
                                      ),
                                      constraints: BoxConstraints.expand(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        height: 60,
                                      ),
                                      child: Center(
                                        child: Text(
                                          provider
                                              .getStudentQuizResponse!
                                              .data!
                                              .data![0]
                                              .questions![index]
                                              .choices![4]
                                              .text!,
                                          style: TextStyle(
                                            color: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                                .data![0].questions![index].choices![4].id
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    AnimatedPositioned(
                                      left: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                          .data![0].questions![index].choices![4].id
                                          ? width - 85
                                          : 5,
                                      top: 5,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: AnimatedRotation(
                                        turns: answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                            .data![0].questions![index].choices![4].id
                                            ? 1
                                            : 0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                                      .data![0].questions![index].choices![4].id
                                                      ? const Color.fromRGBO(
                                                          70, 73, 81, 1)
                                                      : Colors.orange[400]),
                                          child: Center(
                                            child: Text(
                                              'E',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    answers[index].choiceId == provider.getStudentQuizResponse!.data!
                                                        .data![0].questions![index].choices![4].id
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        index + 1 ==
                                provider.getStudentQuizResponse!.data!.data![0]
                                    .questions!.length
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  top: 25,
                                ),
                                child: SizedBox(
                                  width: widgetSize.getWidth(150, context),
                                  height: widgetSize.getHeight(50, context),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.orange[400],
                                      shadowColor: Colors.white70,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          18,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      int studentId = provider.getId();
                                      Map<String, dynamic> map = {
                                        'questions': answers
                                      };
                                      var response =
                                          await Provider.of<AppProvider>(
                                                  context,
                                                  listen: false)
                                              .getStudentQuizMark(widget.quizId,
                                                  studentId, map);
                                      if (await provider.checkInternet()) {
                                        if (response.status == Status.LOADING) {
                                          EasyLoading.showToast(
                                            'Loading...',
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                          );
                                        }
                                        if (response.status == Status.ERROR) {
                                          EasyLoading.showError(
                                              response.message!,
                                              dismissOnTap: true);
                                        }
                                        if (response.status ==
                                            Status.COMPLETED) {
                                          if (response.data != null &&
                                              response.data!.status!) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                           Navigator.pop(context);
                                                           Navigator.pop(context);
                                                           },
                                                        child: Text(
                                                          'OK',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .orange[400],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    title: Text(
                                                      response.data!.message!,
                                                    ),
                                                    content: Text(
                                                      'Your mark is: ${response.data!.mark!.toString()}',
                                                    ),
                                                  );
                                                });
                                            // Navigator.push(
                                            //   context,
                                            //   PageTransition(
                                            //     child:
                                            //         const StudentMainScreen(),
                                            //     type: PageTransitionType
                                            //         .bottomToTopJoined,
                                            //     childCurrent: widget,
                                            //     duration: const Duration(
                                            //         milliseconds: 300),
                                            //   ),
                                            // );
                                          }
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    );
                  });
            case Status.ERROR:
              return err.Error(
                errorMsg: provider.getStudentQuizResponse!.message!,
              );
            default:
              return Container();
          }
        }
        return Container();
      }),
    );
  }
}
