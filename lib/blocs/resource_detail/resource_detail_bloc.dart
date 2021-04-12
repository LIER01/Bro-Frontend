import 'dart:developer';

import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ResourceDetailBloc
    extends Bloc<ResourceDetailEvent, ResourceDetailState> {
  ResourceRepository repository;

  ResourceDetailBloc({@required this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<ResourceDetailState> mapEventToState(
      ResourceDetailEvent event) async* {
    if (event is ResourceDetailRequested) {
      try {
        final queryResult =
            await repository.getResource(event.lang, event.group);
        final queryData = queryResult.data['resources'][0] as dynamic;

        log(queryData.toString());
        log("funker dette?");
        log(queryData['references'].toString());

        final references = queryData['references']
            .map((dynamic e) => Reference(
                  title: e['reference_title'],
                  description: e['reference_description'],
                  url: e['reference_url'],
                  buttonText: e['reference_button_text'],
                ))
            .toList();

        final resource = Resource(
          title: queryData['title'],
          lang: queryData['language']['slug'],
          group: queryData['resource_group']['slug'],
          description: queryData['description'],
          publisher: queryData['publisher']['name'],
          category: queryData['category']['category_name'],
          isRecommended: queryData['is_recommended'],
          references: references,
        );

        log(resource.toString());

        yield Success(resource: resource);
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    }
  }
}
