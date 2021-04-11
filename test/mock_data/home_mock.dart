import 'package:bro/models/course.dart';
import 'package:bro/models/home.dart';

String header = 'Velkommen til Bro';
String introduction =
    'Dette er en introduksjons tekst som skal være passe lang.';

Home mockedHome = Home(header: header, introduction: introduction);

Course mockedCourse = Course(
    title: 'Kurstittel',
    description: 'Kursbeskrivelse',
    slides: [],
    questions: []);
