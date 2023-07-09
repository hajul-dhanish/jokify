import 'package:flutter/scheduler.dart';
import 'package:jokify/data/remote/response/Status.dart';
import 'package:jokify/res/AppContextExtension.dart';
import 'package:jokify/utils/Utils.dart';
import 'package:jokify/view/plugin/flutter_flow_theme.dart';
import 'package:jokify/view_model/dashboard/DashboardVM.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({Key? key}) : super(key: key);

  @override
  _DashBoardWidgetState createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future? accListing;

  Future _obtainTopCategory() async {
    return await Provider.of<DashBoardVM>(context, listen: false)
        .fetchAccList();
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      accListing = _obtainTopCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = Provider.of<DashBoardVM>(context, listen: true);
    var customStyle = FlutterFlowTheme.of(context);
    var abstractString = context.resources.strings;
  
        Provider.of<DashBoardVM>(context, listen: false).fetchAccList();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        key: scaffoldKey,
        body: Consumer<DashBoardVM>(
          builder: (context, value, child) {
            switch (value.accListMain.status) {
              case Status.LOADING:
                return Utils().spikeLoader(context);  

              case Status.ERROR:
                return Center(
                    child: Text(value.accListMain.message.toString()));

              case Status.COMPLETED:
                return FutureBuilder(
                    future: accListing,
                    builder: (BuildContext context, snapshot) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.all(10),
                            leading: CircleAvatar(
                              child: Image.network(
                                value.accListMain.data!.avatar.toString(),
                              ),
                            ),
                            title:
                                Text(value.accListMain.data!.userName.toString()),
                          );
                        }
                      );
                    });

              default:
                return const Text("default");
            }
          },
        ));
  }
}
