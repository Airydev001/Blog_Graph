import 'package:blog_ql/screens/blog_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/blog_provider.dart';

class BlogFormScreen extends StatefulWidget {
  final String? id;

  BlogFormScreen({this.id});

  @override
  _BlogFormScreenState createState() => _BlogFormScreenState();
}

class _BlogFormScreenState extends State<BlogFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _subTitle = '';
  String _body = '';

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.id != null;
    if (isEditing) {
      Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
      final blog = Provider.of<BlogProvider>(context, listen: false)
          .blogs
          .firstWhere((blog) => blog.id == widget.id);
      _title = blog.title;
      _subTitle = blog.subTitle;
      _body = blog.body;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Blog' : 'New Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _subTitle,
                decoration: InputDecoration(labelText: 'Subtitle'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subtitle';
                  }
                  return null;
                },
                onSaved: (value) {
                  _subTitle = value!;
                },
              ),
              TextFormField(
                initialValue: _body,
                decoration: InputDecoration(labelText: 'Body'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the body';
                  }
                  return null;
                },
                onSaved: (value) {
                  _body = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (isEditing) {
                      Provider.of<BlogProvider>(context, listen: false)
                          .updateBlog(widget.id!, _title, _subTitle, _body);
                    } else {
                      Provider.of<BlogProvider>(context, listen: false)
                          .fetchBlogs();
                      Provider.of<BlogProvider>(context, listen: false)
                          .createBlog(_title, _subTitle, _body);
                    }
                    Provider.of<BlogProvider>(context, listen: false)
                        .fetchBlogs();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => BlogListScreen()));
                  }
                },
                child: Text(isEditing ? 'Update' : 'Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
