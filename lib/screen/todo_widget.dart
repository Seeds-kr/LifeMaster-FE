import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  final List<Map<String, dynamic>> initialTasks;
  final Function(List<Map<String, dynamic>>) onUpdate;

  TodoWidget({required this.initialTasks, required this.onUpdate});

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late List<Map<String, dynamic>> _tasks;
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tasks = widget.initialTasks;
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("할 일 추가"),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: "제목을 입력하세요"),
          ),
          actions: [
            TextButton(
              child: Text("취소하기"),
              onPressed: () {
                Navigator.of(context).pop();
                _taskController.clear();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text("추가하기"),
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  setState(() {
                    _tasks.add({
                      "title": _taskController.text,
                      "checked": false,
                      "created": DateTime.now()
                    });
                    _sortTasks();
                    widget.onUpdate(_tasks);
                    _taskController.clear();
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _sortTasks() {
    _tasks.sort((a, b) {
      if (a["checked"] == b["checked"]) {
        return a["created"].compareTo(b["created"]);
      }
      return a["checked"] ? -1 : 1;
    });
  }

  void _showDeleteConfirmationDialog(Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("목록을 삭제하시겠습니까?"),
          actions: [
            TextButton(
              child: Text("취소하기"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
              ),
              child: Text("삭제"),
              onPressed: () {
                setState(() {
                  _tasks.remove(task);
                  widget.onUpdate(_tasks);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("할 일",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _showAddTaskDialog,
                child: Text("추가", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          Column(
            children: _tasks.map((task) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: task["checked"],
                          onChanged: (bool? value) {
                            setState(() {
                              task["checked"] = value;
                              _sortTasks();
                              widget.onUpdate(_tasks);
                            });
                          },
                        ),
                        Text(task["title"]),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.alarm, color: Colors.grey),
                        SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.grey),
                          onPressed: () {
                            _showDeleteConfirmationDialog(task);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
