final String getArticlesQuery = '''
query {
  articles {
    id,
    title,
    body.dart
  }
}
''';

final String getHomeViewQuery = '''
query{
  home {  
    introduction,
    header
    }
}
''';
