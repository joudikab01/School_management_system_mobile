import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../providers/providers.dart';
import '../../services/api_response.dart';
import '../../utill/utill.dart';
import '../../components/components.dart';
import '../../models/models.dart';
import '../screens.dart';
import '../../screens/student/exam_schedule.dart' as ex;

class SelectChild extends StatefulWidget {
  final int id;
  const SelectChild({required this.id, Key? key}) : super(key: key);

  @override
  State<SelectChild> createState() => _SelectChildState();
}

class _SelectChildState extends State<SelectChild> {
  @override
  initState() {
    Provider.of<AppProvider>(context, listen: false).getParentChild(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Choose child'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTopJoined,
                childCurrent: widget,
                duration: const Duration(milliseconds: 300),
                child: const ParentMainScreen(),
              ),
            );
          },
        ),
      ),
      body: Consumer<AppProvider>(builder: (context, provider, child) {
        if (provider.getParentChildResponse != null) {
          var response = provider.getParentChildResponse;
          switch (response?.status) {
            case Status.LOADING:
              return Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: CircularProgressIndicator(color: Colors.orange[400],)
              );
            case Status.ERROR:
              return Error(
                errorMsg: response!.message!,
              );
            case Status.COMPLETED:
              return Container(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  itemCount: response!.data!.parent![0].child!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: widgetSize.getWidth(200, context) /
                        widgetSize.getHeight(300, context),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: ex.StudentExamSchedule(
                                studentId: provider.getParentChildResponse!
                                    .data!.parent![0].child![index].id!,
                              ),
                              type: PageTransitionType.leftToRightPop,
                              childCurrent: widget,
                              duration: const Duration(milliseconds: 400),
                            ),
                          );
                        },
                        child: StudentSmallCard(
                          student: provider.getParentChildResponse!.data!
                              .parent![0].child![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            default:
              return Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(
                  ));
          }
        }
        return Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(
            ));
      }),
    );
  }
}
