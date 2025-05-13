import 'package:flutter/material.dart';

import '../themes/color.dart';
import '../themes/theme.dart';

class AvaGradeBar extends StatelessWidget {
  /// Value from 1 to 3 indicating the grade rank.
  final int gradeRank;

  /// Text to display over the grade bar.
  final String gradeText;

  /// Section grade belongs to between 0 and 4.
  final int section;

  /// List of sections to display, must be length 5.
  final List<String> sections;

  const AvaGradeBar({
    super.key,
    required this.gradeRank,
    required this.gradeText,
    required this.section,
    required this.sections,
  }) : assert(
         gradeRank >= 1 && gradeRank <= 3,
         'gradeRank must be between 1 and 3',
       ),
       assert(section >= 0 && section <= 4, 'section must be between 0 and 4'),
       assert(sections.length == 5, 'sections must be a list of length 5');

  static const _gradeColors = <int, Color>{
    1: AppColors.avaSecondary,
    2: AppColors.lightOrange,
    3: AppColors.lightRed,
  };

  static const _flexes = <int?>[2, 1, 1, 2, null];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Spacer(flex: gradeRank * 2 - 1),
            Text(
              gradeText,
              style: AppTheme.overlineEmphasis.copyWith(
                color: _gradeColors[gradeRank],
              ),
            ),
            Spacer(flex: 6 - (gradeRank * 2 - 1)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.avaSecondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 102,
                height: 24,
                decoration: const BoxDecoration(color: AppColors.lightOrange),
              ),
            ),
            Expanded(
              child: Container(
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.lightRed,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            ...Iterable<int>.generate(5)
                .map(
                  (i) => [
                    SectionDivider(
                      color: i == section ? _gradeColors[gradeRank] : null,
                    ),
                    if (_flexes[i] != null) Spacer(flex: _flexes[i]!),
                  ],
                )
                .expand((e) => e),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            ...Iterable<int>.generate(5)
                .map(
                  (i) => [
                    SectionText(
                      text: sections[i],
                      color: i == section ? _gradeColors[gradeRank] : null,
                    ),
                    if (_flexes[i] != null) Spacer(flex: _flexes[i]!),
                  ],
                )
                .expand((e) => e),
          ],
        ),
      ],
    );
  }
}

class SectionDivider extends StatelessWidget {
  final Color? color;

  const SectionDivider({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(height: 8, width: 1, color: color ?? AppColors.disabled);
  }
}

class SectionText extends StatelessWidget {
  final String text;
  final Color? color;

  const SectionText({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTheme.overlineRegular.copyWith(
        color: color ?? AppColors.textLight,
      ),
    );
  }
}
