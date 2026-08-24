import 'dart:async';

import 'package:fightclub/src/controllers/fight_controller.dart';
import 'package:fightclub/src/data/fight_history_storage.dart';
import 'package:fightclub/src/widgets/action_button.dart';
import 'package:fightclub/src/widgets/colors.dart';
import 'package:fightclub/src/widgets/fight_controls.dart';
import 'package:fightclub/src/widgets/fighters_info.dart';
import 'package:material_ui/material_ui.dart';

class const FightScreen({required final FightHistoryStorage storage, super.key}) extends StatefulWidget {
  @override
  State<FightScreen> createState() => _FightScreenState();
}

class _FightScreenState() extends State<FightScreen> {
  late final FightController _controller = FightController(widget.storage);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onAction() {
    if (_controller.isFinished) {
      Navigator.of(context).pop();
    } else {
      unawaited(_controller.playRound());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => Column(
              children: [
                FightersInfo(
                  maxLivesCount: FightController.maxLives,
                  playerLivesCount: _controller.playerLives,
                  enemyLivesCount: _controller.enemyLives,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                    child: ColoredBox(
                      color: AppColors.darkPurple,
                      child: SizedBox.expand(
                        child: Center(
                          child: Text(
                            _controller.roundSummary,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 10, color: AppColors.darkGreyText),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FightControls(
                  defendingBodyPart: _controller.defendingBodyPart,
                  selectDefendingBodyPart: _controller.selectDefendingBodyPart,
                  attackingBodyPart: _controller.attackingBodyPart,
                  selectAttackingBodyPart: _controller.selectAttackingBodyPart,
                ),
                const SizedBox(height: 14),
                ActionButton(
                  text: _controller.isFinished ? 'Back' : 'Go',
                  onTap: _onAction,
                  color: _controller.isFinished || _controller.canPlay ? AppColors.blackButton : AppColors.greyButton,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
