import 'package:bro/models/resource.dart';

String image_url = '../../test/mock_data/statics/test.jpeg';
String pdf_url = '../../test/mock_data/statics/test.pdf';

Map<String, dynamic> resourceDetailMockJSON = {
  'resources': [
    {
      'title': 'Resepter',
      'cover_photo': {
        'url': image_url,
      },
      'description': 'Dette er en artikkel om resepter. ',
      'language': {'slug': 'NO'},
      'resource_group': {'slug': 'resepter'},
      'publisher': {'name': 'Lier Kommune'},
      'category': {'category_name': 'Helsetjenester', 'id': '1'},
      'is_recommended': true,
      'references': [
        {
          'reference_title': 'Hvite resepter',
          'reference_description':
              'Du kan i noen tilfeller få delvis dekning av utgifter til medisiner på hvit resept gjennom bidragsordningen.\n',
          'reference_url':
              'https://nhi.no/rettigheter-og-helsetjeneste/pasientrettigheter/hvit-resept/',
          'reference_button_text': 'NHI Hvit Resept'
        }
      ],
      'documents': [
        {
          'document_name': 'Status rapport',
          'document_file': {
            'url': pdf_url,
          }
        }
      ]
    }
  ]
};

Resources resourceDetailMock =
    Resources.fromJson(resourceDetailMockJSON['resources'][0]);
