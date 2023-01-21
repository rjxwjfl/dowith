import 'package:dowith/app_theme.dart';
import 'package:dowith/database/db_repository.dart';
import 'package:dowith/database/todo_dao.dart';
import 'package:dowith/database/todo_model.dart';
import 'package:dowith/main.dart';
import 'package:flutter/material.dart';

import '../../database/bloc.dart';
import 'model/editing_page.dart';

class ScheduleListView extends StatefulWidget {
  const ScheduleListView({Key? key}) : super(key: key);

  @override
  State<ScheduleListView> createState() => _ScheduleListViewState();
}

class _ScheduleListViewState extends State<ScheduleListView> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _bloc = Bloc(DBRepository(TodoDao()));
  ScrollController? _scrollController;
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            titleUI(context, "TEXT"),
            SizedBox(
              height: 350,
              child: listStreamingObject(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const EditingPage()));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        backgroundColor: AppTheme.dismissibleBackground,
        child: const Icon(Icons.add),
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

  Widget listStreamingObject(){
    return StreamBuilder<List<TodoModel>>(
      initialData: const [],
      stream: modelBox.databaseStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("length? : ${snapshot.data!.length}");
          if (snapshot.data!.isNotEmpty) {
            return ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) => const Divider(color: AppTheme.darkerText,),
              itemBuilder: (context, index) {
                return scheduleView(snapshot.data![index]);
              },
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
            );
          }
          print("여기있다");
        }
        return const Center(child: Text("add data"));
      },
    );
  }

  Widget scheduleView(TodoModel todoModel) {
    return Center(
      child: Container(
        color: Colors.yellow,
        child: Text(todoModel.title.toString()),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
