import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:mockito/mockito.dart';
import 'package:bro/data/course_repository.dart';
import '../graphql_mutation_mocker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc_test/bloc_test.dart';

class MockCourseDetailBloc
    extends MockBloc<CourseDetailEvent, CourseDetailState>
    implements CourseDetailBloc {
  MockCourseDetailBloc({@required repository}) : assert(repository != null);
}

class MockCourseRepository extends Mock implements CourseRepository {
  MockCourseRepository({
    @required GraphQLMutationMocker client,
  }) : assert(client != null);
}
