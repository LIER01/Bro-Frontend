// id,
// title,
// description,
// questions {id},
// slides {id},

class ReducedCourse {
  ReducedCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.slides,
    required this.questions,
  });

  final int id;
  final String title;
  final String description;
  final List<Slide> slides;
  final List<Question> questions;

  ReducedCourse.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        title = json['title'],
        description = json['description'],
        slides = List<Slide>.from(
            json['slides'].map((model) => Slide.fromJson(model))),
        questions = List<Question>.from(
            json['questions'].map((model) => Question.fromJson(model)));
}

class Slide {
  Slide({
    required this.id,
  });

  final int id;

  Slide.fromJson(Map<String, dynamic> json) : id = int.parse(json['id']);
}

class Question {
  Question({required this.id});

  final int id;

  Question.fromJson(Map<String, dynamic> json) : id = int.parse(json['id']);
}
