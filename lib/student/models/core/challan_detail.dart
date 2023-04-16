import 'dart:convert';

class ChallanDetail {
  String id;
  int feeId;
  int installmentNo;
  int amount;
  String issueDate;
  String expiryDate;
  bool status;
  String? challanImage;
  ChallanDetail(
      {required this.id,
      required this.amount,
      required this.challanImage,
      required this.feeId,
      required this.installmentNo,
      required this.issueDate,
      required this.expiryDate,
      required this.status});

  static List<ChallanDetail> fromJson(String body) {
    return (jsonDecode(body) as List<dynamic>)
        .map((e) => ChallanDetail(
            id: e['id'],
            amount: e['amount'],
            feeId: e['fee_id'],
            installmentNo: e['installment_no'],
            challanImage: e['challan_image'],
            issueDate: e['issue_date'],
            expiryDate: e['expiry_date'],
            status: e['status']))
        .toList();
  }
}
