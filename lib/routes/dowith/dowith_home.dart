import 'package:dowith/app_theme.dart';
import 'package:flutter/material.dart';

import 'object_three.dart';
import 'object_two.dart';
import 'schedule_list_view.dart';


class DowithHome extends StatefulWidget {
  const DowithHome({Key? key}) : super(key: key);

  @override
  State<DowithHome> createState() => _DowithHomeState();
}

class _DowithHomeState extends State<DowithHome>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppTheme.nearlyWhite,
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: AppTheme.nearlyDarkBlue,
          labelColor: AppTheme.nearlyDarkBlue,
          unselectedLabelColor: AppTheme.nearlyBlue,
          controller: _tabController,
          tabs: const [
            Tab(
              text: "항목1",
            ),
            Tab(
              text: "항목2",
            ),
            Tab(
              text: "항목3",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          ScheduleListView(),
          ObjectTwo(),
          ObjectThree(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
