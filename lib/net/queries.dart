final String getArticlesQuery = '''
query {
  articles {
    id,
    title,
    body
  }
}
''';

final String getCoursesQuery = ''' 
query {
  courses {
    id,
    title,
    description,
    questions {id},
    slides {id},
  }
}
''';
