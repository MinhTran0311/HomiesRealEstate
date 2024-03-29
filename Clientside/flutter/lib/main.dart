import 'package:boilerplate/blocs/application_bloc.dart';
import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/di/components/app_component.dart';
import 'package:boilerplate/di/modules/local_module.dart';
import 'package:boilerplate/di/modules/netwok_module.dart';
import 'package:boilerplate/di/modules/preference_module.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/admin/userManagement/userManagement_store.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/stores/image/image_store.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/lichsugiaodich/LSGD_store.dart';
import 'package:boilerplate/stores/maps/map_store.dart';
import 'package:boilerplate/stores/post/filter_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/reportData/reportData_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/town/town_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/stores/token/authToken_store.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/homepage/homepage.dart';
import 'package:boilerplate/ui/admin/userManagement/userManagement.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/ui/splash/splash.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:inject/inject.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/stores/admin/roleManagement/roleManagement_store.dart';
import 'package:boilerplate/stores/admin/goiBaiDangManagement/goiBaiDangManagement_store.dart';
import 'package:boilerplate/stores/admin/thuocTinhManagement/thuocTinhManagement_store.dart';
import 'package:boilerplate/stores/admin/danhMucManagement/danhMucManagement_store.dart';
import 'package:boilerplate/stores/admin/baiDangManagement/baiDangManagement_store.dart';

// global instance for app component
AppComponent appComponent;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) async {
    appComponent = await AppComponent.create(
      NetworkModule(),
      LocalModule(),
      PreferenceModule(),
    );
    runApp(appComponent.app);
  });
}

@provide
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(appComponent.getRepository());
  final PostStore _postStore = PostStore(appComponent.getRepository());
  final LanguageStore _languageStore = LanguageStore(appComponent.getRepository());
  final UserStore _userStore = UserStore(appComponent.getRepository());
  final LSGDStore _lsgdStore = LSGDStore(appComponent.getRepository());
  final ReportDataStore _reportDataStore = ReportDataStore(appComponent.getRepository());
  final AuthTokenStore _authTokenStore = AuthTokenStore(appComponent.getRepository());
  final UserManagementStore _userManagementStore = UserManagementStore(appComponent.getRepository());
  final RoleManagementStore _roleManagementStore = RoleManagementStore(appComponent.getRepository());
  final ImageStore _imageStore = ImageStore(appComponent.getRepository());
  final TownStore _townStore = TownStore(appComponent.getRepository());
  final FilterStore _filterStore = FilterStore(appComponent.getRepository());
  final MapsStore _mapsStore = MapsStore(appComponent.getRepository());
  final GoiBaiDangManagementStore _goiBaiDangManagementStore = GoiBaiDangManagementStore(appComponent.getRepository());
  final DanhMucManagementStore _danhMucManagementStore = DanhMucManagementStore(appComponent.getRepository());
  final ThuocTinhManagementStore _thuocTinhManagementStore = ThuocTinhManagementStore(appComponent.getRepository());
  final BaiDangManagementStore _baiDangManagementStore = BaiDangManagementStore(appComponent.getRepository());
  //final FormStore _formStore = FormStore(appComponent.getRepository());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<PostStore>(create: (_) => _postStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<AuthTokenStore>(create: (_) => _authTokenStore),
        Provider<UserManagementStore>(create: (_) => _userManagementStore),
        Provider<RoleManagementStore>(create: (_) => _roleManagementStore),
        Provider<FilterStore>(create: (_) => _filterStore),
        Provider<ReportDataStore>(create: (_) => _reportDataStore),
        Provider<UserStore>(create: (_) => _userStore),
        Provider<LSGDStore>(create: (_) => _lsgdStore),
        Provider<ImageStore>(create: (_) => _imageStore),
        Provider<TownStore>(create: (_) => _townStore),
        Provider<MapsStore>(create: (_) => _mapsStore),
        Provider<GoiBaiDangManagementStore>(create: (_) => _goiBaiDangManagementStore),
        Provider<DanhMucManagementStore>(create: (_) => _danhMucManagementStore),
        Provider<ThuocTinhManagementStore>(create: (_) => _thuocTinhManagementStore),
        Provider<BaiDangManagementStore>(create: (_) => _baiDangManagementStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return ChangeNotifierProvider(
            create: (context) => ApplicationBloc(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Strings.appName,
              theme: _themeStore.darkMode ? themeDataDark : themeDataLight,
              routes: Routes.routes,
              locale: Locale(_languageStore.locale),
              supportedLocales: _languageStore.supportedLanguages
                  .map((language) => Locale(language.locale, language.code))
                  .toList(),
              localizationsDelegates: [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
                // Built-in localization of basic text for Cupertino widgets
                GlobalCupertinoLocalizations.delegate,
              ],
              home: _authTokenStore.loggedIn ? HomePageScreen() : LoginScreen(),
            ),
          );
        },
      ),
    );
  }
  
}
