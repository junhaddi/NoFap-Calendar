import 'package:flutter/material.dart';
import 'package:nofapcamp/models/classes.dart';

import '../widgets/custom_app_bar.dart';

class ClassesScreen extends StatelessWidget {
  List<Classes> classesList = getClassesList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '계급',
      ),
      body: ListView(
        children: classesList
            .map(
              (Classes _classes) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: ListTile(
                  title: Text(
                    '${_classes.name} (${_classes.srcDay}~${_classes.dstDay == -1 ? 'inf' : _classes.dstDay})',
                  ),
                  subtitle: Text(
                    _classes.description,
                  ),
                  trailing: Container(
                    width: 40.0,
                    alignment: Alignment.center,
                    child: Image(
                      image: _classes.image,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
