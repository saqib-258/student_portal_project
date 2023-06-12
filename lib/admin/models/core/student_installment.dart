import 'dart:convert';

class Installment {
  int? amount;
  int? installmentno;

  Installment({this.amount, this.installmentno});

  Installment.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    installmentno = json['installment_no'];
  }
}

class StudentInstallment {
  int? id;
  String? name;
  String? regno;
  String? section;
  int? semester;
  String? program;
  String? profilephoto;
  List<Installment?>? installments;

  StudentInstallment.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    regno = json['reg_no'];
    section = json['section'];
    semester = json['semester'];
    program = json['program'];
    profilephoto = json['profile_photo'];
    if (json['installments'] != null) {
      installments = <Installment>[];
      json['installments'].forEach((v) {
        installments!.add(Installment.fromJson(v));
      });
    }
  }
  static List<StudentInstallment> fromJson(String jsonString) {
    final data = jsonDecode(jsonString);

    return List<StudentInstallment>.from(
        data.map((studentJson) => StudentInstallment.fromMap(studentJson)));
  }
}
