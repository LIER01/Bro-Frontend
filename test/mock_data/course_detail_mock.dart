import 'package:bro/models/course.dart';

Map<String, dynamic> course_detail_mock = {
  'course': {
    'title': 'En meget fin testcourse',
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
        'image': {'url': '/uploads/New_Project_1_893ec542a7.png'}
      },
      {
        'title': 'DEN ANDRE MEGET FINE TESTSLIDEN',
        'description':
            'MEN DENNE GANGEN MED MER ROPING I BÅDE TITTEL OG DESCRIPTION',
        'image': {'url': '/uploads/News_018174_Other_001_05e01a146a.jpg'}
      },
    ]
  }
};

Course referenceCourse =
    Course(title: course_detail_mock['course']['title'], questions: [
  Question(
      question: course_detail_mock['course']['questions'][0]['question'],
      alternatives: [
        Alternative(
            name: course_detail_mock['course']['questions'][0]['alternatives']
                [0]['name'],
            correct: course_detail_mock['course']['questions'][0]
                ['alternatives'][0]['correct'],
            image: course_detail_mock['course']['questions'][0]['alternatives']
                [0]['image']),
        Alternative(
            name: course_detail_mock['course']['questions'][0]['alternatives']
                [1]['name'],
            correct: course_detail_mock['course']['questions'][0]
                ['alternatives'][1]['correct'],
            image: course_detail_mock['course']['questions'][0]['alternatives']
                [1]['image'])
      ],
      clarification: course_detail_mock['course']['questions'][0]
          ['clarification'])
], slides: [
  Slide(
      title: course_detail_mock['course']['slides'][0]['title'],
      description: course_detail_mock['course']['slides'][0]['description'],
      image: SlideImage(
          url: course_detail_mock['course']['slides'][0]['image']['url'])),
  Slide(
      title: course_detail_mock['course']['slides'][1]['title'],
      description: course_detail_mock['course']['slides'][1]['description'],
      image: SlideImage(
          url: course_detail_mock['course']['slides'][1]['image']['url']))
]);
