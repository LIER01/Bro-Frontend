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
      child: Column(
        children: [
          Container(
            child: Text(reference.referenceTitle),
          ),
          Container(
            child: Text(reference.referenceDescription),
          ),
          Expanded(
            child: Align(
              child: GestureDetector(
                onTap: () {
                  debugPrint('Heisann');
                },
                child: Container(
                  height: 50,
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
          ),
        ],
      ),
    );
  }
}
