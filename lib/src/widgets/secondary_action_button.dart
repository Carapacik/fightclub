import 'package:fightclub/src/widgets/colors.dart';
import 'package:material_ui/material_ui.dart';

class const SecondaryActionButton({required final VoidCallback onTap, required final String text, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: AppColors.darkGreyText, width: 2)),
      child: Text(text.toUpperCase(), style: const TextStyle(fontSize: 13, color: AppColors.darkGreyText)),
    ),
  );
}
