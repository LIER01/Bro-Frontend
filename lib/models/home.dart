class Home {
  final String header;
  final String introduction;

  Home({this.header, this.introduction});

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      header: json['header'],
      introduction: json['introduction'],
    );
  }
}
