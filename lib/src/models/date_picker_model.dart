class DatePickerModel {
  String id;
  String title;
  DateTime startDate;
  DateTime endDate;

  DatePickerModel({this.id, this.title, this.startDate, this.endDate});

  DatePickerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
