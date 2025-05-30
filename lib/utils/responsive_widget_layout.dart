import 'package:flutter/material.dart';

import '../utils/utils.dart';


class ResponsiveWidgetFormLayout extends StatelessWidget {
  final Widget Function(BuildContext, Color?) buildPageContent;

  const ResponsiveWidgetFormLayout({super.key, required this.buildPageContent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screensize = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        Color? color;
        color = theme.colorScheme.onPrimary;
        // if (constraints.maxWidth > Constants.mediumScreenWidth) {
        //   color = theme.colorScheme.onPrimary;
        // }
        //Large Screen
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Constants.mediumScreenWidth,
              maxHeight: screensize.height,
            ),
            child: SingleChildScrollView(
              child: buildPageContent(context, color),
            ),
          ),
        );
      },
    );
  }
}
