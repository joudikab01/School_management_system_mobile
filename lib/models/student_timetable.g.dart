// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentTimeTable _$StudentTimeTableFromJson(Map<String, dynamic> json) =>
    StudentTimeTable(
      id: json['id'] as int? ?? 0,
      teacher_id: json['teacher_id'] as int? ?? 0,
      classClassroom_id: json['classClassroom_id'] as int? ?? 0,
      lesson: json['lesson'] == null
          ? null
          : Lesson.fromJson(json['lesson'] as Map<String, dynamic>),
      lessonDay_id: json['lessonDay_id'] as int? ?? 0,
      subject: json['subject'] == null
          ? null
          : Subject.fromJson(json['subject'] as Map<String, dynamic>),
      teacher: json['teacher'] == null
          ? null
          : StudentTeacher.fromJson(json['teacher'] as Map<String, dynamic>),
      subject_id: json['subject_id'] as int? ?? 0,
    );

Map<String, dynamic> _$StudentTimeTableToJson(StudentTimeTable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonDay_id': instance.lessonDay_id,
      'classClassroom_id': instance.classClassroom_id,
      'teacher_id': instance.teacher_id,
      'subject_id': instance.subject_id,
      'lesson': instance.lesson,
      'subject': instance.subject,
      'teacher': instance.teacher,
    };

FStudentTimeTable _$FStudentTimeTableFromJson(Map<String, dynamic> json) =>
    FStudentTimeTable(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      studentTimetable: (json['studentTimetable'] as List<dynamic>?)
          ?.map((e) => StudentTimeTable.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FStudentTimeTableToJson(FStudentTimeTable instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'studentTimetable': instance.studentTimetable,
    };
