class Home {
  Home({required this.header, required this.introduction});
  final String header;
  final String introduction;

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      header: json['home']['header'],
      introduction: json['home']['introduction'],
    );
  }
}
