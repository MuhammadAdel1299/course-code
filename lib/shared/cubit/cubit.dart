import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modules/todo_app/archive/archived_tasks_screen.dart';
import 'package:flutter_app/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:flutter_app/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:flutter_app/shared/cubit/states.dart';
import 'package:flutter_app/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  Database database;
  int currentIndex = 0;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) async {
      print('Database Created');
      await database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT)')
          .then((value) {
        print("Table Created");
      }).catchError((error) {
        print("error When Creating Table ${error.toString()}");
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('Database Opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title , date , time , status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print("$value Inserted Successfully");
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print("error When Inserting ${error.toString()}");
      });
      return null;
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void updateData({
    @required String status,
    @required int id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    @required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void changeBottomSheetChange({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
