import 'package:bro/models/resource.dart';

Map<String, dynamic> mockedResourceListRaw = {
  'data': {
    'resources': [
      {
        'title': 'Resepter',
        'cover_photo': {
          'url':
              'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/pills_7986ced60e.jpeg'
        },
        'description': 'Dette er en artikkel om resepter.',
        'language': {'slug': 'NO'},
        'resource_group': {'slug': 'resepter'},
        'publisher': {'name': 'Lier Kommune'},
        'category': {'category_name': 'Helsetjenester', 'id': '1'},
        'is_recommended': true,
        'references': [
          {
            'reference_title': 'Hvite resepter',
            'reference_description':
                'Du kan i noen tilfeller få delvis dekning av utgifter til medisiner på hvit resept gjennom bidragsordningen. Resepter kan hentes i alle apotek.\n',
            'reference_url':
                'https://nhi.no/rettigheter-og-helsetjeneste/pasientrettigheter/hvit-resept/',
            'reference_button_text': 'NHI Hvit Resept'
          }
        ],
        'documents': [
          {
            'document_name': 'Status rapport',
            'document_file': {
              'url':
                  'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
            }
          }
        ]
      },
      {
        'title': 'Fastlege',
        'cover_photo': {
          'url':
              'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/doctor_1228629_1920_385e334073.jpg'
        },
        'description':
            'Fastlegen kan tilby kontakt med legekontoret, e-konsultasjon, timebestilling, videokonsultasjon og fornying av resept.',
        'language': {'slug': 'NO'},
        'resource_group': {'slug': 'fastlege'},
        'publisher': {'name': 'Lier Kommune'},
        'category': {'category_name': 'Helsetjenester', 'id': '1'},
        'is_recommended': false,
        'references': [
          {
            'reference_title': 'Finn din fastlege',
            'reference_description':
                'På helsenorge.no kan du logge inn og se din fastlege.',
            'reference_url': 'https://www.helsenorge.no/fastlegen/',
            'reference_button_text': 'www.helsenorge.no/fastlegen'
          }
        ],
        'documents': [
          {
            'document_name': 'Rettigheter til fastlege',
            'document_file': {
              'url':
                  'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
            }
          },
          {
            'document_name': 'Fastlege for dine barn',
            'document_file': {
              'url':
                  'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
            }
          },
          {
            'document_name': 'Bytte av fastlege',
            'document_file': {
              'url':
                  'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
            }
          },
          {
            'document_name': 'Fastlege i Lier kommune',
            'document_file': {
              'url':
                  'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
            }
          },
          {
            'document_name': 'Fastlege utenfor din kommune',
            'document_file': {
              'url':
                  'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
            }
          }
        ]
      }
    ]
  }
};

ResourceList mockedResourceList = ResourceList.takeList([
  {
    'title': 'Resepter',
    'cover_photo': {
      'url':
          'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/pills_7986ced60e.jpeg'
    },
    'description': 'Dette er en artikkel om resepter.',
    'language': {'slug': 'NO'},
    'resource_group': {'slug': 'resepter'},
    'publisher': {'name': 'Lier Kommune'},
    'category': {'category_name': 'Helsetjenester', 'id': '1'},
    'is_recommended': true,
    'references': [
      {
        'reference_title': 'Hvite resepter',
        'reference_description':
            'Du kan i noen tilfeller få delvis dekning av utgifter til medisiner på hvit resept gjennom bidragsordningen. Resepter kan hentes i alle apotek.\n',
        'reference_url':
            'https://nhi.no/rettigheter-og-helsetjeneste/pasientrettigheter/hvit-resept/',
        'reference_button_text': 'NHI Hvit Resept'
      }
    ],
    'documents': [
      {
        'document_name': 'Status rapport',
        'document_file': {
          'url':
              'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
        }
      }
    ]
  },
  {
    'title': 'Fastlege',
    'cover_photo': {
      'url':
          'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/doctor_1228629_1920_385e334073.jpg'
    },
    'description':
        'Fastlegen kan tilby kontakt med legekontoret, e-konsultasjon, timebestilling, videokonsultasjon og fornying av resept.',
    'language': {'slug': 'NO'},
    'resource_group': {'slug': 'fastlege'},
    'publisher': {'name': 'Lier Kommune'},
    'category': {'category_name': 'Helsetjenester', 'id': '1'},
    'is_recommended': false,
    'references': [
      {
        'reference_title': 'Finn din fastlege',
        'reference_description':
            'På helsenorge.no kan du logge inn og se din fastlege.',
        'reference_url': 'https://www.helsenorge.no/fastlegen/',
        'reference_button_text': 'www.helsenorge.no/fastlegen'
      }
    ],
    'documents': [
      {
        'document_name': 'Rettigheter til fastlege',
        'document_file': {
          'url':
              'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
        }
      },
      {
        'document_name': 'Fastlege for dine barn',
        'document_file': {
          'url':
              'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
        }
      },
      {
        'document_name': 'Bytte av fastlege',
        'document_file': {
          'url':
              'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
        }
      },
      {
        'document_name': 'Fastlege i Lier kommune',
        'document_file': {
          'url':
              'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
        }
      },
      {
        'document_name': 'Fastlege utenfor din kommune',
        'document_file': {
          'url':
              'https://bucketeer-b7c112c5-c5e6-4c9d-bcb3-19c69c078026.s3.eu-west-1.amazonaws.com/Status_Report_5_e76c533c72.pdf'
        }
      }
    ]
  }
]);
