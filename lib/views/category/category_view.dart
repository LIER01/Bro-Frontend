import 'dart:developer';

import 'package:bro/blocs/category/category_bucket.dart';
import 'package:bro/models/category.dart';
import 'package:bro/utils/navigator_arguments.dart';
import 'package:bro/views/widgets/extract_route_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late CategoryBloc _categoryBloc;
  List<Category> categories = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryBloc.add(CategoriesRequested());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _next() {
    setState(() {
      if (currentIndex < categories.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
    });
  }

  void _prev() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = categories.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is Loading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is Failed) {
          return Scaffold(
            body: Center(
              child: Text('ERROR'),
            ),
          );
        }

        if (state is Success) {
          categories = state.categories;

          if (categories.isEmpty) {
            return Scaffold(
              body: Center(
                child: Text('Ingen tilgjengelige kategorier'),
              ),
            );
          }

          return Scaffold(
            body: Container(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.velocity.pixelsPerSecond.dx > 0) {
                        _prev();
                      } else if (details.velocity.pixelsPerSecond.dx < 0) {
                        _next();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              categories[currentIndex].cover_photo.url),
                          onError: (exception, stackTrace) {
                            log(exception.toString());
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(1),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 90,
                              margin: EdgeInsets.only(bottom: 50),
                              child: Row(
                                children: _buildIndicator(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(32),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _prev();
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Theme.of(context).primaryColor,
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    categories[currentIndex].category_name,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _next();
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.chevronRight,
                                  color: Theme.of(context).primaryColor,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              child: Text(
                                categories[currentIndex].description,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    ExtractResourceDetailScreen.routeName,
                                    arguments: ResourceDetailArguments(
                                        lang: 'NO', group: 'resepter'),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'SE OVERSIKT',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 4,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isActive
                ? Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    var indicators = <Widget>[];
    for (var i = 0; i < categories.length; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
