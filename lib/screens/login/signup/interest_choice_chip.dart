import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class InterestChoiceChip extends StatefulWidget {
  final List<String>? interestOptions;
  final List<String>? interestList;
  final Function(List<String>?)? onSelectionChanged;

  InterestChoiceChip({this.interestOptions, this.interestList, this.onSelectionChanged});

  @override
  _InterestChoiceChipState createState() => _InterestChoiceChipState();
}

class _InterestChoiceChipState extends State<InterestChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    List<String>? selectedInterests = widget.interestList;

    widget.interestOptions!.forEach((interest) {
      choices.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: ChoiceChip(
            label: Container(
              width: double.infinity,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              constraints: BoxConstraints(maxHeight: 40),
              child: Text(
                interest,
                style: TextStyle(
                  fontSize: 16,
                  color: selectedInterests!.contains(interest)
                      ? GuamColorFamily.purpleCore
                      : GuamColorFamily.grayscaleGray2,
                ),
              ),
            ),
            selected: selectedInterests.contains(interest),
            selectedColor: GuamColorFamily.purpleLight2,
            backgroundColor: GuamColorFamily.grayscaleWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: selectedInterests.contains(interest)
                    ? GuamColorFamily.purpleCore
                    : GuamColorFamily.grayscaleGray6
              ),
            ),
            onSelected: (selected) {
              setState(() {
                selectedInterests.contains(interest)
                    ? selectedInterests.remove(interest)
                    : selectedInterests.add(interest);
                widget.onSelectionChanged!(selectedInterests);
              });
            },
          ),
        )
      );
    });
    return choices;
  }
}
