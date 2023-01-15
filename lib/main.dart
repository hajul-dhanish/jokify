import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/Env/base_config.dart';
import 'index.dart';
import 'package:provider/provider.dart';
import 'view/plugin/flutter_flow_theme.dart';
import 'view/plugin/internationalization.dart';
import 'view/plugin/nav/nav.dart';
import 'view_model/dashboard/DashboardVM.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );
  Environment().initConfig(environment);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier();
    _router = createRouter(_appStateNotifier);

    Future.delayed(
      const Duration(seconds: 1),
      () => setState(
        () => _appStateNotifier.stopShowingSplashImage(),
      ),
    );
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DashBoardVM(),
          child: null,
        ),
      ],
      child: Consumer(builder: (context, theme, _) {
        return MaterialApp.router(
          title: 'Jokify',
          localizationsDelegates: const [
            FFLocalizationsDelegate(),
          ],
          locale: _locale,
          supportedLocales: const [Locale('en', '')],
          theme: ThemeData(
              dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
              ),
              appBarTheme: const AppBarTheme(
                // toolbarHeight: 0.0,
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
              brightness: Brightness.light),
          themeMode: _themeMode,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        );
      }),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'dashBoardScreen';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'dashBoardScreen': const DashBoardWidget(),
      'optionScreen': const OptionScreen(),
      'feedScreen': const FeedScreen(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).whiteColor,
        selectedItemColor: FlutterFlowTheme.of(context).alternate,
        unselectedItemColor: FlutterFlowTheme.of(context).blackwithMinOppac,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
        items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home_outlined),
            label: 'Home',
            tooltip: '',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            activeIcon: Icon(Icons.feed_outlined),
            label: 'Feed',
            tooltip: '',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person_off),
            activeIcon: Icon(Icons.person_off_outlined),
            label: 'Account',
            tooltip: '',
          ),
        ],
      ),
    );
  }
}
