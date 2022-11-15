import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uptodo/database/local_data.dart';
import 'package:uptodo/models/category.dart';
import 'package:uptodo/models/todomodel.dart';

class Infopage extends StatefulWidget {
  TodoModel todomodel;
  final VoidCallback onDeleted;
  final VoidCallback onCompleted;
  Infopage(
      {super.key,
      required this.todomodel,
      required this.onDeleted,
      required this.onCompleted});

  @override
  State<Infopage> createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.cancel_outlined,
                size: 40,
              ),
              color: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.todomodel.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.todomodel.description,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Task time",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Spacer(),
                Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      widget.todomodel.date.toString().substring(10, 15),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            Row(
              children: [
                const Icon(
                  Icons.category_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Task category",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Spacer(),
                catogerys(Cotegorys.cotegorys[widget.todomodel.categoryid])
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            Row(
              children: [
                const Icon(
                  Icons.flag_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Task Priority",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Spacer(),
                Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      widget.todomodel.priority,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete"),
                        content: Text(
                          "Are you sure to delete task ${widget.todomodel.title}",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("NO"),
                          ),
                          TextButton(
                            onPressed: () async {
                              var res = await LocalDatabase.deleteTaskById(
                                  widget.todomodel.id!);

                              if (res != 0) {
                                widget.onDeleted();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("YES"),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                width: 130,
                child: Row(
                  children: const [
                    Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Delete task",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  var completed = TodoModel(
                      id: widget.todomodel.id,
                      title: widget.todomodel.title,
                      description: widget.todomodel.description,
                      date: widget.todomodel.date,
                      categoryid: widget.todomodel.categoryid,
                      priority: widget.todomodel.priority,
                      isCompleted: 1);
                  LocalDatabase.updateTaskById(completed);
                  widget.onCompleted();
                  Navigator.pop(context);
                });
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff8687E7),
                ),
                child: const Center(
                  child: Text(
                    "Complete",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget catogerys(Cotegorys cotegorys) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey,
      ),
      child: Row(
        children: [
          Icon(
            cotegorys.icons,
            color: Colors.blue,
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
