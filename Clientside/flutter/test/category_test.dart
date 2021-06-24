import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import 'testFunction.dart';

testFunction function;
void main() async {
  function = testFunction();
  await function.init();


  await function.login();


  testCreateCategory();

  testUpdateCategory();


  // test('[No Login] Get all Post categories', () async {
  //   expect(
  //           () async => await function.repository.getPostCategorys(),
  //       throwsA(predicate((e) =>
  //       e is DioError &&
  //           e.message == 'Http status error [401]'))); //user did not login
  // });




  //
  // test(' Get all Post categories', () async {
  //   var result = await function.repository.getPostCategorys();
  //
  //
  //   expect(result, isNotNull);
  // });
  // test('[Admin] Add new category with invalid data', () async {
  //   expect(
  //           () async =>
  //       await function.repository.createDanhMuc('duc', null, null, null),
  //       throwsA(predicate((e) =>
  //       e is DioError &&
  //           e.message == 'Http status error [400]'))); //invalid request
  // });

  // test('[Admin] Add new category with valid data', () async {
  //   var result = await function.repository.createDanhMuc(
  //       'duc', 'test', null, 'On');
  //   expect(result['success'], true);
  // });
  //
  // test('[Admin] edit category  with valid data', () async {
  //   var edit = await function.repository.getAllDanhMucs(0,1,'duc');
  //   expect(edit.danhMucs.length, 1);
  //   var entity = edit.danhMucs[0];
  //   entity.tenDanhMuc = 'ducTest';
  //   var result = await function.repository.updateDanhMuc(entity.id, entity.tenDanhMuc, entity.tag, entity.danhMucCha, entity.trangThai);
  //   expect(result['success'],true);
  //
  //   var edited = await function.repository.getAllDanhMucs(0,1,'ducTest');
  //   expect(edit.danhMucs.length, 1);
  //
  // });

}

void testUpdateCategory() {

  List<Object> list1 = new List<Object>();
  List<Object> list2 = new List<Object>();
  List<Object> list3 = new List<Object>();
  List<Object> list4 = new List<Object>();
  List<bool> list5 = new List<bool>();

  list1.add('duc');
  list1.add(null);

  list2.add('test');
  list2.add(null);

  list3.add(0);
  list3.add(null);

  list4.add('On');
  list4.add(null);

  list5.add(true);
  list5.add(false);
  list5.add(true);
  list5.add(false);
  list5.add(true);
  list5.add(false);
  list5.add(true);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);

  int count=0;
  for (var item1 in list1){
    for (var item2 in list2){
      for (var item3 in list3){
        for (var item4 in list4){
          int i = count +1;
          String name = 'UTCID$i';
          if (list5[count]){
            test(name, () async {
              var edit = await function.repository.getAllDanhMucs(0,1,'duc');
              expect(edit.danhMucs.length, 1);
              var entity = edit.danhMucs[0];
              var result = await function.repository.updateDanhMuc(entity.id, item1, item2, item3, item4);
              expect(result['success'],true);
            });
          }else{
            test(name, () async {
              var edit = await function.repository.getAllDanhMucs(0,1,'duc');
              expect(edit.danhMucs.length, 1);
              var entity = edit.danhMucs[0];
              expect(
                      () async =>
                          await function.repository.updateDanhMuc(entity.id, item1, item2, item3, item4),
                  throwsA(predicate((e) =>
                  e is DioError &&
                      e.message == 'Http status error [400]'))); //invalid request
            });
          }
          count++;

        }
      }
    }
  }

}

void testCreateCategory(){
  List<Object> list1 = new List<Object>();
  List<Object> list2 = new List<Object>();
  List<Object> list3 = new List<Object>();
  List<Object> list4 = new List<Object>();
  List<bool> list5 = new List<bool>();

  list1.add('duc');
  list1.add(null);

  list2.add('test');
  list2.add(null);

  list3.add(0);
  list3.add(null);

  list4.add('On');
  list4.add(null);

  list5.add(true);
  list5.add(false);
  list5.add(true);
  list5.add(false);
  list5.add(true);
  list5.add(false);
  list5.add(true);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);

  int count=0;
  for (var item1 in list1){
    for (var item2 in list2){
      for (var item3 in list3){
        for (var item4 in list4){
          int i = count +1;
          String name = 'UTCID$i';
          if (list5[count]){
            test(name, () async {
              var result = await function.repository.createDanhMuc(
                  item1, item2, item3, item4);
              expect(result['success'], true);
            });
          }else{
            test(name, () async {
              expect(
                      () async =>
                  await function.repository.createDanhMuc(item1, item2, item3, item4),
                  throwsA(predicate((e) =>
                  e is DioError &&
                      e.message == 'Http status error [400]'))); //invalid request
            });

          }
          count++;

        }
      }
    }
  }

}

