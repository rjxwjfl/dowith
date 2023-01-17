import 'package:dowith/app_theme.dart';
import 'package:dowith/database/todo_model.dart';
import 'package:flutter/material.dart';
class ScheduleListView extends StatefulWidget {
  const ScheduleListView({Key? key}) : super(key: key);

  @override
  State<ScheduleListView> createState() => _ScheduleListViewState();
}

class _ScheduleListViewState extends State<ScheduleListView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ScrollController? _scrollController;
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material();
  }

  Widget titleUI(BuildContext context, String title) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: AppTheme.appThemeColorTab,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
          child: Text(title),
        ),
      ),
    );
  }

  Widget scheduleView(TodoModel todoModel) {
    return Center(
      child: Container(
        height: 400,
        color: Colors.yellow,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
