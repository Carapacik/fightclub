import 'dart:async';

import 'package:fightclub/src/data/fight_history_storage.dart';
import 'package:fightclub/src/data/review_service.dart';
import 'package:fightclub/src/models/fight_history.dart';
import 'package:fightclub/src/widgets/colors.dart';
import 'package:fightclub/src/widgets/secondary_action_button.dart';
import 'package:material_ui/material_ui.dart';

class const StatisticsScreen({required final FightHistoryStorage storage, super.key}) extends StatefulWidget {
  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState() extends State<StatisticsScreen> {
  late final Future<FightHistory> _history = widget.storage.load();

  @override
  void initState() {
    super.initState();
    unawaited(ReviewService.requestIfAvailable());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  'Statistics',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: AppColors.darkGreyText),
                ),
              ),
              const Spacer(),
              FutureBuilder<FightHistory>(
                future: _history,
                builder: (context, snapshot) {
                  final FightHistory? history = snapshot.data;
                  if (history == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Won: ${history.won}', style: const TextStyle(fontSize: 16, color: AppColors.darkGreyText)),
                      const SizedBox(height: 6),
                      Text(
                        'Lost: ${history.lost}',
                        style: const TextStyle(fontSize: 16, color: AppColors.darkGreyText),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Draw: ${history.draw}',
                        style: const TextStyle(fontSize: 16, color: AppColors.darkGreyText),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SecondaryActionButton(onTap: () => Navigator.of(context).pop(), text: 'Back'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
