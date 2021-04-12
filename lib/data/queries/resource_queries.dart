final String getResourceQuery = r'''
query($lang: String, $group: String) {
  resources(
    where: {
      _where: [
        { language: { slug: $lang } }
        { resource_group: { slug: $group } }
      ]
    }
  ) {
    title
    cover_photo {url}
    description
    language {slug}
    resource_group {slug}
    description
    publisher {name}
    category {category_name}
    is_recommended
    references {
      reference_title
      reference_description
      reference_url
      reference_button_text
    }
    documents {
      document_name 
      document_file {url}
    }
  }
}
''';
