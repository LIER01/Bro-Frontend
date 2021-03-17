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
query getCourseQuery($start: Int!, $limit: Int!) {
  courses(start: $start, limit: $limit) {
    id,
    title,
    description,
    questions {id},
    slides {id},
  }
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
