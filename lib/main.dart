import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/app.dart';
import 'package:lazyclub/components/providers/dark_theme_provider.dart';
import 'package:lazyclub/components/providers/favor_provider.dart';
import 'package:lazyclub/components/providers/manage_provider.dart';
import 'package:lazyclub/components/providers/studies_provider.dart';
import 'package:lazyclub/components/theme/style.dart';
import 'package:lazyclub/database/firebase_consts.dart';
import 'package:lazyclub/firebase_options.dart';
import 'package:lazyclub/pages/auth/email_register_page.dart';
import 'package:lazyclub/pages/auth/login_page.dart';
import 'package:lazyclub/pages/auth/pw_forget.dart';
import 'package:lazyclub/pages/inner/all_popular.dart';
import 'package:lazyclub/pages/inner/all_studies.dart';
import 'package:lazyclub/pages/inner/detail_page.dart';
import 'package:lazyclub/pages/inner/each_cat.dart';
import 'package:lazyclub/pages/main/category_page.dart';
import 'package:lazyclub/pages/main/favor_page.dart';
import 'package:lazyclub/pages/main/main_page.dart';
import 'package:lazyclub/pages/main/new_study.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text(
                    '에러 발생!',
                    style: TextStyle(color: headTextClr),
                  ),
                ),
              ),
            );
          }

          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(
                    create: (context) => StudyGroupsProvider()),
                ChangeNotifierProvider(create: (context) => FavorProvider()),
                ChangeNotifierProvider(create: (context) => ManageProvider()),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeProvider, child) {
                return MaterialApp(
                    theme:
                        Styles.themeData(themeProvider.getDarkTheme, context),
                    debugShowCheckedModeBanner: false,
                    routes: {
                      MainPage.routeName: (context) => MainPage(),
                      App.routeName: (context) => App(),
                      DetailPage.routeName: (context) => DetailPage(),
                      UploadStudyPage.routeName: (context) => UploadStudyPage(),
                      FavorPage.routeName: (context) => FavorPage(),
                      EachCategotyPage.routeName: (context) =>
                          EachCategotyPage(),
                      CategoriesPage.routeName: (context) => CategoriesPage(),
                      LoginPage.routeName: (context) => LoginPage(),
                      EmailRegisterPage.routeName: (context) =>
                          EmailRegisterPage(),
                      PwForgetPage.routeName: (context) => PwForgetPage(),
                      AllStudyListPage.routeName: (context) =>
                          AllStudyListPage(),
                      AllPopularListPage.routeName: (context) =>
                          AllPopularListPage(),
                    },
                    home: user == null ? LoginPage() : App());
              }));
        });
  }
}
