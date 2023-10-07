import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:riverpod_project/product/models/category.dart';
import 'package:riverpod_project/product/models/index.dart';
import 'package:riverpod_project/product/utility/exception/custom_excepiton.dart';
import 'package:riverpod_project/product/utility/firebase/firebase_collections.dart';
import 'package:riverpod_project/product/utility/firebase/firebase_utility.dart';
import 'package:riverpod_project/product/utility/image/project_image_picker.dart';

class HomeLogic with FirebaseUtility {
  final TextEditingController titleController = TextEditingController();
  // ignore: unused_field
  CategoryModel? _categoryModel;
  List<CategoryModel> _categories = [];
  Uint8List? _selectedFileBytes;
  XFile? _selectedFile;

  bool isValidForm = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  List<CategoryModel> get categories => _categories;
  Uint8List? get selectedFileBytes => _selectedFileBytes;

  // ignore: use_setters_to_change_properties
  void updateCategory(CategoryModel categoryModel) {
    _categoryModel = categoryModel;
  }

  bool checkValidateAndSave(ValueSetter<bool>? onUpdate) {
    final value = formKey.currentState?.validate() ?? false;
    if (value != isValidForm && selectedFileBytes != null) {
      isValidForm = value;
      onUpdate?.call(value);
    }
    return isValidForm;
  }

  Future<void> pickAndCheck(ValueSetter<bool> onUpdate) async {
    _selectedFile = await ProjectImagePicker().pickImageFromGallery();
    _selectedFileBytes = await _selectedFile?.readAsBytes();
    checkValidateAndSave((value) {});
    onUpdate.call(true);
  }

  void dispose() {
    titleController.dispose();
    _categoryModel = null;
  }

  Future<void> fetchAllCategory() async {
    final response = await fetchList<CategoryModel, CategoryModel>(
      CategoryModel(),
      FirebaseCollections.category,
    );
    _categories = response ?? [];
  }

  Future<bool> save() async {
    if (!checkValidateAndSave(null)) return false;
    final imageRef = createImageReference();
    if (imageRef == null) throw FirebaseCustomException('Image not empty');
    //final imageString = await _selectedFile!.readAsString();
    //await imageRef.putString(imageString, format: PutStringFormat.dataUrl);
    if (_selectedFileBytes == null) return false;
    await imageRef.putData(_selectedFileBytes!);
    final urlPath = await imageRef.getDownloadURL();

    final response = await FirebaseCollections.news.reference.add(
      News(
        backgroundImage: urlPath,
        category: _categoryModel?.name,
        categoryId: _categoryModel?.id,
        title: titleController.text,
      ).toJson(),
    );
    if (response.id.ext.isNullOrEmpty) return false;
    return true;
  }

  Reference? createImageReference() {
    if (_selectedFile == null ||
        (_selectedFile?.name.ext.isNullOrEmpty ?? true)) {
      return null;
    }
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(_selectedFile!.name);
    return imageRef;
  }
}
