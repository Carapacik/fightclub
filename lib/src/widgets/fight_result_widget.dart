import 'package:fightclub/src/models/fight_result.dart';
import 'package:fightclub/src/widgets/colors.dart';
import 'package:fightclub/src/widgets/images.dart';
import 'package:material_ui/material_ui.dart';

class const FightResultWidget({required final FightResult fightResult, super.key}) extends StatelessWidget {
  Color get _color => switch (fightResult) {
    FightResult.won => AppColors.green,
    FightResult.lost => AppColors.red,
    FightResult.draw => AppColors.blueButton,
  };

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 140,
    child: Stack(
      children: [
        const _FighterBackground(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 8),
            const _FighterAvatar(label: 'You', image: AppImages.youAvatar),
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: _color, borderRadius: BorderRadius.circular(22)),
              alignment: Alignment.center,
              child: Text(
                fightResult.label.toLowerCase(),
                style: const TextStyle(color: AppColors.white, fontSize: 16),
              ),
            ),
            const _FighterAvatar(label: 'Enemy', image: AppImages.enemyAvatar),
            const SizedBox(width: 8),
          ],
        ),
      ],
    ),
  );
}

class const _FighterBackground() extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(child: ColoredBox(color: AppColors.white)),
      Expanded(
        child: DecoratedBox(
          decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.white, AppColors.darkPurple])),
        ),
      ),
      Expanded(child: ColoredBox(color: AppColors.darkPurple)),
    ],
  );
}

class const _FighterAvatar({required final String label, required final String image}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(label, style: const TextStyle(color: AppColors.darkGreyText, fontSize: 14)),
      const SizedBox(height: 10),
      Image.asset(image, width: 90, height: 90),
    ],
  );
}
