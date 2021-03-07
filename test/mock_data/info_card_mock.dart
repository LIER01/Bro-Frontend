String title = 'En meget fin testcourse';
String cardTitle = 'Testslide';
String description = 'Dette er en meget kul testslide';
String url = '../../test/mock_data/statics/Capture.PNG';
List<dynamic> slides = [
  {
    'title': cardTitle,
    'description': description,
    'image': {'url': url}
  },
  {
    'title': cardTitle,
    'description': description,
    'image': {'url': url}
  }
];

Map<String, dynamic> mockedResult = {
  'data': {
    'course': {'title': title, 'slides': slides}
  }
};
