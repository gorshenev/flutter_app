class Massage{
  final String name;
  final String source;

  Massage(this.name, this.source);

  Massage.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        source = json['source'];

}