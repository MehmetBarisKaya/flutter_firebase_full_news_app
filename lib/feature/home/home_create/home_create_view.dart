// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:riverpod_project/feature/home/home_create/home_logic.dart';

import 'package:riverpod_project/product/constant/color_constant.dart';
import 'package:riverpod_project/product/constant/string_constant.dart';
import 'package:riverpod_project/product/enums/widget_size.dart';
import 'package:riverpod_project/product/mixin/loading_mixin.dart';
import 'package:riverpod_project/product/widget/dropdown/home_category_dropdown.dart';

class HomeCreateView extends StatefulWidget {
  const HomeCreateView({super.key});
  @override
  State<HomeCreateView> createState() => _HomeCreateViewState();
}

class _HomeCreateViewState extends State<HomeCreateView> with LoadingMixin {
  //CategoryModel? _selectedCategory;
  late final HomeLogic _homeLogic;

  @override
  void initState() {
    super.initState();
    _homeLogic = HomeLogic();
    fetchCategoryList();
  }

  Future<void> fetchCategoryList() async {
    await _homeLogic.fetchAllCategory();
    setState(() {});
  }

  Future<void> validFormOnPressed() async {
    changeLoading();
    final response = await _homeLogic.save();
    changeLoading();
    if (!mounted) return;

    await context.route.pop<bool>(response);
  }

  @override
  void dispose() {
    super.dispose();
    _homeLogic.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: ColorConstant.white,
              ),
            )
          else
            const SizedBox.shrink(),
        ],
        title: const Text(StringConstant.addItemTitle),
        centerTitle: false,
      ),
      body: Form(
        key: _homeLogic.formKey,
        onChanged: () {
          _homeLogic.checkValidateAndSave(
            (value) {
              setState(() {});
            },
          );
        },
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: context.padding.low,
          child: ListView(
            children: [
              HomeCategoryDropDown(
                categories: _homeLogic.categories,
                onSelected: _homeLogic.updateCategory,
              ),
              context.sized.emptySizedHeightBoxLow,
              TextFormField(
                controller: _homeLogic.titleController,
                validator: (value) =>
                    value.ext.isNullOrEmpty ? 'Not Empty' : null,
                decoration: const InputDecoration(
                  hintText: StringConstant.addItemTitle,
                  border: OutlineInputBorder(),
                ),
              ),
              context.sized.emptySizedHeightBoxLow,
              InkWell(
                onTap: () async {
                  await _homeLogic.pickAndCheck(
                    (value) {
                      setState(() {});
                    },
                  );
                },
                child: SizedBox(
                  height: context.sized.dynamicHeight(0.2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorConstant.grayPrimary,
                      ),
                    ),
                    child: _homeLogic.selectedFileBytes != null
                        ? Image.memory(_homeLogic.selectedFileBytes!)
                        : const Icon(Icons.add_a_photo_outlined),
                  ),
                ),
              ),
              context.sized.emptySizedHeightBoxLow,
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize:
                      Size.fromHeight(WidgetSize.buttoNormal.value.toDouble()),
                ),
                onPressed: !_homeLogic.isValidForm ? null : validFormOnPressed,
                icon: const Icon(Icons.send_outlined),
                label: const Text(StringConstant.buttonSave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
