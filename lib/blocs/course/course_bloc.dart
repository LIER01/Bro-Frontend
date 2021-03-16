import 'package:bro/blocs/course/course_bucket.dart';
import 'package:bro/blocs/course/course_events.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:bro/data/GraphQLProvider.dart";

class CourseBloc extends Bloc<CourseEvents, CourseStates> {
  GraphQLProvider provider;

  // Won't compile without super(null), look into this.
  CourseBloc() : super(null) {
    provider = GraphQLProvider();
  }

  @override
  CourseStates get initialState => Loading();

  @override
  Stream<CourseStates> mapEventToState(CourseEvents event) async* {
    if (event is FetchCourseData) {
      yield* _mapFetchCourseDataToStates(event);
    }
  }

  Stream<CourseStates> _mapFetchCourseDataToStates(
      FetchCourseData event) async* {
    final query = event.query;
    final variables = event.variables ?? null;

    try {
      final result =
          await provider.performMutation(query, variables: variables);

      if (result.hasException) {
        print("graphQLErrors: ${result.exception.graphqlErrors.toString()}");

        yield Failed(result.exception.graphqlErrors[0]);
      } else {
        yield Success(result.data);
      }
    } catch (e) {
      print(e);
      yield Failed(e.toString());
    }
  }
}
