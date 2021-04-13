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
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
                reference.referenceTitle == null
                    ? ''
                    : reference.referenceTitle!,
                style: Theme.of(context).textTheme.headline6),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(reference.referenceDescription == null
                ? ''
                : reference.referenceDescription!),
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
                  reference.referenceButtonText == null
                      ? ''
                      : reference.referenceButtonText!,
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
