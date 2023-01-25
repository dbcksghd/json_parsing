class OsjList {
  final List<Osj>? tests;

  OsjList({this.tests});

  factory OsjList.fromJson(List<dynamic> json) {
    List<Osj> tests = <Osj>[];
    tests = json.map((i) => Osj.fromJson(i)).toList();

    return OsjList(
      tests: tests,
    );
  }
}

class Osj {
  final int id;
  final int state;
  final String deviceType;
  final int alive;

  Osj(
      {required this.id,
      required this.state,
      required this.deviceType,
      required this.alive});

  factory Osj.fromJson(Map<String, dynamic> json) {
    return Osj(
      id: json['id'],
      state: json['state'],
      deviceType: json['device_type'],
      alive: json['alive'],
    );
  }
}
