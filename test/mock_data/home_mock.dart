import 'package:bro/models/home.dart';
import 'package:bro/models/new_course.dart';

String header = 'Velkommen til Bro';
String introduction =
    'Dette er en introduksjons tekst som skal være passe lang.';

Home mockedHome = Home(header: header, introduction: introduction);

Courses mockedCourse = Courses(
    title: 'Kurstittel',
    description: 'Kursbeskrivelse',
    slides: [],
    questions: [],
    isRecommended: false);
