import 'dart:developer';

import 'package:flutter/foundation.dart';

class Course {
  Course({
    this.title,
    this.description,
    this.slides,
    this.questions,
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
  // slides = Slide.fromJson(json['slides']);
}

class Slide {
  Slide({
    this.title,
    this.description,
    this.image,
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
  SlideImage({this.url});

  final String url;

  SlideImage.fromJson(Map<String, dynamic> json) : url = null;
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

  Question.fromJson(Map<String, dynamic> json)
      : question = json['question'],
        alternatives = parseAlternatives(json),
        // alternatives = List<Alternative>.from(json['alternatives']
        //     .map((model) => Alternative.fromJson(model))).toList(),
        clarification = json['clarification'];
}

List<Alternative> parseAlternatives(Map<String, dynamic> json) {
  debugPrint(json.toString());
  Iterable list = json['products'];
  List<Alternative> alternatives =
      List<Alternative>.from(list.map((model) => Alternative.fromJson(model)));
  return alternatives;
}

class Alternative {
  Alternative({
    this.name,
    this.correct,
    this.image,
  });

  final String name;
  final bool correct;
  final SlideImage image;

  Alternative.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        correct =
            json['correct'].toString().toLowerCase() == "true" ? true : false,
        image = SlideImage.fromJson(json['image']);
}
