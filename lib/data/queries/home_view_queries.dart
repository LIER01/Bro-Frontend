final String getHomeQuery = r'''
query{
  home {  
    introduction,
    header
    }
}
''';

final String getRecommendedCoursesQuery = r'''
query langCoursesQuery ($lang_slug: String!, $start: Int!, $limit: Int!){
    LangCourse: courses (start: $start, limit: $limit,where:{
      _where:[
        {language:{slug:$lang_slug}}
        {is_recommended:true}
        ]
    }){
    id
        questions{
          id
        }
        slides{
          id
        }
    title
    description
    publisher{
      name
      avatar{
        url
      }
    }
    category{
      cover_photo{
        url
      }
      category_name
    }
    is_recommended
    course_group{
      slug
    }
  }
  
  nonLangCourse: courses (start: $start, limit: $limit,where:{
      _where:[
        {language:{slug_ne:$lang_slug}}
        {is_recommended:true}
        ]
    }){
    id
        questions{
          id
        }
        slides{
          id
        }
    title
    description
    publisher{
      name
      avatar{
        url
      }
    }
    category{
      cover_photo{
        url
      }
      category_name
    }
    is_recommended
    course_group{
      slug
    }
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

final String getRecommendedLangResourcesQuery = r'''
query recommendedLangResourcesQuery ($start: Int!, $limit: Int!,$lang: String) {
  LangResource: resources(start: $start, limit: $limit,
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
