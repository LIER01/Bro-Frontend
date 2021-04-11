import 'package:bro/models/new_course.dart';

var new_mock_course = {
  "id": "1",
  "questions": [
    {
      "question": "Testesen",
      "alternatives": [
        {"alternative_text": "test", "image": null, "is_correct": true},
        {"alternative_text": "test2", "image": null, "is_correct": false}
      ],
      "clarification": "adsaddadasd"
    }
  ],
  "slides": [
    {
      "title": "Testslide",
      "description": "Dsadsda",
      "media": {"url": "/uploads/brg_a305d8def4.jpeg"}
    }
  ],
  "title": "Title",
  "description": "Desc",
  "language": {"language_full_name": "Norsk", "slug": "NO"},
  "publisher": {
    "name": "Lier Kommune",
    "avatar": {"url": "/uploads/placeholder_2_de54aa99d5.png"}
  },
  "category": {
    "cover_photo": {"url": "/uploads/placeholder_2_de54aa99d5.png"},
    "category_name": "Helse"
  },
  "is_recommended": false,
  "course_group": {"name": "K1", "slug": "K1"}
};

Courses referenceCourses = Courses.fromJson(new_mock_course);
