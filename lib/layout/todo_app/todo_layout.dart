import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_app/shared/cubit/cubit.dart';
import 'package:flutter_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabIcon),
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                    // insertToDatabase(
                    //     title: titleController.text,
                    //     time: timeController.text,
                    //     date: dateController.text)
                    //     .then((value) {
                    //   getDataFromDatabase(database).then((value) {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   isBottomSheetShown = false;
                    //     //   fabIcon = Icons.edit;
                    //     //   tasks = value;
                    //     //   print(tasks);
                    //     // });
                    //   });
                    //
                    // });
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                          (context) => Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(20.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defaultFormField(
                                          controller: titleController,
                                          type: TextInputType.text,
                                          prefix: Icons.title,
                                          label: "Task Title",
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return "Task Must Be Have A Title ..!";
                                            }
                                          }),
                                      SizedBox(height: 10.0),
                                      defaultFormField(
                                          controller: timeController,
                                          type: TextInputType.datetime,
                                          prefix: Icons.watch_later_outlined,
                                          label: "Task Time",
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return "Task Must Be Have A Time ..!";
                                            }
                                          },
                                          onTap: () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now())
                                                .then((value) {
                                              timeController.text = value
                                                  .format(context)
                                                  .toString();
                                            });
                                          }),
                                      SizedBox(height: 10.0),
                                      defaultFormField(
                                          controller: dateController,
                                          type: TextInputType.datetime,
                                          prefix: Icons.calendar_today,
                                          label: "Task Date",
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return "Task Must Be Have A Date ..!";
                                            }
                                          },
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse("2021-12-30"),
                                            ).then((value) {
                                              dateController.text =
                                                  DateFormat.yMMMd()
                                                      .format(value);
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                          elevation: 30.0)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetChange(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetChange(isShow: true, icon: Icons.add);
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archive",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
