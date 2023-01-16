import 'package:dowith/app_theme.dart';
import 'package:dowith/database/bloc/bloc.dart';
import 'package:dowith/database/bloc/repository.dart';
import 'package:dowith/database/dao.dart';
import 'package:dowith/database/db_model.dart';
import 'package:flutter/material.dart';

class ScheduleListView extends StatefulWidget {
  const ScheduleListView({Key? key}) : super(key: key);

  @override
  State<ScheduleListView> createState() => _ScheduleListViewState();
}

class _ScheduleListViewState extends State<ScheduleListView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Bloc? _bloc;
  ScrollController? _scrollController;
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    _bloc = Bloc(TodoRepository(DataAccessObject()));
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: StreamBuilder<List<DBModel>>(
        stream: _bloc?.todoListStream,
        builder: (BuildContext context, AsyncSnapshot<List<DBModel>> snapshot) {
          var streamList = snapshot.data;
          if (streamList != null) {
            return ListView.builder(
              itemCount: streamList.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return scheduleView(streamList[index]);
              },
            );
          } else {
            return const Text("Data is Empty");
          }
        },
      ),
    );
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

  Widget scheduleView(DBModel dbModel) {
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
