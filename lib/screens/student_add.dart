import 'package:flutter/material.dart';
import 'package:temel_widget/validation/student_validatior.dart';
import '../models/student.dart';

class StudentAdd extends StatefulWidget {
  List<Student> students;

  StudentAdd(this.students);

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  List<Student> students;
  var student = Student.withOutInfo();
  var formKey = GlobalKey<FormState>();

  _StudentAddState(this.students);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Yeni öğrenci ekle"),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  buildFirstNameField(),
                  buildLastNameField(),
                  buildGradeField(),
                  buildImgUrlField(),
                  buildSubmitButton()
                ],
              )),
        ));
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration:
          const InputDecoration(labelText: "Öğrenci adı", hintText: "Barış"),
      validator: validateFirstName,
      onSaved: (value) {
        student.firstName = value!;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      decoration:
          const InputDecoration(labelText: "Öğrenci soyadı", hintText: "Erkuş"),
      validator: validateLastName,
      onSaved: (value) {
        student.lastName = value!;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      decoration:
          const InputDecoration(labelText: "Aldığı not", hintText: "65"),
      validator: validateGrade,
      onSaved: (value) {
        student.grade = int.parse(value!);
      },
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          students.add(student);
          Navigator.pop(context);
        }
      },
      child: const Text("Kaydet"),
    );
  }

  buildImgUrlField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Resim Url", hintText: "www.MyImage.com"),
      validator: validateImgUrl,
      onSaved: (value) {
        student.imgUrl = value!;
      },
    );
  }
}
