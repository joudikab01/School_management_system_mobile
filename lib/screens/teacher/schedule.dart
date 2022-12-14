import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_mobile/utill/utill.dart';

import '../../providers/app_provider.dart';

class TeacherSchedule extends StatefulWidget {
  const TeacherSchedule({Key? key}) : super(key: key);

  @override
  State<TeacherSchedule> createState() => _TeacherScheduleState();
}

class _TeacherScheduleState extends State<TeacherSchedule> {
  double _width = 10;
  bool isOpened = false;
  int selectedDay = 1;
  List<Color> color = [
    const Color.fromRGBO(128, 196, 215, 1),
    const Color.fromRGBO(219, 128, 75, 1),
    const Color.fromRGBO(148, 112, 169, 1),
    const Color.fromRGBO(224, 173, 87, 1)
  ];
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
  List<String> startPeriods = [
    '8:00',
    '8:45',
    '9:30',
    '10:30',
    '11:15',
    '12:15',
    '1:00',
    '1:45'
  ];
  List<String> endPeriods = [
    '8:45',
    '9:30',
    '10:15',
    '11:15',
    '12:00',
    '1:00',
    '1:45',
    ''
  ];

  int? classId;
  int? classroomId;

  var timetable = List.generate(
      8,
      (i) => List.filled(
          8,
          TeacherModified(
            className: 'break',
            classroom: '',
            subject: '',
          ),
          growable: false),
      growable: false);
  @override
  initState() {
    int teacherId = Provider.of<AppProvider>(context, listen: false).getId();
    Provider.of<AppProvider>(context, listen: false)
        .getTeacherTimetable(teacherId)
        .then((value) {
      var provider = Provider.of<AppProvider>(context, listen: false)
          .getTeacherTimetableResponse;

      for (int i = 0; i < provider!.data!.teacherTimetable!.length; i++) {
        timetable[provider.data!.teacherTimetable![i].lesson!.days!.id!]
                [provider.data!.teacherTimetable![i].lesson!.lessons!.id!] =
            TeacherModified(
                className: provider
                    .data!.teacherTimetable![i].classroom!.classes!.name,
                classroom: provider
                    .data!.teacherTimetable![i].classroom!.classrooms!.name
                    .toString(),
                subject: provider.data!.teacherTimetable![i].subject!.name);
      }

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                width: _width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black87,
                duration: const Duration(milliseconds: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedDay = 2;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          color: selectedDay == 2
                              ? Colors.orange[400]
                              : Colors.grey[800],
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        constraints: BoxConstraints.expand(
                          width: isOpened ? 40 : 0,
                          height: 40,
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'S',
                              style: TextStyle(
                                  color: selectedDay == 2
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'ChakraPetch'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedDay = 3;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          color: selectedDay == 3
                              ? Colors.orange[400]
                              : Colors.grey[800],
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        constraints: BoxConstraints.expand(
                          width: isOpened ? 40 : 0,
                          height: 40,
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'M',
                              style: TextStyle(
                                color: selectedDay == 3
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ChakraPetch',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedDay = 4;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          color: selectedDay == 4
                              ? Colors.orange[400]
                              : Colors.grey[800],
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        constraints: BoxConstraints.expand(
                          width: isOpened ? 40 : 0,
                          height: 40,
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'T',
                              style: TextStyle(
                                color: selectedDay == 4
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ChakraPetch',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedDay = 5;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          color: selectedDay == 5
                              ? Colors.orange[400]
                              : Colors.grey[800],
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        constraints: BoxConstraints.expand(
                          width: isOpened ? 40 : 0,
                          height: 40,
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'W',
                              style: TextStyle(
                                color: selectedDay == 5
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ChakraPetch',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedDay = 6;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          color: selectedDay == 6
                              ? Colors.orange[400]
                              : Colors.grey[800],
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        constraints: BoxConstraints.expand(
                          width: isOpened ? 40 : 0,
                          height: 40,
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'T',
                              style: TextStyle(
                                color: selectedDay == 6
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ChakraPetch',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedDay = 7;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          color: selectedDay == 7
                              ? Colors.orange[400]
                              : Colors.grey[800],
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        constraints: BoxConstraints.expand(
                          width: isOpened ? 40 : 0,
                          height: 40,
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'F',
                              style: TextStyle(
                                color: selectedDay == 7
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ChakraPetch',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedDay = 1;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          color: selectedDay == 1
                              ? Colors.orange[400]
                              : Colors.grey[800],
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        constraints: BoxConstraints.expand(
                          width: isOpened ? 40 : 0,
                          height: 40,
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'S',
                              style: TextStyle(
                                color: selectedDay == 1
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ChakraPetch',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onHorizontalDragEnd: (_) {
                  setState(() {
                    if (isOpened) {
                      _width = 10;
                      isOpened = false;
                    } else {
                      _width = 80;
                      isOpened = true;
                    }
                  });
                },
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: isOpened ? 5.0 : 0),
                          child: const RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              'Schedule',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: isOpened ? 4.0 : 0,
                              right: isOpened ? 0 : 8),
                          child: AnimatedRotation(
                            turns: isOpened ? 0 : 0.5,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                    'Schedule',
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
                  Consumer<AppProvider>(
                    builder: (context, provider, child) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 20),
                          shrinkWrap: true,
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        startPeriods[index],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            fontFamily: 'ChakraPetch'),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        endPeriods[index],
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            fontFamily: 'ChakraPetch'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  AnimatedContainer(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                        color: color[index % 4]),
                                    constraints: BoxConstraints.expand(
                                      height: 150,
                                      width: isOpened
                                          ? widgetSize.getWidth(290, context) -
                                              80
                                          : widgetSize.getWidth(290, context),
                                    ),
                                    duration: const Duration(milliseconds: 200),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //class
                                        Text(
                                          timetable[selectedDay][index + 1]
                                              .className!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'ChakraPetch',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        //classroom
                                        Text(
                                          timetable[selectedDay][index + 1]
                                              .classroom!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 26,
                                            fontFamily: 'ChakraPetch',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Text(
                                          'In Class',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'ChakraPetch',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 15,
                                                backgroundImage: NetworkImage(
                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQkqF4GNbddpeM38Iq_ac9DyUcRr7VXkVVAmQcgyi6Xv6F5bcf3mlZOUxm47kO7UYuBIg&usqp=CAU'),
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                timetable[selectedDay][index + 1].subject!,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontFamily: 'ChakraPetch',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TeacherModified {
  String? className;
  String? classroom;
  String? subject;
  TeacherModified({
    this.classroom,
    this.className,
    this.subject,
  });
}
