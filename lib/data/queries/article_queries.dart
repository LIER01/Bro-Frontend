final String getArticlesQuery = r''' 
query getArticlesQuery($start: Int!, $limit: Int!) {
  articles(start: $start, limit: $limit) {
    id,
    localized_articles{
      id,
      title,
      language{
        name,
        Slug
      }
    },
    publisher{
      name,
      avatar{
        url
      }
    },
    category{
      name,
    }
    is_recommended
  }
}
''';

final String getArticleQuery = r''' 
query getArticleQuery ($article_id: ID!){
  article (id:$article_id){
    localized_articles{
      id,
      title,
      description,
      resources{
        title,
        url,
        description
        source_name
      },
      documents{
        name,
        document{
          url
        }
        
      },
      language{
        name,
        Slug
      }
    },
    publisher{
      name,
      avatar{
        url
      }
    },
    category{
      name,
    }
    is_recommended
  }
}
''';


// final String getArticlesQuery = r''' 
// query getArticlesQuery($start: Int!, $limit: Int!) {
//   articles(start: $start, limit: $limit) {
//     id,
//     localized_articles{
//       id,
//       title,
//       description,
//       resources{
//         title,
//         url,
//         description
//         source_name
//       },
//       documents{
//         name,
//         document{
//           url
//         }
        
//       },
//       language{
//         name,
//         Slug
//       }
//     },
//     publisher{
//       name,
//       avatar{
//         url
//       }
//     },
//     category{
//       name,
//     }
//     is_recommended
//   }
// }
// ''';