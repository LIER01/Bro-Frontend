final String getArticlesQuery = r'''
query {
  articles {
    id,
    title,
    body
  }
}
''';

final String getCoursesQuery = r''' 
query {
  courses {
    id,
    title,
    description,
    questions {id},
    slides {id},
  }
''';

final String getHomeViewQuery = r'''
query{
  home {  
    introduction,
    header
    }
}
''';
