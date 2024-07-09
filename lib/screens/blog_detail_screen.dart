import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/blog_provider.dart';
import 'blog_form_screen.dart';

class BlogDetailScreen extends StatelessWidget {
  final String id;

  BlogDetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => BlogFormScreen(id: id)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<BlogProvider>(context, listen: false).deleteBlog(id);
              Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<BlogProvider>(context, listen: false).fetchBlogById(id),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<BlogProvider>(
                builder: (ctx, blogProvider, _) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(blogProvider.selectedBlog!.title,
                          style: Theme.of(context).textTheme.headlineMedium),
                      SizedBox(height: 10),
                      Text(blogProvider.selectedBlog!.subTitle,
                          style: Theme.of(context).textTheme.displaySmall),
                      SizedBox(height: 10),
                      Text(blogProvider.selectedBlog!.body),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
