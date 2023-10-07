import 'package:flutter/material.dart';
import 'package:riverpod_project/product/constant/string_constant.dart';
import 'package:riverpod_project/product/models/category.dart';

class HomeCategoryDropDown extends StatelessWidget {
  const HomeCategoryDropDown({
    required this.categories,
    required this.onSelected,
    super.key,
  });
  final List<CategoryModel> categories;
  final ValueSetter<CategoryModel> onSelected;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryModel>(
      validator: (value) => value == null ? 'Not empty' : null,
      items: categories
          .map(
            (e) => DropdownMenuItem<CategoryModel>(
              value: e,
              child: Text(e.name ?? ''),
            ),
          )
          .toList(),
      hint: const Text(StringConstant.dropdownHint),
      //value: _selectedCategory,
      onChanged: (value) {
        if (value == null) return;
        onSelected.call(value);
      },
    );
  }
}
