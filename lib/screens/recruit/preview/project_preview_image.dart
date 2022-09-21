import 'package:flutter/cupertino.dart';

import '../../../models/projects/project.dart';

class ProjectPreviewImage extends StatelessWidget {
  final String thumbnail;
  ProjectPreviewImage({required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image(
          image: NetworkImage(thumbnail),
          fit: BoxFit.cover,
          height: 64,
          width: double.infinity,
        ),
      ),
    );
  }
  
}