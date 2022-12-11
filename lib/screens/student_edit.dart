import 'package:flutter/material.dart';
import 'package:temel_widget/validation/student_validatior.dart';
import '../models/student.dart';

class StudentEdit extends StatefulWidget {
  Student selectedStudent;

  StudentEdit(this.selectedStudent);

  @override
  State<StatefulWidget> createState() {
    return _StudentUpdateState(selectedStudent);
  }
}

class _StudentUpdateState extends State with StudentValidationMixin {
  Student selectedStudent;
  var formKey = GlobalKey<FormState>();

  _StudentUpdateState(this.selectedStudent);

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
        selectedStudent.firstName = value!;
      },
      initialValue: selectedStudent.firstName,
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      decoration:
          const InputDecoration(labelText: "Öğrenci soyadı", hintText: "Erkuş"),
      validator: validateLastName,
      onSaved: (value) {
        selectedStudent.lastName = value!;
      },
      initialValue: selectedStudent.lastName,
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      decoration:
          const InputDecoration(labelText: "Aldığı not", hintText: "65"),
      validator: validateGrade,
      onSaved: (value) {
        selectedStudent.grade = int.parse(value!);
      },
      initialValue: selectedStudent.grade.toString(),
    );
  }

  buildImgUrlField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Resim Url", hintText: "www.MyImage.com"),
      validator: validateImgUrl,
      onSaved: (value) {
        selectedStudent.imgUrl = value!;
      },
      initialValue: selectedStudent.imgUrl,
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          Navigator.pop(context);
        }
      },
      child: const Text("Kaydet"),
    );
  }
}
