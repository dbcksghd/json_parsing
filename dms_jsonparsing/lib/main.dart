class Test {
  Date? date;

  Test({this.date});

  Test.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    return data;
  }
}

class Date {
  List<String>? breakfast;
  List<String>? dinner;
  List<String>? lunch;

  Date({this.breakfast, this.dinner, this.lunch});

  Date.fromJson(Map<String, dynamic> json) {
    breakfast = json['breakfast'].cast<String>();
    dinner = json['dinner'].cast<String>();
    lunch = json['lunch'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breakfast'] = this.breakfast;
    data['dinner'] = this.dinner;
    data['lunch'] = this.lunch;
    return data;
  }
}