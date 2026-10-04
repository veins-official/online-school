// Аватар пользователя
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Аватар с фолбэком на инициалы.
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.imageUrl, required this.name, this.radius = 20});

  final String? imageUrl;
  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(imageUrl!),
      );
    }
    return CircleAvatar(
      radius: radius,
      child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?'),
    );
  }
}
