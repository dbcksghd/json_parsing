class Model {
  Model({
    this.id,
    this.state,
    this.deviceType,
    this.alive,
  });

  Model.fromJson(dynamic json) {
    id = json['id'];
    state = json['state'];
    deviceType = json['device_type'];
    alive = json['alive'];
  }

  int? id;
  int? state;
  String? deviceType;
  int? alive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['state'] = state;
    map['device_type'] = deviceType;
    map['alive'] = alive;
    return map;
  }
}
