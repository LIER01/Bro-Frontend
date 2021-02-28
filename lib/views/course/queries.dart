final String getCourseQuery = '''
    query {
      course (id:1){
          title
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
