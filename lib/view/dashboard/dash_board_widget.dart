import 'package:flutter/scheduler.dart';
import 'package:jokify/res/AppContextExtension.dart';
import 'package:provider/provider.dart';
import '../plugin/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../../view_model/dashboard/DashboardVM.dart';
// import '../components/custom_view_all_widget.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({Key? key}) : super(key: key);

  @override
  _DashBoardWidgetState createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  List<String>? topCatListingDecoded;
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


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
    topCatListing = _obtainTopCategory();
    });
    textController = TextEditingController();
  }








  @override
  Widget build(BuildContext context) {
    final status = Provider.of<DashBoardVM>(context, listen: true);
    var customStyle = FlutterFlowTheme.of(context);
    var abstractString = context.resources.strings;
    super.widget.createState();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      key: scaffoldKey,
      body: const Center(child: Text("Hi :)"),),
    );
  }

 
}

