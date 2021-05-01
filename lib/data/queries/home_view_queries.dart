final String getHomeQuery = r'''
query{
  home {  
    introduction,
    header
    }
}
''';

final String getRecommendedNonLangResourcesQuery = r'''
query nonLangResourcesQuery ($start: Int!, $limit: Int!){
    LangResource: resources (start: $start, limit: $limit,where:{
      _where:[
      {language:{slug:"NO"}}
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
}
''';
