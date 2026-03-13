import 'package:flutter/material.dart';
import '../main.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  final List<Map<String, dynamic>> contactMethods = const [
    {'icon': Icons.phone, 'title': 'Phone', 'value': '+256 700 123456', 'subtitle': 'Mon-Fri, 9am-5pm', 'color': Colors.green},
    {'icon': Icons.email, 'title': 'Email', 'value': 'support@navigationdemo.com', 'subtitle': '24/7 Support', 'color': Colors.blue},
    {'icon': Icons.location_on, 'title': 'Address', 'value': 'Makerere University', 'subtitle': 'Kampala, Uganda', 'color': Colors.red},
    {'icon': Icons.language, 'title': 'Website', 'value': 'www.navigationdemo.com', 'subtitle': 'Visit our website', 'color': Colors.purple},
    {'icon': Icons.facebook, 'title': 'Facebook', 'value': '@navigationdemo', 'subtitle': 'Follow us', 'color': Colors.blue},
    {'icon': Icons.message, 'title': 'WhatsApp', 'value': '+256 700 123456', 'subtitle': 'Chat with us', 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: Colors.pink,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.pink.shade700, Colors.pink.shade200], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(Icons.contact_mail, size: 80, color: Colors.white),
              const SizedBox(height: 10),
              const Text('Get in Touch', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              const Text('We\'d love to hear from you', style: TextStyle(fontSize: 16, color: Colors.white70)),
              const SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.1,
                ),
                itemCount: contactMethods.length,
                itemBuilder: (context, index) => _buildContactCard(context, contactMethods[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, Map<String, dynamic> method) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped: ${method['title']}'), duration: const Duration(seconds: 1)),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(method['icon'], size: 30, color: method['color']),
              const SizedBox(height: 8),
              Text(method['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(method['value'], style: TextStyle(fontSize: 10, color: Colors.grey.shade600), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}