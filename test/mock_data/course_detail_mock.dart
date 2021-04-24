import 'package:bro/models/course.dart';

String url = '../../test/mock_data/statics/test.jpeg';
Map<String, dynamic> course_detail_mock = {
  'course': {
    'title': 'En meget fin testcourse',
    'description': 'en meget bra testdescription',
    'questions': [
      {
        'question': 'Testspørsml',
        'alternatives': [
          {'name': 'Testsvar 1 Rett svar', 'image': null, 'correct': true},
          {'name': 'Testsvar 2', 'image': null, 'correct': false}
        ],
        'clarification':
            'Dette er et meget godt eksempel på en \'clarification\''
      },
    ],
    'slides': [
      {
        'title': 'Testslide',
        'description': 'Dette er en meget kul testslide',
        'image': {'url': url}
      },
      {
        'title': 'DEN ANDRE MEGET FINE TESTSLIDEN',
        'description':
            'MEN DENNE GANGEN MED MER ROPING I BÅDE TITTEL OG DESCRIPTION',
        'image': {'url': url}
      },
    ]
  }
};

Course referenceCourse = Course(
    title: course_detail_mock['course']['title'],
    description: course_detail_mock['course']['description'],
    questions: [
      Question(
          question: course_detail_mock['course']['questions'][0]['question'],
          alternatives: [
            Alternative(
                image: course_detail_mock['course']['questions'][0]
                    ['alternatives'][0]['image'],
                alternativeText: course_detail_mock['course']['questions'][0]
                    ['alternatives'][0]['name'],
                isCorrect: course_detail_mock['course']['questions'][0]
                    ['alternatives'][0]['correct']),
            Alternative(
                image: course_detail_mock['course']['questions'][0]
                    ['alternatives'][1]['image'],
                alternativeText: course_detail_mock['course']['questions'][0]
                    ['alternatives'][1]['name'],
                isCorrect: course_detail_mock['course']['questions'][0]
                    ['alternatives'][1]['correct']),
          ],
          clarification: course_detail_mock['course']['questions'][0]
              ['clarification'])
    ],
    slides: [
      Slide(
          title: course_detail_mock['course']['slides'][0]['title'],
          description: course_detail_mock['course']['slides'][0]['description'],
          media: Media(
              url: course_detail_mock['course']['slides'][0]['image']['url'])),
      Slide(
          title: course_detail_mock['course']['slides'][1]['title'],
          description: course_detail_mock['course']['slides'][1]['description'],
          media: Media(
              url: course_detail_mock['course']['slides'][1]['image']['url']))
    ],
    isRecommended: false);
