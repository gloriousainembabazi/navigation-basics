import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String articleId;
  final String title;
  
  const ArticleDetailScreen({
    super.key,
    required this.articleId,
    required this.title,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/id/${int.parse(articleId) + 10}/400/200'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Article #$articleId',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Published on ${DateTime.now().toString().split(' ')[0]}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            SizedBox(height: 24),
            Text(
              'This is the full content of article "$title". '
              'Notice that the bottom navigation bar remains visible '
              'because this is a nested route within the ShellRoute. '
              'The back button will return you to the dashboard.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.arrow_back),
                    label: Text('Back'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/dashboard'),
                    icon: Icon(Icons.home),
                    label: Text('Dashboard (go)'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}