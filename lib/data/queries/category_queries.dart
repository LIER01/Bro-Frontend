final String getCategoryQuery = r'''
query {
  categories {
    name,
    cover_photo {url}
  }
}
''';
