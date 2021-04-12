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
query getRecommendedCoursesQuery($start: Int!,$limit: Int!){
  courses(where:{is_recommended:true},start:$start,limit: $limit) {
    id,
    title,
    description,
    questions {id},
    slides {id},
  }
  home{
    introduction,
    header
    }
}
''';

final String getCourseQuery = r'''
    query getCourseQuery ($course_id: ID!){
    course (id:$course_id){
        title
        description
        questions{
            question
            alternatives{
                name
                image{
                    url
                }
                correct
            }
            clarification
        }
        slides{
            title
            description
            image{
                url
            }
        }
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
      _where:[{language:{slug_ne:$lang_slug}}
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

final String getHomeQuery = r'''
query{
  home {  
    introduction,
    header
    }
}
''';

final String langCoursesQuery = r'''
query langCoursesQuery ($lang_slug: String!, $start: Int!, $limit: Int!){
    LangCourse: courses (start: $start, limit: $limit,where:{
      _where:[{language:{slug:$lang_slug}}
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
      _where:[{language:{slug_ne:$lang_slug}}
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

final String nonLangCoursesQuery = r'''
query nonLangCoursesQuery ($start: Int!, $limit: Int!){
    LangCourse: courses (start: $start, limit: $limit,where:{
      _where:[{language:{slug:"NO"}}
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

final String getNewCourse = r'''
query getNewCourseQuery ($group_slug: String!, $lang_slug: String!){
    courses (where:{
      _where:[{
        language:{slug:$lang_slug}
      }
        {
          course_group:{slug:$group_slug}
        }]
    }){
        questions{
            question
            alternatives{
                alternative_text
                image{
                    url
                }
                is_correct
            }
            clarification
        }
        slides{
            title
            description
            media{
                url
            }
        }
    title
    description
    language{
      language_full_name
      slug
    }
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
      name
      slug
    }
    }
}
''';
