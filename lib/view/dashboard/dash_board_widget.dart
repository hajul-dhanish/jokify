import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:q2smart/res/AppContextExtension.dart';
import 'package:q2smart/view/components/brands.dart';
import 'package:q2smart/view/components/orderAgainCard.dart';
import 'package:q2smart/view/components/cachedImage.dart';
import '../../data/sharedPref/SharedPref.dart';
import '../../utils/global.dart';
import '../../view_model/auth/UserInfoVM.dart';
import '../components/custom_view_all_widget.dart';
import '../components/footer.dart';
import '../components/offerCard.dart';
import '../components/searchBar.dart';
import '../flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../view_model/dashboard/DashboardVM.dart';
// import '../components/custom_view_all_widget.dart';
import 'dart:math';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({Key? key}) : super(key: key);

  @override
  _DashBoardWidgetState createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  // ApiCallResponse? topCatListing;
  List<String>? topCatListingDecoded;
  // Completer<ApiCallResponse>? _apiRequestCompleter;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PageController? pageViewController;
  final textFieldKey = GlobalKey();
  TextEditingController? textController;
  String? textFieldSelectedOption;
  Future? topCatListing;

  Future _obtainTopCategory() async {
    return await Provider.of<DashBoardVM>(context, listen: false)
        .fetchTopCategory();
  }

  // UserInfoVM userInfo = UserInfoVM();

  @override
  void initState() {
    super.initState();
    // global.baseAmenities.connectivityChecker(context);
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    topCatListing = _obtainTopCategory();
    // userInfo.getUserInfo();
    // dashBoardScrollController.addListener(onScroll);
    // });
    textController = TextEditingController();
  }

  List<String> _dealimg = [
    "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/rj4a6i3fia24/DailyNeeds.png",
    "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/d0jgtx4mmu7h/GROCERY.png",
    "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/fbluc2px9qsc/Cleaning_&_Household.png",
    "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/b8ln0y3zxluy/BabyCare.png",
    "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/qkynlreas0p1/Beauty_&_Hygiene.png",
    "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/9nfqj83jhv9p/Chocolates_&_Candies.png",
  ];

  String DealTheDayDashBoardImg =
      "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/rj4a6i3fia24/DailyNeeds.png";

  @override
  dispose() {
    // dashBoardScrollController.removeListener(onScroll);
    super.dispose();
  }

