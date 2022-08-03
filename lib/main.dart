import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/app.dart';
import 'package:lazyclub/components/providers/favor_provider.dart';
import 'package:lazyclub/components/providers/manage_provider.dart';
import 'package:lazyclub/components/providers/studies_provider.dart';
import 'package:lazyclub/constants/db_constants.dart';
import 'package:lazyclub/components/providers/theme/style.dart';
import 'package:lazyclub/firebase_options.dart';
import 'package:lazyclub/pages/auth/email_register_page.dart';
import 'package:lazyclub/pages/auth/login_page.dart';
import 'package:lazyclub/pages/auth/pw_forget.dart';
import 'package:lazyclub/pages/inner/all_studies.dart';
import 'package:lazyclub/pages/inner/detail_page.dart';
import 'package:lazyclub/pages/inner/each_cat.dart';
import 'package:lazyclub/pages/main/category_page.dart';
import 'package:lazyclub/pages/main/favor_page.dart';
import 'package:lazyclub/pages/main/main_page.dart';
import 'package:lazyclub/pages/main/my_study.dart';
import 'package:lazyclub/pages/main/new_study.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

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
                ChangeNotifierProvider(
                    create: (context) => StudyGroupsProvider()),
                ChangeNotifierProvider(create: (context) => FavorProvider()),
                ChangeNotifierProvider(create: (context) => ManageProvider()),
              ],
              child: MaterialApp(
                  theme: ThemeData(
                      appBarTheme: AppBarTheme(
                        elevation: 0,
                        backgroundColor: Colors.white,
                      ),
                      scaffoldBackgroundColor: Colors.white),
                  debugShowCheckedModeBanner: false,
                  routes: {
                    MainPage.routeName: (context) => MainPage(),
                    App.routeName: (context) => App(),
                    DetailPage.routeName: (context) => DetailPage(),
                    UploadStudyPage.routeName: (context) => UploadStudyPage(),
                    FavorPage.routeName: (context) => FavorPage(),
                    EachCategotyPage.routeName: (context) => EachCategotyPage(),
                    CategoriesPage.routeName: (context) => CategoriesPage(),
                    LoginPage.routeName: (context) => LoginPage(),
                    EmailRegisterPage.routeName: (context) =>
                        EmailRegisterPage(),
                    PwForgetPage.routeName: (context) => PwForgetPage(),
                    AllStudyListPage.routeName: (context) => AllStudyListPage(),
                    MyStudiesList.routeName: (context) => MyStudiesList(),
                  },
                  home: user == null ? LoginPage() : App()));
        });
  }
}



/* void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: fbAuth.FirebaseAuth.instance,
          ),
        ),
        Provider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        StreamProvider<fbAuth.User?>(
          create: (context) => context.read<AuthRepository>().user,
          initialData: null,
        ),
        ChangeNotifierProxyProvider<fbAuth.User?, AuthProvider>(
          create: (context) => AuthProvider(
            authRepository: context.read<AuthRepository>(),
          ),
          update: (
            BuildContext context,
            fbAuth.User? userStream,
            AuthProvider? authProvider,
          ) =>
              authProvider!..update(userStream),
        ),
        ChangeNotifierProvider<SignInProvider>(
          create: (context) => SignInProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider<SignUpProvider>(
          create: (context) => SignUpProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(
            profileRepository: context.read<ProfileRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        routes: {
          SignUpPage.routeName: (context) => SignUpPage(),
          SignInPage.routeName: (context) => SignInPage(),
          HomePage.routeName: (context) => HomePage(),
        },
      ),
    );
  }
}
 */