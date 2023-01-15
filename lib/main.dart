import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:q2smart/data/sharedPref/SharedPref.dart';
import 'package:q2smart/view_model/auth/LoginVM.dart';

import '../view/flutter_flow/internationalization.dart';
import 'data/Env/base_config.dart';
import 'index.dart';
import 'repository/token/TokenRepository.dart';
import 'utils/global.dart';
import 'view/flutter_flow/flutter_flow_theme.dart';
import 'view/flutter_flow/nav/nav.dart';
import 'view_model/auth/UserInfoVM.dart';
import 'view_model/banner/BannerVM.dart';
import 'view_model/cart/CartItemVM.dart';
import 'view_model/dashboard/DashboardVM.dart';
import 'view_model/products/ProductsListVM.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserSharedPreferences().initSharedPreferences();
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );
  Environment().initConfig(environment);
  // userInfoVM.getUserInfo();
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

  final _myTokenRepo = TokenRepository();

  @override
  void initState() {
    super.initState();
    getToken();
    _appStateNotifier = AppStateNotifier();
    _router = createRouter(_appStateNotifier);

    Future.delayed(
      Duration(seconds: 1),
      () => setState(
        () => _appStateNotifier.stopShowingSplashImage(),
      ),
    );
  }

  getToken() async {
    await _myTokenRepo.getToken().then((value) {
      globalAuthToken = value.data!.result![0][0]['hashvalue'];
    }).onError((error, stackTrace) {});
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
        ChangeNotifierProvider.value(
          value: ProductsListVM(),
          child: null,
        ),
        ChangeNotifierProvider.value(
          value: BannerVM(),
          child: null,
        ),
        ChangeNotifierProvider.value(
          value: LoginVM(),
          child: null,
        ),
        ChangeNotifierProvider.value(
          value: CartItemVM(),
          child: null,
        ),
        ChangeNotifierProvider.value(
          value: UserInfoVM(),
          child: null,
        ),
      ],
      child: Consumer(builder: (context, theme, _) {
        return MaterialApp.router(
          title: 'q2sMart',
          localizationsDelegates: [
            FFLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
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
              appBarTheme: AppBarTheme(
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
  String _currentPageName = 'dashBoard';
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
      'dashBoard': DashBoardWidget(),
      // 'ProductDetails': ProductDetailsWidget(),
      'productItemsPage': ProductItemsPageWidget(),
      'offerPage': OfferScreen(),
      'Brand': BrandPageWidget(),
      'contactUs': ContactusWidget(),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/icon-home.svg"),
            activeIcon: SvgPicture.asset("assets/images/icon-home-fill.svg"),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/icon-category.svg"),
            activeIcon:
                SvgPicture.asset("assets/images/icon-category-fill.svg"),
            label: 'Product',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/icon-mybasket.svg"),
            activeIcon:
                SvgPicture.asset("assets/images/icon-mybasket-fill.svg"),
            label: 'Offers',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/Icon feather-bell.svg"),
            activeIcon:
                SvgPicture.asset("assets/images/icon-feather-bell-fill.svg"),
            label: 'Branding',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/icon-user.svg"),
            activeIcon: SvgPicture.asset("assets/images/icon-user-fill.svg"),
            label: 'contact Us',
            tooltip: '',
          ),
        ],
      ),
    );
  }
}
