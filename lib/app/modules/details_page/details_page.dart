import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_reading/app/models/news_models.dart';

class NewsDetailsPage extends StatelessWidget {
  final Article article;

  const NewsDetailsPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm'); // Date format

    return Scaffold(
      appBar: AppBar(
       ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display image at the top
          Container(
            height: 200, // Set a fixed height for the image container
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                article.urlToImage ?? '', // Use a default empty string if URL is null
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Display a placeholder icon or news image when there's an error
                  return Icon(Icons.newspaper, size: 40);
                },
              ),
            ),
          ),
          SizedBox(height: 16), // Add spacing

          // Display article details in containers
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Text(
                  article.source.name,
                  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 8),
                     Text(
                  'Published on: ${dateFormat.format(article.publishedAt)}',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 12),
                Text(
                  article.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 8),
           
                Text(
                  article.description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 12),
                Text(
                  'Content: ${article.content}',
                  style: TextStyle(fontSize: 16),
                ),
                // Add more details from the article as necessary
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  // Function to build the article image widget
  Widget _buildArticleImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error_outline, size: 40); // Placeholder icon on error
        },
      );
    } else {
      // Placeholder when URL is invalid or empty
      return Icon(Icons.image_not_supported, size: 40);
      // You can also return another default placeholder image widget
    }
  }
}
