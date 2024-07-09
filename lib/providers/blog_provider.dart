import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphql/graphql_queries.dart';
import '../models/blog.dart';
import '../main.dart'; // Import the navigatorKey

class BlogProvider with ChangeNotifier {
  List<Blog> _blogs = [];
  Blog? _selectedBlog;

  List<Blog> get blogs => _blogs;
  Blog? get selectedBlog => _selectedBlog;

  Future<void> fetchBlogs() async {
    final QueryOptions options = QueryOptions(
      document: gql(fetchAllBlogs),
    );

    final QueryResult result =
        await GraphQLProvider.of(navigatorKey.currentContext!)
            .value
            .query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    final List<dynamic> data = result.data!['allBlogPosts'];
    _blogs = data.map((json) => Blog.fromJson(json)).toList();
    notifyListeners();
  }

  Future<void> fetchBlogById(String id) async {
    final QueryOptions options = QueryOptions(
      document: gql(getBlog),
      variables: {'blogId': id},
    );

    final QueryResult result =
        await GraphQLProvider.of(navigatorKey.currentContext!)
            .value
            .query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    _selectedBlog = Blog.fromJson(result.data!['blogPost']);
    notifyListeners();
  }

  Future<void> createBlog(String title, String subTitle, String body) async {
    final MutationOptions options = MutationOptions(
      document: gql(createBlogPost),
      variables: {
        'title': title,
        'subTitle': subTitle,
        'body': body,
      },
    );

    final QueryResult result =
        await GraphQLProvider.of(navigatorKey.currentContext!)
            .value
            .mutate(options);

    if (result.hasException) {
      throw result.exception!;
    }

    final Blog newBlog = Blog.fromJson(result.data!['createBlog']['blogPost']);
    _blogs.add(newBlog);
    notifyListeners();
  }

  Future<void> updateBlog(
      String id, String title, String subTitle, String body) async {
    final MutationOptions options = MutationOptions(
      document: gql(updateBlogPost),
      variables: {
        'blogId': id,
        'title': title,
        'subTitle': subTitle,
        'body': body,
      },
    );

    final QueryResult result =
        await GraphQLProvider.of(navigatorKey.currentContext!)
            .value
            .mutate(options);

    if (result.hasException) {
      throw result.exception!;
    }

    final Blog updatedBlog =
        Blog.fromJson(result.data!['updateBlog']['blogPost']);
    final int index = _blogs.indexWhere((blog) => blog.id == id);
    _blogs[index] = updatedBlog;
    notifyListeners();
  }

  Future<void> deleteBlog(String id) async {
    final MutationOptions options = MutationOptions(
      document: gql(deleteBlogPost),
      variables: {'blogId': id},
    );

    final QueryResult result =
        await GraphQLProvider.of(navigatorKey.currentContext!)
            .value
            .mutate(options);

    if (result.hasException) {
      throw result.exception!;
    }

    _blogs.removeWhere((blog) => blog.id == id);
    notifyListeners();
  }
}
