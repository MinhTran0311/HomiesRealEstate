import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/di/modules/local_module.dart';
import 'package:boilerplate/di/modules/netwok_module.dart';
import 'package:boilerplate/di/modules/preference_module.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/di/components/app_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class testFunction{
  AppComponent appComponent;

  Repository repository;


  void init() async{
    appComponent = await AppComponent.create(
      NetworkModule(),
      LocalModule(),
      PreferenceModule(),
    );
    repository = appComponent.getRepository();
  }

  void login() async{
    var AuthToken = await repository.authorizing('admin', '123qwe');
    SharedPreferences.getInstance().then((preference) {
      preference.setString(Preferences.access_token, AuthToken.accessToken);});
    Preferences.access_token = AuthToken.accessToken;
  }

}