import 'package:fightclub/src/widgets/colors.dart';
import 'package:fightclub/src/widgets/images.dart';
import 'package:material_ui/material_ui.dart';

class const FightersInfo({
  required final int maxLivesCount,
  required final int playerLivesCount,
  required final int enemyLivesCount,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 160,
    child: Stack(
      children: [
        const Row(
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _Lives(overall: maxLivesCount, current: playerLivesCount),
            const _Fighter(label: 'You', image: AppImages.youAvatar),
            const SizedBox(
              height: 44,
              width: 44,
              child: DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blueButton),
                child: Center(
                  child: Text('vs', style: TextStyle(color: AppColors.whiteText, fontSize: 16)),
                ),
              ),
            ),
            const _Fighter(label: 'Enemy', image: AppImages.enemyAvatar),
            _Lives(overall: maxLivesCount, current: enemyLivesCount),
          ],
        ),
      ],
    ),
  );
}

class const _Fighter({required final String label, required final String image}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SizedBox(height: 16),
      Text(label, style: const TextStyle(color: AppColors.darkGreyText)),
      const SizedBox(height: 12),
      Image.asset(image, width: 90, height: 90),
    ],
  );
}

class const _Lives({required final int overall, required final int current}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (int index = 0; index < overall; index++) ...[
        Image.asset(index < current ? AppImages.heartFull : AppImages.heartEmpty, width: 18, height: 18),
        if (index < overall - 1) const SizedBox(height: 4),
      ],
    ],
  );
}
