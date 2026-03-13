import 'package:flutter/material.dart';
import 'third_screen.dart';
import '../main.dart';

class ProfileScreen extends StatelessWidget {
  final String studentName;
  final String studentCourse;
  final int studentYear;
  final double studentGPA;

  const ProfileScreen({
    super.key,
    required this.studentName,
    required this.studentCourse,
    required this.studentYear,
    required this.studentGPA,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(studentName),
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.green.shade100,
                      child: Text(
                        studentName[0],
                        style: TextStyle(fontSize: 40, color: Colors.green.shade700, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(studentName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    _buildInfoRow(Icons.school, 'Course', studentCourse),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.grade, 'Year', 'Year $studentYear'),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.star, 'GPA', studentGPA.toString()),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Back'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.green,
                              side: const BorderSide(color: Colors.green),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ThirdScreen(
                                    studentName: studentName,
                                    studentCourse: studentCourse,
                                    additionalInfo: 'Completed ${studentYear * 8} courses',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text('Details'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.details,
                          arguments: {
                            'name': studentName,
                            'course': studentCourse,
                            'info': 'Accessed via named route',
                          },
                        );
                      },
                      icon: const Icon(Icons.route),
                      label: const Text('Open with Named Route'),
                      style: TextButton.styleFrom(foregroundColor: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 20),
        const SizedBox(width: 12),
        Text('$label:', style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(width: 8),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
      ],
    );
  }
}