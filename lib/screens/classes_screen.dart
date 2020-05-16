import 'package:flutter/material.dart';
import 'package:nofapcamp/models/classes.dart';

import '../widgets/custom_app_bar.dart';

class ClassesScreen extends StatelessWidget {
  final List<Classes> _classesList = getClassesList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '계급',
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: _classesList
            .map(
              (Classes classes) => Card(
                child: ListTile(
                  title: Text(
                    '${classes.name} (${classes.srcDay}~${classes.dstDay == -1 ? '' : classes.dstDay})',
                  ),
                  subtitle: Text(
                    classes.description,
                  ),
                  trailing: Image(
                    width: 40.0,
                    image: classes.image,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
