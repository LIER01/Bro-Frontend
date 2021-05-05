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
    category {category_name id}
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

final String getResourcesQuery = r'''
query($lang: String, $category: Int) {
  LangResource: resources(
    where: {
      _where: [
        { language: { slug: $lang } }
        { category: { id: $category } }
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
    category {category_name id}
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
}''';

final String getRecommendedResourcesQuery = r'''
query recommendedLangResourcesQuery ($lang: String) {
  LangResource: resources(
    where: {
      _where: [
        { language: { slug: $lang } }
        {is_recommended:true} 
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
    category {category_name id}
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
}''';
