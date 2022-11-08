import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/guam_progress_indicator.dart';
import 'package:guam_community_client/providers/recruit/recruit.dart';
import 'package:guam_community_client/screens/recruit/search/filter_button.dart';
import 'package:guam_community_client/screens/recruit/search/filter_status.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_auth/authenticate.dart';
import '../../../styles/colors.dart';
import '../../search/search_app_bar.dart';
import 'project_search_body.dart';
import 'project_search_text_field.dart';



class ProjectSearch extends StatefulWidget {
  @override
  State<ProjectSearch> createState() => _ProjectSearchState();
}

class _ProjectSearchState extends State<ProjectSearch> {
  final Map filter = new Map();
  late FocusNode myFocusNode;
  bool cancel = true;

  void cancelSearch(bool) {
    setState(() => cancel = bool);
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final recruitProvider = context.watch<Recruit>();

    return Scaffold(
      backgroundColor: GuamColorFamily.purpleLight3,
      appBar: SearchAppBar(
        title: ProjectSearchTextField(filter: filter, focusNode: myFocusNode, cancelSearch: cancelSearch),
        trailing: FilterButton(filter: filter, setSkill: (skill){
          setState(() {
            if(skill == null){
              filter.remove('skill');
            }else{
              filter['skill'] = skill;
            }
          });
        }, setPosition: (position){
          setState(() {
            if(position == null){
              filter.remove('position');
            }else{
              filter['position'] = position;
            }
          });
        }, setDue: (due){
          setState(() {
            if(due == null){
              filter.remove('due');
            }else{
              filter['due'] = due;
            }
          });
        },
        clearFilter: (){
          setState(() {
            filter.clear();
          });
        },
          requestFocus: ()=> myFocusNode.requestFocus(),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if(filter.isNotEmpty) SizedBox(
            height: 46,
            child: FilterStatus(
            filter: filter,
            removeSkill: ()=>setState((){filter.remove('skill');}),
            removePosition: ()=>setState((){filter.remove('position');}),
            removeDue: ()=>setState((){filter.remove('due');}),
          ),
          ),
          cancel
          ? Container()
          : recruitProvider.loading
              ? Flexible(child: Center(child: guamProgressIndicator()))
              : recruitProvider.searchedProjects.isEmpty
                ? Flexible(child: Center(child: Text('검색 결과가 없습니다.', style: TextStyle(fontSize: 16))))
                : Flexible(
              child: ProjectSearchBody(filter: filter)),
        ],
      ),
    );
  }
}