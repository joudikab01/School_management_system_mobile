import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sms_mobile/providers/providers.dart';
import 'package:sms_mobile/screens/screens.dart';
import '../services/api_response.dart';
import '../utill/utill.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  late final FocusNode _firstNameFocusNode;
  late final FocusNode _lastNameFocusNode;
  late final FocusNode _codeFocusNode;
  bool isHidden = true;

  @override
  void initState() {
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _codeFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: widgetSize.getWidth(200, context),
                height: widgetSize.getHeight(200, context),
                child: SvgPicture.asset(
                  'assets/login2.svg',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Welcome to our system',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (String? text) {
                              if (text == null || text == '' || text.isEmpty) {
                                return 'Can\'t be empty';
                              }
                              if (text.length < 2) {
                                return 'too short';
                              }
                              return null;
                            },
                            controller: _firstNameController,
                            focusNode: _firstNameFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            textDirection: TextDirection.ltr,
                            showCursor: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                            ),
                            cursorColor: Color.fromARGB(255, 255, 167, 38,),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (String? text) {
                              if (text == null || text == '' || text.isEmpty) {
                                return 'Can\'t be empty';
                              }
                              if (text.length < 2) {
                                return 'too short';
                              }
                              return null;
                            },
                            controller: _lastNameController,
                            focusNode: _lastNameFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            textDirection: TextDirection.ltr,
                            showCursor: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color:Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                            ),
                            cursorColor: const Color.fromARGB(255, 255, 167, 38,),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: isHidden,
                            validator: (String? text) {
                              if (text == null || text == '' || text.isEmpty) {
                                return 'Can\'t be empty';
                              }
                              if (text.length < 8) {
                                return 'too short';
                              }
                              if (text.contains(' ') == true) {
                                return 'Invalid code format';
                              }
                              return null;
                            },
                            controller: _codeController,
                            focusNode: _codeFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            textDirection: TextDirection.ltr,
                            showCursor: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isHidden
                                      ? Icons.remove_red_eye_rounded
                                      : Icons.remove_red_eye_outlined,
                                  color: const Color.fromARGB(255, 255, 167, 38,),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isHidden = !isHidden;
                                  });
                                },
                              ),
                              hintText: 'Code',
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color:Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 255, 167, 38,),
                                ),
                              ),
                            ),
                            cursorColor: Color.fromARGB(255, 255, 167, 38,),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: widgetSize.getWidth(140, context),
                      height: widgetSize.getHeight(60, context),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                20,
                              ),
                            ),
                          ),
                          elevation: 3,
                          primary: Color.fromARGB(255, 255, 167, 38,),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _firstNameFocusNode.unfocus();
                            _lastNameFocusNode.unfocus();
                            _codeFocusNode.unfocus();
                            final provider = Provider.of<AppProvider>(context,
                                listen: false);
                            if (await provider.checkInternet()) {
                              var response = await Provider.of<AppProvider>(
                                      context,
                                      listen: false)
                                  .login(
                                      _firstNameController.text,
                                      _lastNameController.text,
                                      _codeController.text);
                              if (response.status == Status.LOADING) {
                                EasyLoading.showToast(
                                  'Loading...',
                                  duration: const Duration(
                                    milliseconds: 300,
                                  ),
                                );
                              }
                              if (response.status == Status.ERROR) {
                                EasyLoading.showError(response.message!,
                                    dismissOnTap: true);
                              }
                              if (response.status == Status.COMPLETED) {
                                if (response.data != null &&
                                    response.data!.status!) {
                                  EasyLoading.showSuccess(
                                      response.data!.message!,
                                      dismissOnTap: true);
                                  print(response.data!.key!.token.toString());
                                  provider.setToken(
                                      response.data!.key!.token.toString());
                                  provider.setToken(response.data!.key!.token!);
                                  print(provider.getToken());
                                  provider.setId(response.data!.id!);
                                  provider.setRole(response.data!.role!);
                                  final role = response.data!.role!;
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: role == 'teacher'
                                          ? const TeacherMainScreen()
                                          : role == 'parent'
                                              ? const ParentMainScreen()
                                              : role == 'student'
                                                  ? const StudentMainScreen()
                                                  : role == 'mentor'
                                                      ? const MentorMainScreen()
                                                      : const MainScreen(),
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
                          }
                        },
                        // },
                        child: const Text(
                          'Log In',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }
}
