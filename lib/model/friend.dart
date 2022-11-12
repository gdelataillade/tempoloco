import 'package:flutter_svg/flutter_svg.dart';

class Friend {
  final String id;
  final String username;
  final DrawableRoot svgRoot;

  const Friend({
    required this.id,
    required this.username,
    required this.svgRoot,
  });
}
