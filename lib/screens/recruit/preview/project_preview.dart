import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/projects/project.dart';
import 'package:guam_community_client/providers/recruit/recruit.dart';
import 'package:guam_community_client/screens/recruit/preview/project_preview_image.dart';
import 'package:guam_community_client/screens/recruit/preview/project_preview_info.dart';
import 'package:provider/provider.dart';

import '../../../commons/guam_progress_indicator.dart';
import '../../../providers/user_auth/authenticate.dart';
import '../../../styles/colors.dart';
import '../../boards/posts/preview/post_preview_relative_time.dart';
import '../../boards/posts/preview/post_preview_title.dart';
import '../detail/project_detail.dart';

class ProjectPreview extends StatelessWidget with Toast {
  final int idx;
  final Project project;
  final Function refreshProject;

  ProjectPreview({required this.idx, required this.project, required this.refreshProject});

  @override
  Widget build(BuildContext context) {
    Recruit recruitProvider = context.read<Recruit>();
    Authenticate authProvider = context.read<Authenticate>();

    Future<Project?> _getProject(int? id) {
      return Future.delayed(Duration(seconds: 0), () async {
        Project? _post = await recruitProvider.getProject(id);
        return _post;
      });
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 12),
        decoration: BoxDecoration(
          color: GuamColorFamily.grayscaleWhite,
          borderRadius: BorderRadius.circular(24),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => Recruit(authProvider)),
                  ],
                  child: FutureBuilder(
                    future: _getProject(project.id),
                    builder: (_, AsyncSnapshot<Project?> snapshot) {
                      if (snapshot.hasData) {
                        return ProjectDetail(snapshot.data);
                      } else if (snapshot.hasError) {
                        // postProvider.fetchPosts(0);
                        showToast(success: false, msg: '해당 프로젝트를 찾을 수 없습니다.');
                        Navigator.pop(context);
                        return Container();
                      } else {
                        return Center(child: guamProgressIndicator());
                      }
                    }
                  ),
                ),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    ...project.techStacks!.mapIndexed((idx, techStack) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image(image: NetworkImage(techStack.icon!), fit: BoxFit.contain, height: 20, width: 20,),
                    )),
                    Spacer(),
                    PostPreviewRelativeTime(DateTime.parse(this.project.createdAt!)),
                  ],
                ),
              ),
              // #2
              PostPreviewTitle(this.project.title),
              ProjectPreviewImage(
                thumbnail: project.thumbnail!,
              ),
              ProjectPreviewInfo(
                index: idx,
                project: project,
                refreshProject: refreshProject,
                iconColor: GuamColorFamily.grayscaleGray5,
                profileClickable: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}