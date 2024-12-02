import 'package:flutter/material.dart';
import 'package:mechinetest/models/course_details_model.dart';
import 'package:mechinetest/service/auth_service.dart';
import 'package:mechinetest/service/course_service.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CourseService courseService = CourseService();
    AuthService authService = AuthService();

    const int courseId = 25;
    const int universityId = 12;

    Future<String?> token = authService.getAccessToken();

    return Scaffold(
      appBar: AppBar(title: const Text("Course Details")),
      body: FutureBuilder<CourseDetailsResponse>(
        future: courseService.fetchCourseDetails(token, courseId, universityId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final courseData = snapshot.data!.data;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Container(
                                color: Colors.indigo[50],
                                child: Image.asset(
                                  "asset/images/img.png",
                                  height: 180,
                                  width: double.infinity,
                                ))
                            /* Image.network(
              course.images.isNotEmpty
                  ? course.images[0]
                  : 'https://via.placeholder.com/150',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),*/
                            ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_circle_left_outlined))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      courseData!.courseName,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(children: [
                      Icon(
                        Icons.assured_workload_outlined,
                        color: Colors.indigo[200],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        courseData.universityName,
                        style: TextStyle(
                          color: Colors.indigo[200],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    Text(
                      courseData.courseDescription,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    _buildSectionHeader("Eligibility", Icons.check_circle,
                        const Color.fromARGB(255, 245, 57, 119)),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildInfoRow("HSE or SSE: 60"),
                    const SizedBox(height: 10),
                    _buildInfoRow("IELTS: 60 / English for HSE or SSE: 65"),
                    const SizedBox(height: 20),
                    Divider(),
                    const SizedBox(height: 20),
                    _buildSectionHeader("course duration", Icons.check_circle,
                        const Color.fromARGB(255, 245, 57, 119)),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildInfoRow(
                      courseData.courseDuration,
                    ),
                    const SizedBox(height: 20),
                    Divider(),
                    const SizedBox(height: 20),
                    _buildSectionHeader("course intakes", Icons.info,
                        const Color.fromARGB(255, 245, 57, 119)),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      _buildInfoRow(courseData.courseIntakes[0].intakeDate),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildInfoRow(courseData.courseIntakes[1].intakeDate),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildSectionHeader("University", Icons.apartment,
                        const Color.fromARGB(255, 245, 57, 119)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      courseData.universityName,
                      style: TextStyle(
                        color: Colors.indigo[200],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      courseData.courseDescription,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Icon(Icons.add_location_alt_rounded),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(courseData.universityCity!)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_city),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(courseData.universityState!)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                launchUrl(
                                    Uri.parse(courseData.universityBrochure!));
                              },
                              icon: Icon(Icons.download)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Download university Brochure",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildSectionHeader(
                        "Course syllabus",
                        Icons.menu_book_sharp,
                        const Color.fromARGB(255, 245, 57, 119)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(courseData.courseSyllabus),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                launchUrl(
                                    Uri.parse(courseData.courseSyllabusPdf!));
                              },
                              icon: Icon(Icons.download)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Download cousre syllubus",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildSectionHeader("Placement", Icons.monetization_on,
                        const Color.fromARGB(255, 245, 57, 119)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(courseData.placement!),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildSectionHeader("Total fees", Icons.monetization_on,
                        const Color.fromARGB(255, 245, 57, 119)),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          courseData.totalFee,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo[800]),
                          child: Text(
                            "Get Admission",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('No course details available'));
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 30,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
