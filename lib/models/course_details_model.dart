class CourseDetailsResponse {
  final bool status;
  final String message;
  final CourseData? data;


  CourseDetailsResponse({
    required this.status,
    required this.message,
    this.data,
  
  });

  factory CourseDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CourseDetailsResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? 'No message',
      data: json['data'] != null ? CourseData.fromJson(json['data']) : null,
    );
  }
}

class CourseData {
  final int courseId;
  final String courseName;
  final String courseDescription;
  final String courseSyllabus;
  final String? courseSyllabusPdf;
  final String courseLevel;
  final String courseSubject;
  final String courseDuration;
  final String totalFee;
  final List<CourseIntake> courseIntakes;
  final int universityId;
  final String universityName;
  final String universityCountry;
  final String? universityState;
  final String? universityCity;
  final String universityEstablishedYear;
  final String universityRank;
  final String? universityBrochure;
  final String aboutUniversity;
  final String? logoImage;
  final String? placement;

  CourseData({
    required this.courseId,
    required this.courseName,
    required this.courseDescription,
    required this.courseSyllabus,
    this.courseSyllabusPdf,
    required this.courseLevel,
    required this.courseSubject,
    required this.courseDuration,
    required this.totalFee,
    required this.courseIntakes,
    required this.universityId,
    required this.universityName,
    required this.universityCountry,
    this.universityState,
    this.universityCity,
    required this.universityEstablishedYear,
    required this.universityRank,
    this.universityBrochure,
    required this.aboutUniversity,
    this.logoImage,
    this.placement,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      courseId: json['courseId'] ?? 0,
      courseName: json['courseName'] ?? 'Unknown Course',
      courseDescription: json['courseDescription'] ?? 'No description available',
      courseSyllabus: json['courseSyllabus'] ?? 'No syllabus available',
      courseSyllabusPdf: json['courseSyllabusPdf'],
      courseLevel: json['courseLevel'] ?? 'Unknown level',
      courseSubject: json['courseSubject'] ?? 'Unknown subject',
      courseDuration: json['CourseDuration'] ?? 'Unknown duration',
      totalFee: json['totalFee'] ?? 'N/A',
      courseIntakes: (json['courseIntaks'] as List<dynamic>?)
              ?.map((e) => CourseIntake.fromJson(e))
              .toList() ??
          [],
          universityId: json['universityId'] ?? 0,
      universityName: json['universityName'] ?? 'Unknown university',
      universityCountry: json['universityCountry'] ?? 'Unknown country',
      universityState: json['universityState'],
      universityCity: json['universityCity'],
      universityEstablishedYear:
          json['universityEstablishedYear'] ?? 'Unknown year',
      universityRank: json['universityRank'] ?? 'N/A',
      universityBrochure: json['universityBrochure'],
      aboutUniversity: json['aboutUniversity'] ?? 'No details available',
      logoImage: json['logoImage'],
      placement: json['placement'],
    );
  }
}

class CourseIntake {
  final int id;
  final String courseId;
  final String intakeDate;
  final String intakeDurationDate;

  CourseIntake({
    required this.id,
    required this.courseId,
    required this.intakeDate,
    required this.intakeDurationDate,
  });

  factory CourseIntake.fromJson(Map<String, dynamic> json) {
    return CourseIntake(
      id: json['id'] ?? 0,
      courseId: json['courseId'] ?? 'Unknown',
      intakeDate: json['intakeDate'] ?? 'Unknown',
      intakeDurationDate: json['intakeDurationDate'] ?? 'Unknown',
    );
  }
}