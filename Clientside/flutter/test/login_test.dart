import 'package:boilerplate/di/modules/local_module.dart';
import 'package:boilerplate/di/modules/netwok_module.dart';
import 'package:boilerplate/di/modules/preference_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/di/components/app_component.dart';
import 'package:dio/dio.dart';

void main() async{
  AppComponent appComponent;
  appComponent = await AppComponent.create(
    NetworkModule(),
    LocalModule(),
    PreferenceModule(),
  );
  Repository _repository = appComponent.getRepository();



  test('[UTCID01]Login as null username', () async {

    expect(
            () async => await _repository.authorizing(null, null),
        throwsA(predicate((e) =>
        e is DioError &&
            e.message=='Http status error [400]')));// Not valid request
  });

  test('[UTCID02]Login as null username', () async {

    expect(
            () async => await _repository.authorizing(null, '123qwe'),
        throwsA(predicate((e) =>
        e is DioError &&
            e.message=='Http status error [400]')));// Not valid request
  });

  test('[UTCID03]Login as null username', () async {

    expect(
            () async => await _repository.authorizing(null, 'aa'),
        throwsA(predicate((e) =>
        e is DioError &&
            e.message=='Http status error [400]')));// Not valid request
  });

  test('[UTCID04]Login as null pass', () async {

    expect(
            () async => await _repository.authorizing('admin', null),
        throwsA(predicate((e) =>
        e is DioError &&
            e.message=='Http status error [400]')));// Not valid request
  });


  test('[UTCID05]Login as admin with right authorization login information', () async {

    var AuthToken = await _repository.authorizing('admin', '123qwe');


    expect(AuthToken, isNotNull);
  });

  test('[UTCID06]Login as admin with wrong authorization login information', () async {

    expect(
            () async => await _repository.authorizing('admin', 'aa'),
        throwsA(predicate((e) =>
        e is DioError &&
        e.message=='Http status error [401]')));
  });





  test('[UTCID07]', () async {

    expect(
            () async => await _repository.authorizing('admin asd', null),
        throwsA(predicate((e) =>
        e is DioError &&
            e.message=='Http status error [400]')));// Not valid request
  });

  test('[UTCID08]', () async {

    expect(
            () async => await _repository.authorizing('admin asd', '123qwe'),
        throwsA(predicate((e) =>
        e is DioError &&
            e.message=='Http status error [401]')));// Not valid request //password max length=32
  });
  test('[UTCID09]', () async {

    expect(
            () async => await _repository.authorizing('admin asd', 'aa'),
        throwsA(predicate((e) =>
        e is DioError &&
            e.message=='Http status error [401]')));// Not valid request //password max length=32
  });



}
