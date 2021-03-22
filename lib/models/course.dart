class Course {
  Course({
    this.title,
    this.description,
    this.slides,
    this.questions,
  });

  final String title;
  final String description;
  final List<dynamic> slides;
  final List<dynamic> questions;
}

class Slide {
  Slide({
    this.title,
    this.description,
    this.image,
  });

  final String title;
  final String description;
  final String image;
}

class Question {
  Question({
    this.question,
    this.alternatives,
    this.clarification,
  });

  final String question;
  final List<Alternative> alternatives;
  final String clarification;
}

class Alternative {
  Alternative({
    this.name,
    this.correct,
    this.image,
  });

  final String name;
  final bool correct;
  final String image;
}
