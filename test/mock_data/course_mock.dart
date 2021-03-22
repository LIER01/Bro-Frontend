int id = 0;
String title = 'Et kult kurs!';
String description = 'Dette kurset er veldig kult.';

Map<String, dynamic> mockedResult = {
  'data': {
    'courses': [
      {
        'id': 0,
        'title': title,
        'description': description,
        'questions': [
          {'id': 0},
          {'id': 1},
        ],
        'slides': [
          {'id': 0},
          {'id': 1},
          {'id': 2},
        ],
      },
    ]
  }
};
