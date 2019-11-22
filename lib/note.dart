class Note {
  int id;
  String source;
  String translation;
  List<Phrases> phrases;

  Note({this.id, this.source, this.translation, this.phrases});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    source = json['source'];
    translation = json['translation'];
    if (json['phrases'] != null) {
      phrases = new List<Phrases>();
      json['phrases'].forEach((v) {
        phrases.add(new Phrases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['source'] = this.source;
    data['translation'] = this.translation;
    if (this.phrases != null) {
      data['phrases'] = this.phrases.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Phrases {
  String id;
  String source;
  String translation;

  Phrases({this.id, this.source, this.translation});

  Phrases.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    source = json['source'];
    translation = json['translation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['source'] = this.source;
    data['translation'] = this.translation;
    return data;
  }
}