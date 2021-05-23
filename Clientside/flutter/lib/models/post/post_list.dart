import 'dart:developer';

import 'package:boilerplate/models/post/post.dart';
import 'package:flutter/material.dart';

class PostList {
  final List<Post> posts;

  PostList({
    this.posts,
  });

  factory PostList.fromJson(Map<String, dynamic> json) {
    List<Post> posts = List<Post>();

    for (int i =0; i<json["result"]["items"].length; i++) {
        posts.add(Post.fromMap(json["result"]["items"][i]));
      }
    return PostList(
      posts: posts,
    );
  }
  factory PostList.fromJsonmypost(Map<String, dynamic> json) {
    List<Post> posts = List<Post>();

    for (int i =0; i<json["result"]["items"].length; i++) {
      posts.add(Post.fromMapmypost(json["result"]["items"][i]));
    }
    return PostList(
      posts: posts,
    );
  }
  factory PostList.fromJsonfavopost(Map<String, dynamic> json) {
    List<Post> posts = List<Post>();

    for (int i =0; i<json["result"]["items"].length; i++) {
      posts.add(Post.fromMapfavo(json["result"]["items"][i]));
    }
    return PostList(
      posts: posts,
    );
  }
}
