int id = 0;
String name = 'Kategoritittel';
String description = 'En litt for kort kategoribeskrivelse';
String coverPhoto = '/image_url.jpg';

Map<String, dynamic> mockedResult = {
  'categories': [
    {
      'name': 'Helsetjenester',
      'cover_photo': {'url': '/uploads/pexels_photo_4047186_0f8687c70e.jpeg'}
    },
    {
      'name': 'Økonomi',
      'cover_photo': {'url': '/uploads/coins_933142c8fe.jpeg'}
    }
  ]
};
