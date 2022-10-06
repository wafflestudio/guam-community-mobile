import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/project.dart';
import 'package:guam_community_client/screens/recruit/detail/project_detail_apply_button.dart';
import 'package:guam_community_client/styles/colors.dart';

import '../../../commons/button_size_circular_progress_indicator.dart';

class ProjectDetailApply extends StatefulWidget {
  final Project project;

  const ProjectDetailApply(this.project);

  @override
  State<ProjectDetailApply> createState() => _ProjectDetailApplyState();
}

class _ProjectDetailApplyState extends State<ProjectDetailApply> {
  final TextEditingController introController = TextEditingController();
  String? myPosition;
  bool? fieldsFulfilled;
  bool applying = false; // toggled true while requesting apply
  bool myPositionFilled() => myPosition != null && myPosition != "";
  bool introFilled() => introController.text != "";

  @override
  void initState() {
    super.initState();
    fieldsFulfilled = false;
  }

  @override
  void dispose() {
    introController.dispose();
    super.dispose();
  }

  void setMyPosition(String position) {
    setState(() => myPosition = position);
    checkFieldsFulfilled();
  }

  void checkFieldsFulfilled() {
    setState(() {
      fieldsFulfilled = myPositionFilled() && introFilled();
    });
  }

  void toggleApplying() {
    setState(() => applying = !applying);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> applyProject({dynamic params}) async {
      toggleApplying();

      // try {
      //   await context.read<Recruit>().applyProject(
      //       projectId: widget.project.id,
      //       queryParams: {
      //         "introduction": introController.text,
      //         "position": myPosition,
      //       }
      //   ).then((successful) {
      //     if (successful) {
      //       introController.clear();
      //       setMyPosition(null);
      //       checkFieldsFulfilled();
      //       FocusScope.of(context).unfocus();
      //     }
      //   });
      // } catch (e) {
      //   print(e);
      // } finally {
      //   toggleApplying();
      // }
    }

    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        children: [
          ProjectDetailApplyButton(myPosition: myPosition, setMyPosition: setMyPosition),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Container(
              decoration: BoxDecoration(color: GuamColorFamily.grayscaleWhite),
              child: Theme(
                data: ThemeData(
                  primaryColor: GuamColorFamily.grayscaleGray4,
                  inputDecorationTheme: InputDecorationTheme(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: GuamColorFamily.purpleLight1),
                    ),
                  ),
                ),
                child: TextField(
                  minLines: 3,
                  maxLines: 10,
                  controller: introController,
                  style: TextStyle(fontSize: 13),
                  keyboardType: TextInputType.multiline,
                  onChanged: (String _) => checkFieldsFulfilled(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                    "간단히 자기소개를 해주세요. 기술 스택, 개발 경험 등 자세하게 적어주시면 팀 구성에 도움이 됩니다.🚀",
                    hintStyle: TextStyle(fontSize: 13, color: GuamColorFamily.grayscaleGray3),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.85,
            child: ElevatedButton(
              onPressed: fieldsFulfilled! && !applying ? () => applyProject() : null,
              child: !applying
                  ? Text(
                      '참여하기',
                      style: TextStyle(
                        fontSize: 14,
                        color: GuamColorFamily.grayscaleWhite,
                      ))
                  : ButtonSizeCircularProgressIndicator(),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled))
                    return GuamColorFamily.grayscaleGray4;
                  else
                    return GuamColorFamily.purpleCore;
                  }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
