import 'package:boilerplate/data/sharedpref/constants/preferences.dart';

// bool hasPermission(String permission){
//   if (Preferences.grantedPermissions.isEmpty)
//     return false;
//   if (Preferences.grantedPermissions.contains(permission))
//     return true;
//   else
//     return false;
// }
class Permission {
  Permission._privateConstructor();

  static final Permission instance = Permission._privateConstructor();
  bool hasPermission(String permission){
    if (Preferences.grantedPermissions.isEmpty)
      return false;
    if (Preferences.grantedPermissions.contains(permission))
      return true;
    else
      return false;
  }
}