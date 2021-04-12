import 'package:bro/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResourceDetailReference extends StatelessWidget {
  ResourceDetailReference({Key? key, required this.reference})
      : super(key: key);

  final References reference;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(reference.referenceTitle),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(reference.referenceDescription),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: GestureDetector(
              onTap: () {
                debugPrint('Heisann');
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  reference.referenceButtonText,
                  style: Theme.of(context).textTheme.button!.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
