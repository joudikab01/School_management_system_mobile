import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sms_mobile/screens/screens.dart';
import 'package:sms_mobile/utill/utill.dart';

import '../../providers/app_provider.dart';
import '../../services/api_response.dart';
import '../../components/error.dart' as er;

class MentorProfilePage extends StatefulWidget {
  const MentorProfilePage({Key? key}) : super(key: key);

  @override
  State<MentorProfilePage> createState() => _MentorProfilePageState();
}

class _MentorProfilePageState extends State<MentorProfilePage> {
  @override
  initState() {
    final id = Provider.of<AppProvider>(context, listen: false).getId();
    Provider.of<AppProvider>(context, listen: false).getMentor(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Mentor Profile'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.getMentorResponse != null) {
            switch (provider.getMentorResponse?.status) {
              case Status.LOADING:
                return Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child:  CircularProgressIndicator(
                    color: Colors.orange[400],
                  ),
                );
              case Status.ERROR:
                return er.Error(
                  errorMsg: provider.getMentorResponse!.message!,
                );
              case Status.COMPLETED:
                final mentor = provider.getMentorResponse!.data!.mentor![0];
                return Stack(
                  children: [
                    Container(
                      height: widgetSize.getHeight(500, context),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: const AssetImage(
                            'assets/mentor.png',
                          ),
                          colorFilter: ColorFilter.mode(
                            Colors.black54.withOpacity(0.7),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      // child: Image.asset(
                      //   widget.teacher.picture!,
                      // ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: widgetSize.getHeight(
                          250,
                          context,
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              35,
                            ),
                            topRight: Radius.circular(
                              35,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            // top: widgetSize.getHeight(
                            //   30,
                            //   context,
                            // ),
                          ),
                          child: ListView(
                            children: [
                              const Text(
                                "Mentor's Information",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              //email
                              Text(
                                "Email: ${mentor.email}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              //code
                              Text(
                                "Code: ${mentor.code}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Address ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              //City
                              Text(
                                "City: ${mentor.address!.city}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              //Town
                              Text(
                                "Town: ${mentor.address!.town}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              //Street
                              Text(
                                "Street: ${mentor.address!.street}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Work info ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              //Class
                              Text(
                                "Class: ${mentor.classes!.name}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              //joining date
                              Text(
                                "Joining Date: ${mentor.joining_date}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Personal info ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              //Phone
                              Text(
                                "Phone: ${mentor.phone} ",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 240,
                      right: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //name
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Text(
                              "${mentor.f_name} ${mentor.l_name}",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(),
                            child: Text(
                              'Mentor',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: widgetSize.getHeight(
                            190,
                            context,
                          ),
                          left: 45),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          'assets/mentor.png',
                        ),
                        radius: 60,
                      ),
                    ),
                  ],
                );
              default:
                return Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(),
                );
            }
          }
          return Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(),
          );
        },
      ),
    );
  }
}
