import 'package:fightclub/src/widgets/colors.dart';
import 'package:material_ui/material_ui.dart';

class const ActionButton({
  required final VoidCallback onTap,
  required final Color color,
  required final String text,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      color: color,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.whiteText),
      ),
    ),
  );
}
