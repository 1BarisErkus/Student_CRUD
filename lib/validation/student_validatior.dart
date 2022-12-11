class StudentValidationMixin {
  String? validateFirstName(String? value) {
    if (value!.length < 2) {
      return "İsim en az iki karakter olmalıdır";
    }
  }

  String? validateLastName(String? value) {
    if (value!.length < 2) {
      return "Soyisim en az iki karakter olmalıdır";
    } 
  }

  String? validateGrade(String? value) {
    if(value!.isEmpty){
      return "Not değeri boş olamaz";
    }
    var grade = int.parse(value!);
    if (grade < 0 || grade > 100) {
      return "Not 0-100 arasında olmalıdır";
    } 
  }

  String? validateImgUrl(String? value) {
    if(value!.isEmpty || value == null){
      return "Lütfen resim URL'si ekleyin";
    }
  }
}
