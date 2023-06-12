class ChildrenModel {
  String? _regNo;
  String? get getRegNo => _regNo;
  void clearRegNo() {
    _regNo = null;
  }

  void changeRegNo(String regNo) {
    _regNo = regNo;
  }
}
