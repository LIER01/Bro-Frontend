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
query{
  home {  
    introduction,
    header
    }
}
''';

final String getCourseQuery = r'''
    query getCourseQuery ($course_id: ID!){
    course (id:$course_id){
        title
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
query getRecommendedCoursesQuery($start: Int!,$limit: Int!){
  courses(where:{is_recommended:true},start:$start,limit: $limit) {
    id,
    title,
    description,
    questions {id},
    slides {id},
  }
}
''';
