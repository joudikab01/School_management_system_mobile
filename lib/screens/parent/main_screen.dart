import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sms_mobile/providers/providers.dart';
import '../../models/boxes.dart';
import '../../services/api_response.dart';
import '../screens.dart';

class ParentMainScreen extends StatefulWidget {
  const ParentMainScreen({Key? key}) : super(key: key);

  @override
  State<ParentMainScreen> createState() => _ParentMainScreenState();
}

class _ParentMainScreenState extends State<ParentMainScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onDoubleTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Log Out'),
                      content: const Text(
                        'Are you sure you want to log out?',
                      ),
                      elevation: 2,
                      actions: [
                        TextButton(
                          onPressed: () async {
                            final provider = Provider.of<AppProvider>(context,
                                listen: false);
                            String token = provider.getToken();
                            if (await provider.checkInternet()) {
                              var response = await Provider.of<AppProvider>(
                                  context,
                                  listen: false)
                                  .logout('Bearer $token');
                              if (response.status == Status.LOADING) {
                                EasyLoading.showToast(
                                  'Loading...',
                                  duration: const Duration(
                                    milliseconds: 300,
                                  ),
                                );
                              }
                              if (response.status == Status.ERROR) {
                                EasyLoading.showError(response.data!.message!,
                                    dismissOnTap: true);
                              }
                              if (response.status == Status.COMPLETED) {
                                if (response.data != null ) {
                                  var box = Boxes.getAuthBox();
                                  await box.clear();
                                  EasyLoading.showSuccess(
                                      response.data!.message!,
                                      dismissOnTap: true);
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: const LoginScreen(),
                                      type:
                                      PageTransitionType.bottomToTopJoined,
                                      childCurrent: widget,
                                      duration:
                                      const Duration(milliseconds: 300),
                                    ),
                                  );
                                }

                              }
                            } else {
                              EasyLoading.showError('No Internet Connection',
                                  dismissOnTap: true);
                            }
                          },
                          child: Text(
                            'Log out',
                            style: TextStyle(
                              color: Colors.orange[300],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.orange[300],),
                          ),
                        ),
                      ],
                    );
                  });
            },
            child: Image.asset(
              'assets/icons/gear.png',
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        title: const Text(
          'Main Screen',
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: GridView.count(
        padding:
            const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 30),
        crossAxisCount: 2,
        children: [
          //profile
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const ParentProfilePage(),
                  type: PageTransitionType.leftToRightPop,
                  childCurrent: widget,
                  duration: const Duration(milliseconds: 400),
                ),
              );
            },
            child: Card(
                elevation: 3,
                shadowColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/user-2.png',
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                )),
          ),
          //quiz
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: QuizSchedule(
                    studentId: Provider.of<AppProvider>(context, listen: false)
                        .getId(),
                    isStudent: false,
                  ),
                  type: PageTransitionType.leftToRightPop,
                  childCurrent: widget,
                  duration: const Duration(milliseconds: 400),
                ),
              );
            },
            child: Card(
                elevation: 3,
                shadowColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/homework 2.png',
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Quiz',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                )),
          ),
          //exam schedule
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: ParentExamSchedule(
                    studentId: Provider.of<AppProvider>(context, listen: false)
                        .getId(),
                  ),
                  type: PageTransitionType.leftToRightPop,
                  childCurrent: widget,
                  duration: const Duration(milliseconds: 400),
                ),
              );
            },
            child: Card(
                elevation: 3,
                shadowColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/exam.png',
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Exam',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                )),
          ),
          //marks
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: Resultants(
                    studentId: Provider.of<AppProvider>(context, listen: false)
                        .getId(),
                    isParent: true,
                  ),
                  type: PageTransitionType.leftToRightPop,
                  childCurrent: widget,
                  duration: const Duration(milliseconds: 400),
                ),
              );
            },
            child: Card(
                elevation: 3,
                shadowColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/score.png',
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Marks',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                )),
          ),
          //schedule
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const StudentSchedule(),
                  type: PageTransitionType.leftToRightPop,
                  childCurrent: widget,
                  duration: const Duration(milliseconds: 400),
                ),
              );
            },
            child: Card(
                elevation: 3,
                shadowColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/schedule.png',
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Schedule',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                )),
          ),
          //announcements
          // Card(
          //     elevation: 3,
          //     shadowColor: Colors.black,
          //     shape: const RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(16),
          //       ),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.only(
          //           top: 20, left: 20, right: 20, bottom: 10),
          //       child: Column(
          //         children: [
          //           Image.asset(
          //             'assets/icons/megaphone.png',
          //             height: 100,
          //           ),
          //           const SizedBox(
          //             height: 20,
          //           ),
          //           const Text(
          //             'Announcement',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w600,
          //               fontSize: 18,
          //             ),
          //           )
          //         ],
          //       ),
          //     )),
          //attendance
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const ParentAttendanceScreen(),
                  type: PageTransitionType.leftToRightPop,
                  childCurrent: widget,
                  duration: const Duration(milliseconds: 400),
                ),
              );
            },
            child: Card(
                elevation: 3,
                shadowColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/attendance.png',
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Attendance',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                )),
          ),
          //syllabi
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child:  const ShowSyllabi(isStudent: false,),
                  type: PageTransitionType.leftToRightPop,
                  childCurrent: widget,
                  duration: const Duration(milliseconds: 400),
                ),
              );
            },
            child: Card(
                elevation: 3,
                shadowColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/books.png',
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Syllabi',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
