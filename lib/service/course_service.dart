import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mechinetest/models/course_details_model.dart';
import 'package:mechinetest/models/course_model.dart';

class CourseService {
  static Future<CourseResponse> fetchCourses(String token) async {
    final url = Uri.parse(
            'https://test.gslstudent.lilacinfotech.com/api/landing/home/featuredCourse')
        .replace(queryParameters: {'skipValue': '10'});

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        final responseBody = json.decode(response.body);
        return CourseResponse.fromJson(responseBody);
      } catch (e) {
        throw Exception('Invalid JSON response from server');
      }
    } else {
      throw Exception('Failed to load courses. Status: ${response.statusCode}');
    }
  }

  Future<CourseDetailsResponse> fetchCourseDetails(
      Future<String?> token, int courseId, int universityId) async {
    String? resolvedToken = await token;

    if (resolvedToken == null) {
      throw Exception('No token available');
    }
    final url = Uri.parse(
            'https://test.gslstudent.lilacinfotech.com/api/lead/course/SearchPopularSingleCourseFinding')
        .replace(queryParameters: {
      'id': courseId.toString(),
      'universityId': universityId.toString(),
    });

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return CourseDetailsResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load course details');
    }
  }
}
