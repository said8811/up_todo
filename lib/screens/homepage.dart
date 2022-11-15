import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uptodo/database/local_data.dart';
import 'package:uptodo/models/category.dart';
import 'package:uptodo/models/todomodel.dart';
import 'package:uptodo/screens/info.dart';

class HomePage2 extends StatefulWidget {
  final VoidCallback onDeleted;
  HomePage2({super.key, required this.onDeleted});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

int selectedindex = -1;
bool prioritychanged = false;
double hight = 350;
String newtitle = "";
bool titlechanged = false;
int newcategoryid = 0;
bool catchanged = false;
String newdesc = "";
bool desxchanged = false;
String search = '';
bool timechanged = false;
bool iscompeleted = false;
TimeOfDay initialtime = TimeOfDay.now();
TimeOfDay? pickedone;

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: LocalDatabase.getTaskByTitle(title: search),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                          child: Icon(
                        Icons.file_copy_outlined,
                        color: Colors.white,
                        size: 96,
                      ));
                    }
                    return Container(
                        height: 400,
                        color: Colors.black,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return tasks(snapshot.data![index]);
                          },
                        ));
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tasks(TodoModel tasks) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Infopage(
                      todomodel: tasks,
                      onDeleted: () {
                        setState(() {});
                      },
                      onCompleted: () {
                        setState(() {});
                      },
                    )));
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(18),
        width: MediaQuery.of(context).size.width * 0.5,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  iscompeleted = !iscompeleted;
                  var completed = TodoModel(
                      id: tasks.id,
                      title: tasks.title,
                      description: tasks.description,
                      date: tasks.date,
                      categoryid: tasks.categoryid,
                      priority: tasks.priority,
                      isCompleted: iscompeleted ? 1 : 0);
                  LocalDatabase.updateTaskById(completed);
                });
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2, color: Colors.grey)),
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                      color: tasks.isCompleted == 1
                          ? Colors.green
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tasks.title,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 12),
                                          Text(
                                            "Add task",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                                    .withOpacity(0.87),
                                                fontSize: 20),
                                          ),
                                          const SizedBox(height: 26),
                                          TextFormField(
                                            initialValue: tasks.title,
                                            onChanged: (value) {
                                              titlechanged = true;
                                              newtitle = value;
                                            },
                                            onSaved: (value) {
                                              setState(() {});
                                            },
                                            onTap: () {
                                              setState(() {
                                                hight = 700;
                                              });
                                            },
                                            maxLines: 1,
                                            maxLength: 25,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            decoration: const InputDecoration(
                                                counterStyle: TextStyle(
                                                    color: Colors.white),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                                hintText: "Title",
                                                hintStyle: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            initialValue: tasks.description,
                                            onChanged: (value) {
                                              setState(() {
                                                desxchanged = true;
                                                newdesc = value;
                                              });
                                            },
                                            onTap: () {
                                              setState(() {
                                                hight = 650;
                                              });
                                            },
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                                hintText: "Description",
                                                hintStyle: TextStyle(
                                                    color: Colors.white)),
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
                                                  ).then((value) {
                                                    pickedone = value;
                                                    timechanged = true;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.timer_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              /*
                                                                                    newcategoryid = index;
                                                                                    catchanged = true; */
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return StatefulBuilder(
                                                          builder:
                                                              (context, State) {
                                                            return AlertDialog(
                                                              backgroundColor:
                                                                  Colors.black,
                                                              title:
                                                                  const Center(
                                                                child: Text(
                                                                  "Task Category",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              content:
                                                                  Container(
                                                                height: 250,
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            250,
                                                                        width:
                                                                            250,
                                                                        child: GridView.builder(
                                                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 3),
                                                                            itemCount: 5,
                                                                            itemBuilder: (context, index) {
                                                                              return InkWell(
                                                                                onTap: () {
                                                                                  State(() {
                                                                                    newcategoryid = index;
                                                                                    catchanged = true;
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
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        "ok"))
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
                                                          builder:
                                                              (context, State) {
                                                            return AlertDialog(
                                                              backgroundColor:
                                                                  Colors.black,
                                                              title:
                                                                  const Center(
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
                                                                  child: GridView.builder(
                                                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 5, crossAxisSpacing: 5),
                                                                      itemCount: 10,
                                                                      itemBuilder: (context, index) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            selectedindex =
                                                                                index;
                                                                            State(() {
                                                                              prioritychanged = true;
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                90,
                                                                            width:
                                                                                90,
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            color: selectedindex == index
                                                                                ? Color(0xff8687E7)
                                                                                : Color(0xff363636),
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
                                                                                  style: TextStyle(color: Colors.white),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      })),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            "ok"))
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

                                                    var updatetask = TodoModel(
                                                        id: tasks.id,
                                                        title: titlechanged
                                                            ? newtitle
                                                            : tasks.title,
                                                        description: desxchanged
                                                            ? newdesc
                                                            : tasks.description,
                                                        date: timechanged
                                                            ? pickedone
                                                                .toString()
                                                            : tasks.date,
                                                        categoryid: catchanged
                                                            ? newcategoryid
                                                            : tasks.categoryid,
                                                        priority: prioritychanged
                                                            ? '${selectedindex + 1}'
                                                            : tasks.priority,
                                                        isCompleted: 0);
                                                    LocalDatabase
                                                        .updateTaskById(
                                                            updatetask);
                                                    prioritychanged = false;
                                                    timechanged = false;
                                                    titlechanged = false;
                                                    desxchanged = false;
                                                    catchanged = false;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.send_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tasks.date.length > 4
                            ? "${tasks.date.toString().substring(10, 15)}"
                            : "No date",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          catogerys(Cotegorys.cotegorys[tasks.categoryid]),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.flag_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            tasks.priority,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    /* catogerys(Cotegorys.cotegorys[tasks.categoryid]),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.flag_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      tasks.priority,
                      style: TextStyle(color: Colors.white),
                    )*/
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget catogerys(Cotegorys cotegorys) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      child: Row(
        children: [
          Icon(
            cotegorys.icons,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            cotegorys.name,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
