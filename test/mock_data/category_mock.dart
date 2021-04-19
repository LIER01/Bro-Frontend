int id = 0;
String name = 'Kategoritittel';
String description = 'En litt for kort kategoribeskrivelse';
String coverPhoto = '/image_url.jpg';

Map<String, dynamic> mockedResult = {
  'categories': [
    {
      'id': '1',
      'category_name': 'Helse',
      'cover_photo': {'url': '/uploads/placeholder_2_de54aa99d5.png'},
      'description': 'Helsebeskrivelse'
    },
    {
      'id': '2',
      'category_name': 'Økonomi',
      'cover_photo': {'url': '/uploads/brg_a305d8def4.jpeg'},
      'description': 'Økonomibeskrivelse'
    }
  ]
};
