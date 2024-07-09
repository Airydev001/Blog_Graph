import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/blog_provider.dart';
import 'blog_detail_screen.dart';
import 'blog_form_screen.dart';
import '../widgets/blog_card.dart';

class BlogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
      ),
      body: FutureBuilder(
        future: Provider.of<BlogProvider>(context, listen: false).fetchBlogs(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<BlogProvider>(
                    builder: (ctx, blogProvider, _) => ListView.builder(
                      itemCount: blogProvider.blogs.length,
                      itemBuilder: (ctx, i) =>
                          BlogCard(blog: blogProvider.blogs[i]),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => BlogFormScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
