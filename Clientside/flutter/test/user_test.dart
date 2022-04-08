import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'testFunction.dart';

testFunction function;
void main() async {
  function = testFunction();
  await function.init();


  await function.login();



  await createUserTest();

  // await editUserTest();
  //
  // await deleteUserTest();

  //
  // test(' Get 10 users', () async {
  //   var result = await function.repository.getAllUsers(0, 10, null);
  //
  //
  //   expect(result.users.length, 10);
  // });
  // test('[Admin] Add new user with invalid data', () async {
  //   expect(
  //           () async =>
  //       await function.repository.createUser(null, null, null, null, null, null, null, null),
  //       throwsA(predicate((e) =>
  //       e is DioError &&
  //           e.message == 'Http status error [400]'))); //invalid request
  // });
  //
  // test('[Admin] Add new user with created username', () async {
  //   List<String> role = new List<String>();
  //   role.add('User');
  //   // expect(result['error']['message'],"User name 'admin' is already taken.");
  //   expect(
  //           () async =>
  //       await function.repository.createUser('admin', 'admin', 'admin', 'admin@gmail.com', '0908680223', true, role, 'admin'),
  //       throwsA(predicate((e) =>
  //       e is DioError &&
  //           e.message == 'Http status error [500]'))); //iUser name 'admin' is already taken.
  // });
  //
  // test('[Admin] Add new user with all valid ', () async {
  //   List<String> role = new List<String>();
  //   role.add('User');
  //   // expect(result['error']['message'],"User name 'admin' is already taken.");
  //   var result = await function.repository.createUser('ductesting', 'admin', 'admin', 'ductesting@gmail.com', '0908680223', true, role, '123qwe');
  //
  //   expect(result['success'], true);
  // });
  //
  // test('[Admin] edit user with invalid email', () async {
  //   List<String> role = new List<String>();
  //   role.add('User');
  //   // expect(result['error']['message'],"User name 'admin' is already taken.");
  //   var result = await function.repository.getAllUsers(0, 1, 'ductesting');
  //   expect(result.users.length, 1);
  //
  //   var user = result.users[0];
  //
  //   user.email='asd';
  //   expect(
  //           () async =>
  //       await function.repository.updateUser(user.id, user.userName, user.name, user.name, user.email, user.phoneNumber, user.isActive, role),
  //       throwsA(predicate((e) =>
  //       e is DioError ))); //invalid email pattern
  // });
  // test('[Admin] edit user with all valid', () async {
  //   List<String> role = new List<String>();
  //   role.add('User');
  //   // expect(result['error']['message'],"User name 'admin' is already taken.");
  //   var result = await function.repository.getAllUsers(0, 1, 'ductesting');
  //   expect(result.users.length, 1);
  //
  //   var user = result.users[0];
  //
  //   user.email='ductestingemail@gmail.com';
  //   user.name = 'duc';
  //   user.surName = 'test';
  //   var editresult = await function.repository.updateUser(user.id, user.userName, user.surName, user.name, user.email, user.phoneNumber, user.isActive, role);
  //   expect(editresult['success'],true);
  //
  //
  //   var verifyresult = await function.repository.getAllUsers(0, 1, 'ductesting');
  //   expect(verifyresult.users[0].email, 'ductestingemail@gmail.com');
  // });
  //
  //
  // test('[Admin] detele test user', () async {
  //   List<String> role = new List<String>();
  //   role.add('User');
  //   // expect(result['error']['message'],"User name 'admin' is already taken.");
  //   var result = await function.repository.getAllUsers(0, 1, 'ductesting');
  //   expect(result.users.length, 1);
  //
  //   var user = result.users[0];
  //
  //   var deleteresult = await function.repository.deleteUser(user.id);
  //
  //   expect(deleteresult,isNotNull);
  // });

}

void deleteUserTest() async{
  test('[Admin] detele test user', () async {
    var result = await function.repository.getAllUsers(0, 10, 'ductesting');
    expect(result.users.length, 2);
    var deleteresult = await function.repository.deleteUser(result.users[0].id);
    expect(deleteresult,isNotNull);

    var deleteresult2 = await function.repository.deleteUser(result.users[1].id);
    expect(deleteresult2,isNotNull);




  });


}
void editUserTest() async{
  List<String> role = new List<String>();
  role.add('User');

  List<Object> list1 = new List<Object>();
  List<Object> list2 = new List<Object>();
  List<bool> list5 = new List<bool>();

  list1.add(null);
  list1.add('999999999999999999999999999999');
  list1.add('0908680223');
  list1.add('9999asd999');

  list2.add('duc.com');
  list2.add(null);
  list2.add('ductesting11@gmail.com');


  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(true);
  list5.add(false);
  list5.add(false);
  list5.add(false);


    var result = await function.repository.getAllUsers(0, 1, 'ductesting');

    var user = result.users[0];



  int count=0;
  for (var item1 in list1){
    for (var item2 in list2){

          int i = count +1;
          String name = 'UTCID$i';
          if (list5[count]){
            test(name, () async {
              var result = await function.repository.updateUser(user.id,user.userName,user.surName,user.name,item2,item1,true,role);
              expect(result['success'], true);
            });
          }else{
            test(name, () async {
              expect(
                      () async =>
                  await function.repository.updateUser(user.id,user.userName,user.surName,user.name,item2,item1,true,role),
                  throwsA(predicate((e) =>
                  e is DioError))); //invalid request
            });

          }
          count++;

        }
  }
}


void createUserTest(){
  List<String> role = new List<String>();
  role.add('User');

  List<Object> list1 = new List<Object>();
  List<Object> list2 = new List<Object>();
  List<Object> list3 = new List<Object>();
  List<Object> list4 = new List<Object>();
  List<bool> list5 = new List<bool>();

  list1.add('ductesting1');
  list1.add(null);
  list1.add('ductesting2');

  list2.add('duc');
  list2.add(null);

  list3.add(null);
  list3.add('999999999999999999999999999999');
  list3.add('0908680223');
  list3.add('9999asd999');

  list4.add('duc.com');
  list4.add(null);
  list4.add('ductesting1@gmail.com');
  list4.add('ductesting2@gmail.com');

  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
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
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
  list5.add(false);
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
  list5.add(false);
  list5.add(false);
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
              var result = await function.repository.createUser(
                  item1, item2,item2,  item4, item3,true,role,"123qwe");
              expect(result['success'], true);
            });
          }else{
            test(name, () async {
              expect(
                      () async =>
                      await function.repository.createUser(
                          item1, item2,item2,  item4, item3,true,role,"123qwe"),
                  throwsA(predicate((e) =>
                  e is DioError))); //invalid request
            });

          }
          count++;

        }
      }
    }
  }
}

