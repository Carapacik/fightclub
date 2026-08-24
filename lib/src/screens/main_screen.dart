import 'dart:async';

import 'package:fightclub/src/data/fight_history_storage.dart';
import 'package:fightclub/src/models/fight_history.dart';
import 'package:fightclub/src/screens/fight_screen.dart';
import 'package:fightclub/src/screens/statistics_screen.dart';
import 'package:fightclub/src/widgets/action_button.dart';
import 'package:fightclub/src/widgets/colors.dart';
import 'package:fightclub/src/widgets/fight_result_widget.dart';
import 'package:fightclub/src/widgets/secondary_action_button.dart';
import 'package:material_ui/material_ui.dart';

class const MainScreen({required final FightHistoryStorage storage, super.key}) extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState() extends State<MainScreen> {
  late Future<FightHistory> _history = widget.storage.load();

  void _openStatistics() {
    Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => StatisticsScreen(storage: widget.storage)));
  }

  void _openFight() {
    unawaited(_openFightAndRefresh());
  }

  Future<void> _openFightAndRefresh() async {
    await Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => FightScreen(storage: widget.storage)));
    if (mounted) {
      setState(() {
        _history = widget.storage.load();
      });
    }
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
              const SizedBox(height: 24),
              const Text(
                'THE\nFIGHT\nCLUB',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: AppColors.darkGreyText),
              ),
              const Spacer(),
              FutureBuilder<FightHistory>(
                future: _history,
                builder: (context, snapshot) {
                  final FightHistory? history = snapshot.data;
                  if (history?.lastResult == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Last fight result',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.darkGreyText, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      FightResultWidget(fightResult: history!.lastResult!),
                    ],
                  );
                },
              ),
              const Spacer(),
              SecondaryActionButton(text: 'Statistics', onTap: _openStatistics),
              const SizedBox(height: 16),
              ActionButton(text: 'Start', onTap: _openFight, color: AppColors.blackButton),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}
