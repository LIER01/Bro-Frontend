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

final String getResourcesQuery = r'''
query($lang: String, $group: String) {
  resources(
    where: {
      _where: [
        { language: { slug: $lang } }
      ]
    }
  ) {
    title
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

final String getNonLangResourcesQuery = r'''
query nonLangResourcesQuery ($start: Int!, $limit: Int!){
    LangResource: resources (start: $start, limit: $limit,where:{
      _where:[{language:{slug:"NO"}}
        ]
    }
  ) {
    title
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

final String getLangResourcesQuery = r'''
query($lang: String, $category: Int) {
  resources(
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
}''';
