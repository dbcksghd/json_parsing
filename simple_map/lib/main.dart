class Study{
  String? id;
  String? name;
  int? level;

  Study({this.id, this.name, this.level});

  factory Study.fromJson(Map<String, dynamic> json){
    return Study(
      id: json['id'],
      name: json['name'],
      level: json['level'],
    );
  }
}