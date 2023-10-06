// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../home_view.dart';

class _ActiveChip extends StatelessWidget {
  const _ActiveChip(
    this.tag,
  );
  final Tag tag;
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        tag.name ?? '',
        style: context.general.textTheme.bodySmall?.copyWith(
          color: ColorConstant.white,
        ),
      ),
      backgroundColor: ColorConstant.purplePrimary,
      padding: context.padding.low,
    );
  }
}

class _PassiveChip extends StatelessWidget {
  const _PassiveChip(
    this.tag,
  );
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        tag.name ?? '',
        style: context.general.textTheme.bodySmall?.copyWith(
          color: ColorConstant.grayPrimary,
        ),
      ),
      backgroundColor: ColorConstant.grayLighter,
      padding: context.padding.low,
    );
  }
}
