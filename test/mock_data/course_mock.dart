import 'package:bro/models/new_course.dart';
import 'package:bro/models/new_courses.dart';

int id = 0;
String title = 'Et kult kurs!';
String description = 'Dette kurset er veldig kult.';

List<Map<String, dynamic>> mockedCourseList = [
  {
    'id': '1',
    'questions': [
      {'id': '1'},
      {'id': '4'},
      {'id': '5'}
    ],
    'slides': [
      {'id': '1'},
      {'id': '4'},
      {'id': '5'}
    ],
    'title': 'Lier kommune',
    'description': 'Dette kurset skal forklare hva Lier Kommune er.',
    'publisher': {
      'name': 'Lier Kommune',
      'avatar': {
        'url':
            'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/lier_5e37e4691d.png'
      }
    },
    'category': {
      'cover_photo': {
        'url':
            'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/health_14f3a4f9d2.jpeg'
      },
      'category_name': 'Helsetjenester'
    },
    'is_recommended': true,
    'course_group': {'slug': 'lier-kommune-1'}
  },
  {
    'id': '3',
    'questions': [
      {'id': '6'},
      {'id': '7'}
    ],
    'slides': [
      {'id': '6'},
      {'id': '7'},
      {'id': '8'}
    ],
    'title': 'Dan Børge',
    'description': 'Et kurs om Dan Børge',
    'publisher': {
      'name': 'Lier Kommune',
      'avatar': {
        'url':
            'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/lier_5e37e4691d.png'
      }
    },
    'category': {
      'cover_photo': {
        'url':
            'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/education_13150c9fde.jpeg'
      },
      'category_name': 'Utdannelse'
    },
    'is_recommended': true,
    'course_group': {'slug': 'hvem-er-dan-borge'}
  },
  {
    'id': '4',
    'questions': [
      {'id': '8'},
      {'id': '9'}
    ],
    'slides': [
      {'id': '9'},
      {'id': '10'},
      {'id': '11'}
    ],
    'title': 'ICDP',
    'description': 'lær om International Child Development Program',
    'publisher': {
      'name': 'Lier Kommune',
      'avatar': {
        'url':
            'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/lier_5e37e4691d.png'
      }
    },
    'category': {
      'cover_photo': {
        'url':
            'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/family_b9b5f9e2b5.jpeg'
      },
      'category_name': 'Familie'
    },
    'is_recommended': true,
    'course_group': {'slug': 'icdp'}
  },
  {
    'id': '5',
    'questions': [
      {'id': '10'}
    ],
    'slides': [
      {'id': '12'}
    ],
    'title': 'Video test kurs',
    'description': 'Tester video',
    'publisher': {
      'name': 'Kongeriket Norge',
      'avatar': {
        'url':
            'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Riksvaapen_4abe5d30b2.png'
      }
    },
    'category': {
      'cover_photo': {
        'url':
            'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/health_14f3a4f9d2.jpeg'
      },
      'category_name': 'Helsetjenester'
    },
    'is_recommended': false,
    'course_group': {'slug': 'videotest'}
  },
  {
    'id': '6',
    'questions': [
      {'id': '11'},
      {'id': '12'},
      {'id': '13'}
    ],
    'slides': [
      {'id': '13'},
      {'id': '14'},
      {'id': '15'}
    ],
    'title': 'Test Image on alternative',
    'description': 'Dette kurset skal forklare hva Lier Kommune er.',
    'publisher': {
      'name': 'Lier Kommune',
      'avatar': {
        'url':
            'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/lier_5e37e4691d.png'
      }
    },
    'category': {
      'cover_photo': {
        'url':
            'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/health_14f3a4f9d2.jpeg'
      },
      'category_name': 'Helsetjenester'
    },
    'is_recommended': true,
    'course_group': {'slug': 'alternative-image-test'}
  }
];

Map<String, dynamic> mockedCourseMap = {'data': mockedCourseList};

LangCourseList referenceCourseList = LangCourseList.takeList(mockedCourseList);
