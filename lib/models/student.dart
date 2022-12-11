class Student {
  int id = 0;
  String firstName = "";
  String lastName = "";
  int grade = 0;
  String _status = "";
  String imgUrl = "";

  Student.withOutInfo();
  Student.withId(this.id, this.firstName, this.lastName, this.grade, this.imgUrl);
  Student(this.firstName, this.lastName, this.grade, this.imgUrl);

  String get getStatus {
    String message = "";
    if (grade >= 50) {
      message = "Geçti";
    } else if (grade >= 40) {
      message = "Bütünlemeye kaldı";
    } else {
      message = "Kaldı";
    }
    return message;
  }
}
