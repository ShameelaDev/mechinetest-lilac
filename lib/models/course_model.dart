class Course {
  final int universityId;
  final String courseTitle;
  final String courseFee;
  final List<String> images;
  final String country;
  final String? state;
  final String? city;
  final String universityName;
  final int courseId;

  Course({
    required this.universityId,
    required this.courseTitle,
    required this.courseFee,
    required this.images,
    required this.country,
    this.state,
    this.city,
    required this.universityName,
    required this.courseId,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      universityId: json['universityId'],
      courseTitle: json['courseTitle'],
      courseFee: json['courseFee'] ?? '', 
      images: List<String>.from(json['images'] ?? []), 
      country: json['Country'],
      state: json['State'],
      city: json['city'],
      universityName: json['universityName'],
      courseId: json['courseId'],
    );
  }
}

class CourseResponse {
  final bool status;
  final String message;
  final List<Course> data;

  CourseResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList(),
    );
  }
}
