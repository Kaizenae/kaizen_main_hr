// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../../../../core/widgets/error_widget.dart';

class RefusedWidget extends StatelessWidget {
  RefusedWidget({
    super.key,
  });

  var state;
  @override
  Widget build(BuildContext context) {
    return const ErrorsWidget();
  }
}
