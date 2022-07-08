import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/models.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1:8000/api/')
abstract class ApiService {
  factory ApiService(Dio dio, {BuildContext? context, String? baseUrl}) {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // options.connectTimeout = 60000;
      // options.receiveTimeout = 60000;
      return handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      return handler.next(response);
    }, onError: (DioError error, ErrorInterceptorHandler handler) async {
      if (error.response?.statusCode == 401) {}
      return handler.next(error);
    }));
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
    return _ApiService(dio, baseUrl: baseUrl);
  }
  //all teachers
  @GET('teacher/all')
  Future<FTeacher> getAllTeachers();

  //all students
  @GET('student/all')
  Future<FStudent> getAllStudents();

  //all mentors
  @GET('mentor/all')
  Future<FMentor> getAllMentors();

  //all classrooms
  @GET('classroom/all')
  Future<FClassroom> getAllClassrooms();

  //all authentication
  @POST('general/login')
  Future<Auth> login(@Body() FormData formData);

  //all subjects
  @GET('subject/all')
  Future<FSubject> getAllSubjects();

  //add subject
  @POST('subject/add')
  Future<FSubject> addSubject(@Body() FormData formData);

  //edit subject
  @POST('subject/edit/{id}')
  Future<FSubject> editSubject(@Body() FormData formData, @Path('id') int id);

  //delete subject
  @DELETE('subject/delete/{id}')
  Future deleteSubject(@Path('id') int id);

  //show student
  @GET('student/show/{id}')
  Future<FStudent> getStudent(@Path('id') int id);

  //show teacher
  @GET('teacher/show/{id}')
  Future<FTeacher> getTeacher(@Path('id') int id);

  //show mentor
  @GET('mentor/show/{id}')
  Future<FMentor> getMentor(@Path('id') int id);

  //get seed
  @GET('general/allSeed')
  Future<FSeed> getSeed();

  //get all exams
  @GET('exam/all')
  Future<FExam> getAllExams();

//get all syllabi
  @GET('syllabi/all')
  Future<FSyllabi> getAllSyllabi();
}
