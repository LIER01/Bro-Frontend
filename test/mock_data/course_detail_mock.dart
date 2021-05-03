import 'package:bro/models/course.dart';

String url = 'assets/images/placeholder.png';

var mockCourse = {
  'questions': [
    {
      'question': 'I hvilket fylke ligger Lier kommune',
      'alternatives': [
        {'alternative_text': 'Viken', 'image': null, 'is_correct': true},
        {'alternative_text': 'Trøndelag', 'image': null, 'is_correct': false},
        {'alternative_text': 'Vestlandet', 'image': null, 'is_correct': false},
        {'alternative_text': 'Vestfold', 'image': null, 'is_correct': false}
      ],
      'clarification':
          'Etter 1. januar 2020, har Lier kommune ligget i Viken fylke,'
    },
    {
      'question': 'Hvor mange bor i Lierbyen?',
      'alternatives': [
        {'alternative_text': '50 000', 'image': null, 'is_correct': false},
        {'alternative_text': '4 662', 'image': null, 'is_correct': true},
        {'alternative_text': '300', 'image': null, 'is_correct': false},
        {'alternative_text': '12', 'image': null, 'is_correct': false}
      ],
      'clarification': 'Per 2012, så hadde Lier kommune en befolkning på 4662.'
    },
    {
      'question': 'Hvilke av disse funksjonene har Flyktningtjenesten?',
      'alternatives': [
        {
          'alternative_text': 'Hjelpe flyktninger med bosetting',
          'image': null,
          'is_correct': true
        },
        {
          'alternative_text': 'Hjelpe flyktninger med hogst',
          'image': null,
          'is_correct': false
        },
        {
          'alternative_text': 'Hjelpe flyktninger med å spille fotball',
          'image': null,
          'is_correct': false
        },
        {
          'alternative_text': 'Hjelpe flyktninger med å kjøre bil',
          'image': null,
          'is_correct': false
        }
      ],
      'clarification':
          'En av oppgavene til flyktningtjenesten er å hjelpe flyktninger med bosetting.'
    }
  ],
  'slides': [
    {
      'title': 'Informasjon om Lier',
      'description':
          'Lier er en kommune i landskapet Buskerud i Viken fylke. Den grenser i nord til Modum og Hole, i øst til Bærum og Asker, i sør og vest til Drammen og Øvre Eiker.\n\nNoen kjenner Lier som jordbærbygda, mens andre tenker på epler og grønnsaker. Videre gir landskapet gode turmuligheter både sommer og vinterstid. Lier har fått tilnavnet «Den grønne lungen mellom Oslo og Drammen».',
      'media': null
    },
    {
      'title': 'Lierbyen',
      'description':
          'Lierbyen er administrasjonssenteret i Lier kommune i Viken, beliggende i Lierdalen. Lierbyen var inntil 2014 regnet som et eget tettsted, men ble «slukt» av tettstedet Drammen etter de nye definisjonene til SSB.\n\nLierdalen ligger 30 minutters kjøring sydvest for Oslo, og 8 minutters kjøring nord for Drammen. Lierbyen ligger om lag midt i dalen, hvor også rådhuset og kommuneadministrasjonen befinner seg. Lierbyen har til tross for sin begrensede størrelse et stort antall matbutikker av diverse varianter. Det bor ca. 4 662 personer i lierbyen,',
      'media': null
    },
    {
      'title': 'Flyktningtjenesten',
      'description':
          'Flyktningtjenesten har ansvar for å bosette og etablere flyktninger som har fått avtale om bosetting i Lier kommune, samt koordinere innsatsen rundt voksne flyktninger i introduksjonsprgrammet.\n\nAlle flyktningene som bosettes etter avtale med IMDi har allerede oppholdstillatelse i Norge. \n\nAntall flyktninger som hvert år tas imot, vedtas politisk.\n\nFlyktningtjenesten skal hjelpe flyktningene på vei mot målet om å bli selvforsørget og ha et godt og innholdsrikt liv for seg og sin familie i bygda vår.',
      'media': null
    }
  ],
  'title': 'Lier kommune',
  'description': 'Dette kurset skal forklare hva Lier Kommune er.',
  'language': {'language_full_name': 'Norsk', 'slug': 'NO'},
  'publisher': {
    'name': 'Lier Kommune',
    'avatar': {'url': url}
  },
  'category': {
    'cover_photo': {'url': url},
    'category_name': 'Helsetjenester'
  },
  'is_recommended': true,
  'course_group': {'name': 'Lier kommune', 'slug': 'lier-kommune-1'}
};

Course referenceCourse = Course.fromJson(mockCourse);
