import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../models/blog.dart';
import '../screens/blog_detail_screen.dart';
import 'package:intl/intl.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;

  BlogCard({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: OpenContainer(
            closedBuilder: (ctx, action) => ListTile(
              title: Text(blog.title),
              subtitle: Text(blog.subTitle),
              trailing: Text(
                  'Created on: ${DateFormat.yMMMd().format(blog.dateCreated)}'),
            ),
            openBuilder: (ctx, action) => BlogDetailScreen(blog.id),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