// Calls when changes / updates obver widget default state, both dynamic and static
  @override
  void didUpdateWidget(covariant DashBoardWidget oldWidget) {
    topCatListing = _obtainTopCategory();
    // userInfo.getUserInfo();
    super.didUpdateWidget(oldWidget);
  }

  // TopCat Image operants
  String topCatImg(topCat) {
    String topCatimg = "";
    switch (topCat) {
      case "GROCERY":
        topCatimg =
            "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/d0jgtx4mmu7h/GROCERY.png";
        break;
      case "BEVERAGES":
        topCatimg =
            "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/e15r13tlh9t1/Beverages.png";
        break;
      case "EDIBLE OILS":
        topCatimg =
            "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/145hnho9r0pm/Edible_Oils.png";
        break;
      case "HOMECARE":
        topCatimg =
            "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/37u3xmrvggws/HomeCare.png";
        break;

      default:
        topCatimg =
            "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/q2s-mart-50hdbx/assets/e15r13tlh9t1/Beverages.png";
        break;
    }
    return topCatimg;
  }

  final localDBPref = UserSharedPreferences();

  List<String> locationList = ["chennai", "delhi", "bangalore"];
  String? _fetchedLocation;

  @override
  Widget build(BuildContext context) {
    final status = Provider.of<DashBoardVM>(context, listen: true);
    var customStyle = FlutterFlowTheme.of(context);
    var abstractString = context.resources.strings;
    super.widget.createState();
    Provider.of<UserInfoVM>(context, listen: false).getUserInfo();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: ListView(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            context.pushNamed(
                              'locationScreen',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.leftToRight,
                                ),
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 6, 0),
                                child: Icon(
                                  Icons.location_on,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: 20,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'The Hive',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Hive omr, ptk nagar, chennai',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          buttonSize: 40,
                          fillColor: customStyle.secondaryColor,
                          icon: Icon(
                            Icons.format_align_right,
                            color: customStyle.primaryColor,
                            size: 20,
                          ),
                          onPressed: () async {
                            context.pushNamed(
                              'menuScreen',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.rightToLeft,
                                ),
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Autocomplete<String>(
                      initialValue: TextEditingValue(),
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return <String>[].where((option) {
                          final lowercaseOption = option.toLowerCase();
                          return lowercaseOption
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        return AutocompleteOptionsList(
                          textFieldKey: textFieldKey,
                          textController: textController!,
                          options: options.toList(),
                          onSelected: onSelected,
                          textStyle: FlutterFlowTheme.of(context).bodyText1,
                          textHighlightStyle: TextStyle(),
                          elevation: 4,
                          optionBackgroundColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          optionHighlightColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          maxHeight: 200,
                        );
                      },
                      onSelected: (String selection) {
                        setState(() => textFieldSelectedOption = selection);
                        FocusScope.of(context).unfocus();
                      },
                      fieldViewBuilder: (
                        context,
                        textEditingController,
                        focusNode,
                        onEditingComplete,
                      ) {
                        textController = textEditingController;
                        return CustomSearchBar(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        child: Stack(
                          children: [
                            PageView(
                              controller: pageViewController ??=
                                  PageController(initialPage: 0),
                              scrollDirection: Axis.horizontal,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/bannerDashBoard.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    'assets/images/bannerDashBoard.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    'assets/images/bannerDashBoard.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 1),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child:
                                    smooth_page_indicator.SmoothPageIndicator(
                                  controller: pageViewController ??=
                                      PageController(initialPage: 0),
                                  count: 3,
                                  axisDirection: Axis.horizontal,
                                  onDotClicked: (i) {
                                    pageViewController!.animateToPage(
                                      i,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                  effect:
                                      smooth_page_indicator.ExpandingDotsEffect(
                                    expansionFactor: 2,
                                    spacing: 8,
                                    radius: 16,
                                    dotWidth: 26,
                                    dotHeight: 4,
                                    dotColor: Color(0xFF9E9E9E),
                                    activeDotColor: Color(0xFFF0F0F0),
                                    paintStyle: PaintingStyle.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            context.pushNamed('productItemsPage');
                          },
                          child: CustomViewAllWidget(
                            title: abstractString.kTopCategory,
                            subtitle: abstractString.kTopCategorySub,
                            textColor: Colors.black,
                            iconColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            iconBorderColor:
                                FlutterFlowTheme.of(context).blackwithMinOppac,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: FutureBuilder(
                              future: topCatListing,
                              builder: (context, viewModel) {
                                if (viewModel.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: SpinKitThreeBounce(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      size: 30,
                                    ),
                                  );
                                } else if (viewModel.error != null ||
                                    status.topCategoryMain.data?.result?[0] ==
                                        null) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      abstractString.kContactAdmin,
                                      style: customStyle.bodyText1,
                                    )),
                                  );
                                } else if (status
                                        .topCategoryMain.data?.result?[0] !=
                                    null) {
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                          status
                                              .topCategoryMain
                                              .data!
                                              .result![0]
                                              .length, (topCatBuilderIndex) {
                                        final topCatBuilderItem = status
                                            .topCategoryMain
                                            .data!
                                            .result![0][topCatBuilderIndex];
                                        var img = topCatImg(
                                          topCatBuilderItem["Category"],
                                        );
                                        return InkWell(
                                          onTap: () async {
                                            context.pushNamed(
                                              'productItemsPage',
                                              queryParams: {
                                                'topCatData': serializeParam(
                                                  topCatBuilderItem["Category"],
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 10, 0),
                                              child: Stack(
                                                //mainAxisSize: MainAxisSize.min,

                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -0.5, -0.2),
                                                    child: CustomPaint(
                                                      foregroundPainter:
                                                          CustomCirclesPainter(),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -0.5, -0.9),
                                                    child: CachedNetworkImage(
                                                      placeholder: (context,
                                                              url) =>
                                                          CupertinoActivityIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                      width: 100,
                                                      fit: BoxFit.fitHeight,
                                                      imageUrl: img,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -0.5, 1.0),
                                                    child: Text(
                                                        valueOrDefault<String>(
                                                          topCatBuilderItem[
                                                              "Category"],
                                                          abstractString
                                                              .kUndefinedText,
                                                        ),
                                                        style: customStyle
                                                            .subtitle1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: SpinKitThreeBounce(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      size: 30,
                                    ),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                    OrderAgainCard(
                      context,
                      title: abstractString.kOrderAgain,
                      subtitle: abstractString.kOrderAgainSub,
                      textColor: customStyle.blackColor,
                    ),
                    SizedBox(height: 10),
                    CategoryOffer(context),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: customStyle.alternate,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: CustomViewAllWidget(
                                iconBorderColor: FlutterFlowTheme.of(context)
                                    .blackwithMinOppac,
                                title: abstractString.kDealoftheDay,
                                subtitle: '05:45:00',
                                textColor: customStyle.whiteColor,
                                isOpac: true,
                                iconColor:
                                    FlutterFlowTheme.of(context).whiteColor,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                              child: Container(
                                width: double.infinity,
                                // height: 420,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 10),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 20, 0, 0),
                                            child: CustomCachedWebImage(
                                              imageUrl: DealTheDayDashBoardImg,
                                              width: 120,
                                              height: 130,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ToggleIcon(
                                                onPressed: () async {},
                                                value: false,
                                                onIcon: Icon(
                                                  Icons.favorite,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .negativeColor,
                                                ),
                                                offIcon: Icon(
                                                  Icons.favorite_border,
                                                  color: customStyle.blackColor,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: customStyle
                                                          .positiveColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(4,
                                                                      0, 2, 0),
                                                          child: Text(
                                                            '4.5',
                                                            style: customStyle
                                                                .bodyText1
                                                                .override(
                                                              color: customStyle
                                                                  .secondaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.star_half,
                                                          color: customStyle
                                                              .whiteColor,
                                                          size: 18,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 0, 0),
                                                    child: Text(
                                                      'Hurry only 9 left',
                                                      style: customStyle
                                                          .bodyText1
                                                          .override(
                                                        color: customStyle
                                                            .negativeColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            '24 Mantra Organic Jaggery/Gur/Shakkar Powder - 500gms | 100% Organic | Chemical Free',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          // Generated code for this Row Widget...
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  '500g',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .subtitle2
                                                      .override(
                                                        fontSize: 12,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(15, 0, 0, 0),
                                                  child: Container(
                                                    width: 60,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF2B2B8E),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '29% off',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .whiteColor,
                                                                fontSize: 12,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '₹65.69',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                4, 0, 0, 0),
                                                    child: Text(
                                                      '₹96.99',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                color: customStyle
                                                                    .secondaryText,
                                                                fontSize: 16,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              //AddCartBtn(context),
                                            ],
                                          ),
                                          Divider(
                                            indent: 10,
                                            endIndent: 10,
                                            color: Color(0xFF646464),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 80,
                                            child: ListView.builder(
                                              reverse: true,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _dealimg.length,
                                              itemBuilder: (context, int) {
                                                return InkWell(
                                                  onTap: (() {
                                                    setState(
                                                      () {
                                                        DealTheDayDashBoardImg =
                                                            _dealimg[int];
                                                      },
                                                    );
                                                  }),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 2.0,
                                                        color:
                                                            (DealTheDayDashBoardImg ==
                                                                    _dealimg[
                                                                        int])
                                                                ? customStyle
                                                                    .primaryColor
                                                                : customStyle
                                                                    .whiteColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 10, 0),
                                                    child: CustomCachedWebImage(
                                                      imageUrl: _dealimg[int],
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                          left: 10,
                                          top: 20,
                                          child: Image.asset(
                                              "assets/images/symbol_veg.png")),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BrandsListing(
                      context,
                      title: abstractString.kPopularBrands,
                      bgColor: Color(0xFFFFE4DA),
                      color: FlutterFlowTheme.of(context).primaryColor,
                      subTitle: abstractString.kPopularBrandsSub,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }

  // Future waitForApiRequestCompleter({
  //   double minWait = 0,
  //   double maxWait = double.infinity,
  // }) async {
  //   final stopwatch = Stopwatch()..start();
  //   while (true) {
  //     await Future.delayed(Duration(milliseconds: 50));
  //     final timeElapsed = stopwatch.elapsedMilliseconds;
  //     // final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
  //     // if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
  //     // break;
  //     // }
  //   }
  // }
}

class CustomCirclesPainter extends CustomPainter {
  var myPaint = Paint()
    ..color = Colors.black.withOpacity(0.2)
    ..style = PaintingStyle.fill
    ..strokeWidth = 2.0;

  double radius = 18;

  @override
  void paint(Canvas canvas, Size size) {
    int n = 2;
    var range = List<int>.generate(n, (i) => i + 1);
    for (int i in range) {
      double x = 2 * pi / n;
      double dx = radius * cos(i * x);
      double dy = radius * sin(i * x);
      canvas.rotate(49.8);
      if (i == 1) {
        dx = dx / 4;
      }

      canvas.drawCircle(
          Offset(dx, dy), i == 1 ? radius : radius / 1.3, myPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
