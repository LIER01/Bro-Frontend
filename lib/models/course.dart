import 'dart:developer';

import 'package:flutter/foundation.dart';

class Course {
  Course({
    required this.title,
    required this.description,
    required this.slides,
    required this.questions,
  });

  final String title;
  final String description;
  final List<Slide> slides;
  final List<Question> questions;

  Course.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        slides = List<Slide>.from(
            json['slides'].map((model) => Slide.fromJson(model))),
        questions = List<Question>.from(
            json['questions'].map((model) => Question.fromJson(model)));
}

class Slide {
  Slide({
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final SlideImage image;

  Slide.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        image = SlideImage.fromJson(json['image']);
}

class SlideImage {
  SlideImage({required this.url});

  final String url;

  SlideImage.fromJson(Map<String, dynamic> json) : url = json['url'];
}

class Question {
  Question({
    required this.question,
    required this.alternatives,
    required this.clarification,
  });

  final String question;
  final List<Alternative> alternatives;
  final String clarification;

  Question.fromJson(Map<String, dynamic> json)
      : question = json['question'],
        alternatives = List<Alternative>.from(json['alternatives']
            .map((model) => Alternative.fromJson(model))).toList(),
        clarification = json['clarification'];
}

class Alternative {
  Alternative({
    required this.name,
    required this.correct,
    this.image,
  });

  final String name;
  final bool correct;
  final SlideImage? image;

  Alternative.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        correct =
            json['correct'].toString().toLowerCase() == "true" ? true : false,
        image = SlideImage.fromJson(json['image']);
}

class QuestionImage {
  QuestionImage({required this.url});

  final String url;

  QuestionImage.fromJson(Map<String, dynamic> json) : url = json['url'];
}
