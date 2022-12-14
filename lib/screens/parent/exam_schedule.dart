import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sms_mobile/providers/providers.dart';
import 'package:sms_mobile/utill/utill.dart';
import '../../components/error.dart' as err;

import '../../services/api_response.dart';

class ParentExamSchedule extends StatefulWidget {
  final int studentId;
  const ParentExamSchedule({required this.studentId, Key? key})
      : super(key: key);

  @override
  State<ParentExamSchedule> createState() => _ParentExamScheduleState();
}

class _ParentExamScheduleState extends State<ParentExamSchedule> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  int? classId;

  @override
  initState() {
    Provider.of<AppProvider>(context, listen: false)
        .getStudent(widget.studentId)
        .then((value) {
      classId = value.data!.student![0].class_classroom!.class_id;
      Provider.of<AppProvider>(context, listen: false).getClassExam(classId!);
    });

    super.initState();
  }

  List<Color> cardColor = [
    const Color.fromRGBO(242, 216, 199, 1),
    const Color.fromRGBO(244, 230, 202, 1),
    const Color.fromRGBO(225, 174, 86, 1),
    const Color.fromRGBO(148, 111, 169, 1)
  ];
  int containerColor = -1;
  int selectedTab = 0;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          12.0,
        ),
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
            if (provider.getClassExamResponse?.data?.exams != null) {
              switch (provider.getClassExamResponse!.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange[400],
                    ),
                  );
                case Status.COMPLETED:
                  var exams = provider.getClassExamResponse!.data!.exams;
                  return Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                            ),
                          ),
                          Expanded(
                            child: Column(
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
                        height: 30,
                      ),
                      const Text(
                        'Exam Schedule',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontFamily: 'Orbitron',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        height: 2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: widgetSize.getHeight(100, context),
                        child: ListView.builder(
                          itemCount: provider
                              .getClassExamResponse!.data!.exams!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTab = index;
                                  itemScrollController.scrollTo(
                                      index: index,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOutCubic);
                                  containerColor = index;
                                  Future.delayed(
                                      const Duration(
                                        seconds: 3,
                                      ), () {
                                    setState(() {
                                      containerColor = -1;
                                    });
                                  });
                                  // itemScrollController.jumpTo(index: index);
                                });
                              },
                              child: SizedBox(
                                width: widgetSize.getWidth(
                                  60,
                                  context,
                                ),
                                height: widgetSize.getHeight(
                                  110,
                                  context,
                                ),
                                child: Card(
                                  borderOnForeground: false,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  elevation: selectedTab == index ? 3 : 0,
                                  color: selectedTab == index
                                      ? Colors.orange
                                      : const Color.fromARGB(
                                          1,
                                          250,
                                          250,
                                          250,
                                        ).withOpacity(0.9),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        provider.getClassExamResponse!.data!
                                            .exams![index].start!.day
                                            .toString(),
                                        style: TextStyle(
                                          color: selectedTab == index
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                      // Text(
                                      //   '/',
                                      //   style: TextStyle(
                                      //     color: selectedTab == index
                                      //         ? Colors.white
                                      //         : Colors.grey,
                                      //   ),
                                      // ),
                                      Text(
                                        provider.getClassExamResponse!.data!
                                            .exams![index].start!.month
                                            .toString(),
                                        style: TextStyle(
                                          color: selectedTab == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Visibility(
                                        visible: selectedTab == index,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: ScrollablePositionedList.builder(
                          itemCount: exams!.length,
                          itemPositionsListener: itemPositionsListener,
                          itemScrollController: itemScrollController,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: widgetSize.getWidth(240, context),
                              height: widgetSize.getHeight(180, context),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  SizedBox(
                                    width: widgetSize.getWidth(200, context),
                                    height:
                                        widgetSize.getHeight(140, context),
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          15,
                                        ),
                                      ),
                                      color: index % 4 == 0
                                          ? cardColor[0]
                                          : index % 4 == 1
                                              ? cardColor[1]
                                              : index % 4 == 2
                                                  ? cardColor[2]
                                                  : cardColor[3],
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      exams[index]
                                                          .subject_mark!
                                                          .subject!
                                                          .name!,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // SizedBox(
                                                //   width: 20,
                                                //   height: 20,
                                                //   child: IconButton(
                                                //     onPressed: () {
                                                //       print('pressed');
                                                //       Navigator.push(
                                                //         context,
                                                //         PageTransition(
                                                //           child: ExamScreen(
                                                //             examId:
                                                //                 exams[index]
                                                //                     .id!,
                                                //           ),
                                                //           type: PageTransitionType
                                                //               .leftToRightPop,
                                                //           childCurrent:
                                                //               widget,
                                                //           duration:
                                                //               const Duration(
                                                //                   milliseconds:
                                                //                       400),
                                                //         ),
                                                //       );
                                                //     },
                                                //     icon: const Icon(
                                                //       Icons.arrow_forward_ios,
                                                //       color: Colors.white,
                                                //       size: 12,
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Start date: ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w900,
                                                  ),
                                                ),
                                                Text(
                                                  "${exams[index].start!.year.toString()}-${exams[index].start!.month.toString()}-${exams[index].start!.day.toString()} ${exams[index].start!.hour.toString()}:${exams[index].start!.minute.toString()}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Duration: ",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${exams[index].end!.difference(exams[index].start!).inMinutes} minutes",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Mark: ",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Mark: ${provider.getClassExamResponse!.data!.exams![index].mark!}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: containerColor == index
                                          ? Colors.grey[100]?.withOpacity(0.8)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    width: widgetSize.getWidth(240, context),
                                    height:
                                        widgetSize.getHeight(180, context),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          top: 16, right: 8),
                                      child: SizedBox(
                                        width: 0,
                                        height: 0,
                                      ),
                                      // child: IconButton(
                                      //   onPressed: () {
                                      //     // Navigator.push(
                                      //     //   context,
                                      //     //   PageTransition(
                                      //     //     child: ExamScreen(
                                      //     //       examId: exams[index].id!,
                                      //     //     ),
                                      //     //     type: PageTransitionType
                                      //     //         .leftToRightPop,
                                      //     //     childCurrent: widget,
                                      //     //     duration: const Duration(
                                      //     //         milliseconds: 400),
                                      //     //   ),
                                      //     // );
                                      //   },
                                      //   icon: const Icon(
                                      //     Icons.arrow_forward_ios,
                                      //     color: Colors.white,
                                      //     size: 18,
                                      //   ),
                                      //   alignment: Alignment.topRight,
                                      // ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                case Status.ERROR:
                  return err.Error(
                    errorMsg: provider.getStudentExamResponse!.message!,
                  );
                default:
                  return Container();
              }
            }
            return const err.Error(errorMsg: 'not found',);
          },
        ),
      ),
    );
  }
}
