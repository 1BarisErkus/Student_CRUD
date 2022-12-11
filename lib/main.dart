import 'package:flutter/material.dart';
import 'package:temel_widget/models/student.dart';
import 'package:temel_widget/screens/student_add.dart';
import 'package:temel_widget/screens/student_edit.dart';
import 'package:temel_widget/validation/student_validatior.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = "Öğrenci Takip Sistemi!";

  Student selectedStudent = Student("", "", 0, "");

  List<Student> students = [
    Student.withId(1, "Barış", "Erkuş", 25,
        "https://media-exp1.licdn.com/dms/image/C4D03AQFh2MpRui2lFA/profile-displayphoto-shrink_800_800/0/1660848159698?e=1675900800&v=beta&t=It6TJaxRRUQkA63OBaF8zmu2asoOZHEH5fhF1ABBkJo"),
    Student.withId(2, "Mert", "Durukan", 45,
        "https://media-exp1.licdn.com/dms/image/C4D03AQEIrHs0ekoDMQ/profile-displayphoto-shrink_800_800/0/1652052013383?e=1675900800&v=beta&t=YtawH3_Vj_w6iXFtWwI0E3JHimkOumg5BVoDtwzYVaU"),
    Student.withId(3, "Damla", "Erkuş", 65,
        "https://cdn.pixabay.com/photo/2020/02/08/00/32/icon-4828765_960_720.jpg"),
  ];

_getRequests() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(message),
        ),
        body: buildBody(context));
  }

  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: const Text("İşlem Sonucu"),
      content: Text(mesaj),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(students[index].imgUrl),
                    ),
                    title: Text(
                        '${students[index].firstName} ${students[index].lastName}'),
                    subtitle: Text(
                        'Sınavdan aldığı not: ${students[index].grade}[${students[index].getStatus}]'),
                    trailing: buildStatusIcon(students[index].grade),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index];
                      });
                    });
              }),
        ),
        Text(
            'Seçili öğrenci: ${selectedStudent.firstName} ${selectedStudent.lastName}'),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.green)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentAdd(students))).then((value) => _getRequests());
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.add),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text("Yeni Kayıt"),
                    ],
                  )),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blue)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentEdit(selectedStudent))).then((value) => _getRequests());
                },
                child: Row(
                  children: const [
                    Icon(Icons.update),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text('Güncelle'),
                  ],
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.red)),
                  onPressed: () {
                    setState(() {
                      students.remove(selectedStudent);
                    });
                    var mesaj =
                        "Öğrenci ${selectedStudent.firstName} başarıyla silindi.";
                    mesajGoster(context, mesaj);
                    setState(() {
                      selectedStudent = Student("", "", 0, "");
                    });
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.delete),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('Sil'),
                    ],
                  )),
            )
          ],
        )
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return const Icon(Icons.done);
    } else if (grade >= 40) {
      return const Icon(Icons.album);
    } else {
      return const Icon(Icons.clear);
    }
  }
}
