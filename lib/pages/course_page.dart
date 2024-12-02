import 'package:flutter/material.dart';
import 'package:mechinetest/models/course_model.dart';
import 'package:mechinetest/pages/featured_course_details_page.dart';
import 'package:mechinetest/service/auth_service.dart';
import 'package:mechinetest/service/course_service.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final List<Course> _courses = [];
  final ScrollController _scrollController = ScrollController();
  final AuthService authService = AuthService();
  bool _isLoading = false;
  int _skip = 0;
  final int _limit = 10;
  bool _hasMore = true;
  String? _token;

  @override
  void initState() {
    super.initState();
    _initializeTokenAndFetchCourses();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeTokenAndFetchCourses() async {
    try {
      final token = await authService.getAccessToken();
      if (token != null) {
        setState(() {
          _token = token;
        });
        _fetchCourses();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Authentication failed. Please log in.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching token: $e")),
      );
    }
  }

  Future<void> _fetchCourses() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final courseResponse = await CourseService.fetchCourses(_token!);

      if (courseResponse.status) {
        setState(() {
          _courses.addAll(courseResponse.data);
          _skip += _limit;
          _hasMore = courseResponse.data.length == _limit;
          _isLoading = false;
        });
      } else {
        throw Exception(courseResponse.message);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load courses: $e')),
      );
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading &&
        _hasMore) {
      _fetchCourses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Featured Courses",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios),
        actions: const [
          Icon(
            Icons.search,
            color: Color.fromARGB(255, 101, 136, 165),
          ),
          SizedBox(width: 16),
          Icon(
            Icons.linear_scale_rounded,
            color: Color.fromARGB(255, 101, 136, 165),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: _courses.length + 1,
              itemBuilder: (context, index) {
                if (index == _courses.length) {
                  return _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : !_hasMore
                          ? const Center(child: Text("No more courses"))
                          : const SizedBox();
                }

                final course = _courses[index];
                return CourseCard(course: course);
              },
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CourseDetailsPage()));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                    color: Colors.indigo[50],
                    child: Image.asset(
                      "asset/images/img.png",
                      height: 150,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(
                      Icons.assured_workload_outlined,
                      color: Colors.indigo[200],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      course.universityName,
                      style: TextStyle(
                        color: Colors.indigo[200],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 4),
                  Text(
                    course.courseTitle,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        course.city ?? course.country,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        course.courseFee,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
