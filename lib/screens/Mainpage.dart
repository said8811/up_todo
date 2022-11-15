import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uptodo/database/local_data.dart';
import 'package:uptodo/models/category.dart';
import 'package:uptodo/models/todomodel.dart';
import 'package:uptodo/screens/homepage.dart';
import 'package:uptodo/screens/profile.dart';
import 'package:easy_localization/easy_localization.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TimeOfDay initialtime = TimeOfDay.now();
  TimeOfDay? pickedone;
  int _selectedIndex = 0;
  DateTime pickedtime = DateTime.now();
  String name = "";
  String desc = "";
  int selectedindex = -1;
  int categorid = 0;
  var _currentIntValue = 10;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      HomePage2(onDeleted: () {
        setState(() {});
      }),
      HomePage2(onDeleted: () {
        setState(() {});
      }),
      ProfilePage(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _pages[_selectedIndex],
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        backgroundColor: Colors.black,
        title: Text("HomePage".tr()),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300",
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      // floatingActionButton: Container(
      //   padding: EdgeInsets.all(12),
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: [
      //           Colors.transparent,
      //           Colors.transparent,
      //           Colors.black,
      //         ]),
      //   ),
      //   child: Container(
      //       height: 72,
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         color: AppColors.C_8687E7,
      //       ),
      //       child: Center(
      //         child: Text(
      //           "+",
      //           style: TextStyle(
      //               fontSize: 32,
      //               fontWeight: FontWeight.w400,
      //               color: Colors.white),
      //         ),
      //       )),
      // ),
      floatingActionButton: Stack(children: [
        Positioned(
          bottom: 34,
          left: 155.9,
          child: Container(
            width: 90,
            height: 45.5,
            decoration: const BoxDecoration(
                color: Color(0xff121212),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(76, 80),
                    bottomRight: Radius.elliptical(76, 80))),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 165,
          child: Container(
              height: 72,
              width: 72,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff8687E7),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                height: 350,
                                padding: const EdgeInsets.all(24),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  color: Color(0xff363636),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12),
                                    Text(
                                      "Add task",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(0.87),
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 26),
                                    TextField(
                                      onChanged: (value) {
                                        name = value;
                                      },
                                      maxLines: 1,
                                      maxLength: 25,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          counterStyle:
                                              TextStyle(color: Colors.white),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          hintText: "Title",
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          desc = value;
                                        });
                                      },
                                      maxLines: 2,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          hintText: "Description",
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                    ),
                                    const SizedBox(
                                      height: 28,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: initialtime,
                                            ).then(
                                                (value) => pickedone = value);
                                            /* showDatePicker(
                                                    currentDate: DateTime.now(),
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2022),
                                                    lastDate: DateTime(2023))
                                                .then((value) {
                                              if (value != null) {
                                                setState(() {
                                                  pickedtime = value;
                                                });
                                              }
                                            });*/
/*
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      content: Row(
                                                    children: [
                                                      NumberPicker(
                                                        itemHeight: 40,
                                                        value: _currentIntValue,
                                                        minValue: 0,
                                                        maxValue: 100,
                                                        step:1,
                                                        haptics: true,
                                                        onChanged: (value) =>
                                                            setState(() =>
                                                                _currentIntValue =
                                                                    value),
                                                      ),
                                                    ],
                                                  ));
                                                });*/
                                          },
                                          child: const Icon(
                                            Icons.timer_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return StatefulBuilder(
                                                    builder: (context, State) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Colors.black,
                                                        title: const Center(
                                                          child: Text(
                                                            "Task Category",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        content: Container(
                                                          height: 250,
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                  height: 250,
                                                                  width: 250,
                                                                  child: GridView
                                                                      .builder(
                                                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                              crossAxisCount:
                                                                                  3,
                                                                              mainAxisSpacing:
                                                                                  10,
                                                                              crossAxisSpacing:
                                                                                  3),
                                                                          itemCount:
                                                                              5,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            return InkWell(
                                                                              onTap: () {
                                                                                State(() {
                                                                                  categorid = index;
                                                                                  Navigator.pop(context);
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                height: 100,
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      height: 60,
                                                                                      width: 80,
                                                                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                                                                      color: Colors.green,
                                                                                      child: Center(
                                                                                        child: Icon(
                                                                                          Cotegorys.cotegorys[index].icons,
                                                                                          size: 34,
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 2,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        Cotegorys.cotegorys[index].name,
                                                                                        style: TextStyle(fontSize: 14, color: Colors.white),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          })),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text("ok"))
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }));
                                          },
                                          child: const Icon(
                                            Icons.category_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return StatefulBuilder(
                                                    builder: (context, State) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Colors.black,
                                                        title: const Center(
                                                          child: Text(
                                                            "Task Priority",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        content: Container(
                                                            height: 220,
                                                            width: 250,
                                                            child: GridView
                                                                .builder(
                                                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount:
                                                                            4,
                                                                        mainAxisSpacing:
                                                                            5,
                                                                        crossAxisSpacing:
                                                                            5),
                                                                    itemCount:
                                                                        10,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          selectedindex =
                                                                              index;
                                                                          State(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              90,
                                                                          width:
                                                                              90,
                                                                          padding:
                                                                              const EdgeInsets.all(0),
                                                                          color: selectedindex == index
                                                                              ? const Color(0xff8687E7)
                                                                              : const Color(0xff363636),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Icon(
                                                                                Icons.flag_outlined,
                                                                                size: 30,
                                                                                color: Colors.white,
                                                                              ),
                                                                              Text(
                                                                                '${index + 1}'.toString(),
                                                                                style: const TextStyle(color: Colors.white),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    })),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text("ok"))
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }));
                                          },
                                          child: const Icon(
                                            Icons.flag_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              Navigator.pop(context);
                                              hight = 350;
                                              if (name != "" &&
                                                  desc != "" &&
                                                  pickedone != null) {
                                                var newtask = TodoModel(
                                                    title: name,
                                                    description: desc,
                                                    date: pickedone.toString(),
                                                    categoryid: categorid,
                                                    priority:
                                                        '${1 + selectedindex}',
                                                    isCompleted: 0);
                                                LocalDatabase.insertToDatabase(
                                                    newtask);
                                                selectedindex = -1;
                                                name = "";
                                                desc = "";
                                                pickedone = null;
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        const AlertDialog(
                                                          backgroundColor:
                                                              Colors.black,
                                                          title: Text(
                                                            "Error",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          content: Text(
                                                            "Please fill all fields",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          actions: [],
                                                        ));
                                              }
                                            });
                                          },
                                          child: const Icon(
                                            Icons.send_outlined,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              )),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: null,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          iconSize: 28,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.50),
          backgroundColor: Color(0xff363636),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Index',
            ),
            BottomNavigationBarItem(
              icon: Icon(null),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
