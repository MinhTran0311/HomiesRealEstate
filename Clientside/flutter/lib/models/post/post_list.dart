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
    print("heyyy");
    print(json);
    //posts = json["result"]["items"].map((post) => Post.fromMap(post)).toList();
    //print(json["result"]["items"][0].runtimeType);
    for (int i =0; i<json["result"]["items"].length; i++) {
        posts.add(Post.fromMap(json["result"]["items"][i]));
      }
    return PostList(
      posts: posts,
    );
  }
}
