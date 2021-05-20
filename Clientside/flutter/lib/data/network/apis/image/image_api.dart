import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/image/image_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:dio/dio.dart';
import 'dart:io' as Io;
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  ImageApi(this._dioClient, this._restClient);

  /// Returns id of image
  Future<String> postImage(String path) async {
    try {
       WidgetsFlutterBinding.ensureInitialized();
       final _image = await ImagePicker.pickImage(source: ImageSource.gallery);
      List<int> imageBytes = _image.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);

       var formData = FormData.fromMap({
         "image": base64Image,
         "name": "1st picture",
       });

      final res = await _dioClient.post(Endpoints.postImageToImageBB,
        queryParameters: {
          "key": Preferences.imgbb_api_key,
          "expiration": "7776000",
        },
        data: formData,
      );
      print(res["data"]["image"]["url"].toString());
      return res["data"]["image"]["url"];
    } catch (e) {
      throw e;
    }
  }

  Future<ImageList> getImages(String postId) async {
    try{
      final res = await _dioClient.get(Endpoints.getImagesForDetail,
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),
        queryParameters: {
          "postId": postId,
        },
      );

      return ImageList.fromJson(res);
    }catch(e){
      throw e;
    }
  }
}
