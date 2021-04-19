final String getCategoryQuery = r'''
query {
  categories {
    category_name,
    id,
    cover_photo {url},
    description
  }
}
''';
