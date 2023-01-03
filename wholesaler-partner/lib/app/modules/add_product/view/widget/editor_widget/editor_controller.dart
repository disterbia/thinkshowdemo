import 'dart:io';

import 'package:file_picker/src/platform_file.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_image_model.dart';

class EditorController extends GetxController {
  pApiProvider _apiProvider = pApiProvider();

  final HtmlEditorController editorController = HtmlEditorController();
  String editorResult = '';

  Future<ProductImageModel> uploadImageToServer(PlatformFile file) async {
    ProductImageModel tempImgModel = await _apiProvider.uploadProductImage(pickedImage: File(file.path!));
    return tempImgModel;
  }
}
