import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_basic/constants/colors.dart';
import 'package:todo_app_basic/constants/icons.dart';
import 'package:todo_app_basic/screens/login.dart';

class ToDoModelClass {
  String title;
  String description;
  String date;
  ToDoModelClass({
    required this.title,
    required this.description,
    required this.date,
  });
}

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  // CONTROLLERS
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  // TASK LIST
  List<ToDoModelClass> tasks = [
    ToDoModelClass(
      title: 'Meeting with Elon Musk',
      description: 'Yeah meet to the elon musk at this morning only.',
      date: '14-April-2024',
    ),
    ToDoModelClass(
      title: 'Meeting with Shashi Sir',
      description: 'Yeah meet to the Shashi Sir at this morning only.',
      date: '20-June-2024',
    ),
    ToDoModelClass(
      title: 'Meeting with David Melon',
      description: 'Yeah meet to the David Melon at this morning only.',
      date: '22-June-2024',
    ),
  ];

  // =================== BUILD =======================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style:
              GoogleFonts.quicksand(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
        foregroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen(users);
                  },
                ),
              );
            },
            child: const Icon(
              Icons.logout_rounded,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 500,
                  ),
                ],
                color: colors[index % colors.length],
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 6,
                      ),
                      Container(
                        height: 52,
                        width: 52,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          icons[index % icons.length],
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks[index].title,
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              tasks[index].description,
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(84, 84, 84, 1),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          '12-July-2024',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            myBottomSheet(true, tasks[index]);
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showMyDialog(tasks[index]);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          clearController();
          myBottomSheet(false);
        },
        child: Image.asset(
          'assets/add.png',
          height: 70,
          width: 70,
        ),
      ),
    );
  }

  // =================== BOTTOM SHEET =======================
  void myBottomSheet(bool isEditing, [ToDoModelClass? todoItem]) {
    if (isEditing) {
      titleController.text = todoItem!.title;
      descriptionController.text = todoItem.description;
      dateController.text = todoItem.date;
    }
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 500,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Task',
                      style: GoogleFonts.quicksand(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text('Title', style: GoogleFonts.quicksand()),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text('Description', style: GoogleFonts.quicksand()),
                TextField(
                  maxLines: 3,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Date',
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    // color: const Color.fromRGBO(0, 139, 148, 1),
                  ),
                ),
                TextField(
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2030),
                        );
                        dateController.text =
                            DateFormat.yMMMd().format(pickedDate!);
                      },
                      child: const Icon(
                        Icons.calendar_month,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(
                            Size(300, 50),
                          ),
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(2, 167, 177, 1),
                          ),
                          foregroundColor: MaterialStatePropertyAll(
                            Colors.white,
                          )),
                      onPressed: () {
                        setState(() {});
                        (isEditing) ? submit(true, todoItem) : submit(false);
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =================== SUBMIT =======================
  void submit(bool isEditing, [ToDoModelClass? todoItem]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!isEditing) {
        tasks.add(
          ToDoModelClass(
            title: titleController.text,
            description: descriptionController.text,
            date: dateController.text,
          ),
        );
      } else {
        todoItem!.title = titleController.text;
        todoItem.description = descriptionController.text;
        todoItem.date = dateController.text;
      }
      Navigator.pop(context);
    }
  }

  // =================== CONFIRM DELETE =======================
  Future<void> _showMyDialog(ToDoModelClass? todoItem) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Would you like to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 30,
                width: 70,
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                height: 30,
                width: 70,
                child: const Center(
                  child: Text(
                    'Delete',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {});
                tasks.remove(todoItem);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // =================== CLEAR CONTROLLER =======================
  void clearController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }
}
