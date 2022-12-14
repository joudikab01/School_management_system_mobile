import 'package:json_annotation/json_annotation.dart';
import 'package:sms_mobile/models/models.dart';

part 'seed.g.dart';

@JsonSerializable()
class Seed{
  @JsonKey(name: 'Academic Years')
  List<AcademicYears>? academicYears;
  List<Bloods>? bloods;
  List<Classes>? classes;
  List<Genders>? genders;
  List<Grades>? grades;
  List<Religions>? religtions;
  List<Nationalities>? nationality;

  Seed({

    this.academicYears,
    this.nationality,
    this.bloods,
    this.classes,
    this.genders,
    this.grades,
    this.religtions
  });

  factory Seed.fromJson(Map<String, dynamic> json) =>
      _$SeedFromJson(json);
  Map<String, dynamic> toJson() => _$SeedToJson(this);

}

@JsonSerializable()
class FSeed{
  bool? status;
  String? message;
  List<Seed>? data;
  FSeed({
    this.message,
    this.status,
    this.data,
});
  factory FSeed.fromJson(Map<String, dynamic> json) =>
      _$FSeedFromJson(json);
  Map<String, dynamic> toJson() => _$FSeedToJson(this);
}

@JsonSerializable()
class Bloods{
  @JsonKey(defaultValue: 0)
  int? id;
  @JsonKey(defaultValue: '')
  String? type;

  Bloods({
    this.id,
    this.type,
  });

  factory Bloods.fromJson(Map<String, dynamic> json) =>
      _$BloodsFromJson(json);
  Map<String, dynamic> toJson() => _$BloodsToJson(this);

}

@JsonSerializable()
class Classes{
  @JsonKey(defaultValue: 0)
  int? id;
  @JsonKey(defaultValue: 0)
  int? grade_id;
  @JsonKey(defaultValue: '')
  String? name;
  List <Classroom>? classroom;

  Classes({
    this.id,
    this.grade_id,
    this.name,
    this.classroom,
  });

  factory Classes.fromJson(Map<String, dynamic> json) =>
      _$ClassesFromJson(json);
  Map<String, dynamic> toJson() => _$ClassesToJson(this);

}

@JsonSerializable()
class Genders{
  @JsonKey(defaultValue: 0)
  int? id;
  @JsonKey(defaultValue: '')
  String? type;

  Genders({
    this.id,
    this.type,
  });

  factory Genders.fromJson(Map<String, dynamic> json) =>
      _$GendersFromJson(json);
  Map<String, dynamic> toJson() => _$GendersToJson(this);

}

@JsonSerializable()
class Grades{
  @JsonKey(defaultValue: 0)
  int? id;
  @JsonKey(defaultValue: '')
  String? name;

  Grades({
    this.id,
    this.name,
  });

  factory Grades.fromJson(Map<String, dynamic> json) =>
      _$GradesFromJson(json);
  Map<String, dynamic> toJson() => _$GradesToJson(this);

}

@JsonSerializable()
class Religions{
  @JsonKey(defaultValue: 0)
  int? id;
  @JsonKey(defaultValue: '')
  String? name;

  Religions({
    this.id,
    this.name,
  });

  factory Religions.fromJson(Map<String, dynamic> json) =>
      _$ReligionsFromJson(json);
  Map<String, dynamic> toJson() => _$ReligionsToJson(this);

}

@JsonSerializable()
class Nationalities{
  @JsonKey(defaultValue: 0)
  int? id;
  @JsonKey(defaultValue: '')
  String? name;

  Nationalities({
    this.id,
    this.name,
  });

  factory Nationalities.fromJson(Map<String, dynamic> json) =>
      _$NationalitiesFromJson(json);
  Map<String, dynamic> toJson() => _$NationalitiesToJson(this);

}






