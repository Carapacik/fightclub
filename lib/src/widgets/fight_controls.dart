import 'package:fightclub/src/models/body_part.dart';
import 'package:fightclub/src/widgets/colors.dart';
import 'package:material_ui/material_ui.dart';

class const FightControls({
  required final BodyPart? defendingBodyPart,
  required final ValueSetter<BodyPart> selectDefendingBodyPart,
  required final BodyPart? attackingBodyPart,
  required final ValueSetter<BodyPart> selectAttackingBodyPart,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(width: 16),
      Expanded(
        child: _BodyPartColumn(
          label: 'Defend',
          selectedBodyPart: defendingBodyPart,
          onSelected: selectDefendingBodyPart,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: _BodyPartColumn(
          label: 'Attack',
          selectedBodyPart: attackingBodyPart,
          onSelected: selectAttackingBodyPart,
        ),
      ),
      const SizedBox(width: 16),
    ],
  );
}

class const _BodyPartColumn({
  required final String label,
  required final BodyPart? selectedBodyPart,
  required final ValueSetter<BodyPart> onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(label.toUpperCase(), style: const TextStyle(color: AppColors.darkGreyText)),
      const SizedBox(height: 13),
      for (final BodyPart bodyPart in BodyPart.values) ...[
        _BodyPartButton(bodyPart: bodyPart, selected: selectedBodyPart == bodyPart, onSelected: onSelected),
        if (bodyPart != BodyPart.values.last) const SizedBox(height: 14),
      ],
    ],
  );
}

class const _BodyPartButton({
  required final BodyPart bodyPart,
  required final bool selected,
  required final ValueSetter<BodyPart> onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => onSelected(bodyPart),
    child: SizedBox(
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: selected ? AppColors.blueButton : Colors.transparent,
          border: selected ? null : Border.all(color: AppColors.darkGreyText, width: 2),
        ),
        child: Center(
          child: Text(
            bodyPart.label.toUpperCase(),
            style: TextStyle(fontSize: 13, color: selected ? AppColors.whiteText : AppColors.darkGreyText),
          ),
        ),
      ),
    ),
  );
}
