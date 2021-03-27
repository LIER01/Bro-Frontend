Map<String, dynamic> course_detail_mock = {
  'data': {
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
  }
};
