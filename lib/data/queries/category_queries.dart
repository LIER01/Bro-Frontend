final String getCategoryQuery = r'''
query {
  categories {
    category_name,
    cover_photo {url},
    description
  }
}
''';
