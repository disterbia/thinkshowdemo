import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/editor_widget/editor_controller.dart';
import 'dart:convert';

import 'package:wholesaler_user/app/models/product_image_model.dart';

class EditorWidget extends GetView {
  EditorController ctr = Get.put(EditorController());
  EditorWidget();

  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
      controller: ctr.editorController,
      htmlEditorOptions: HtmlEditorOptions(
        hint: '상품 설명을 입력해주세요.',
        // initialText: "<p>text content initial, if any</p>",
      ),
      htmlToolbarOptions: HtmlToolbarOptions(
        toolbarPosition: ToolbarPosition.aboveEditor, //by default
        toolbarType: ToolbarType.nativeGrid, //by default
        onButtonPressed:
            (ButtonType type, bool? status, Function? updateStatus) {
          return true;
        },
        onDropdownChanged: (DropdownType type, dynamic changed,
            Function(dynamic)? updateSelectedItem) {

          return true;
        },
        mediaLinkInsertInterceptor: (String url, InsertFileType type) {
          return false;
        },
        // mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
        mediaUploadInterceptor: (file, InsertFileType type) async {

          // change image width to 100%
          if (type == InsertFileType.image) {
            ProductImageModel tempImgModel =
                await ctr.uploadImageToServer(file);
            // ctr.editorController.insertNetworkImage(tempImgModel.url);
            String image100Witdh =
                """<img src="${tempImgModel.url}" data-filename="${file.name}" width="100%"/>""";
            ctr.editorController.insertHtml(image100Witdh);
          }

          return false;
        },
      ),
      otherOptions: OtherOptions(
        height: 700,
      ),
      callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
      }, onChangeContent: (String? changed) {
        // print('content changed to $changed');
      }, onChangeCodeview: (String? changed) {
        // print('code changed to $changed');
      }, onChangeSelection: (EditorSettings settings) {
      }, onDialogShown: () {
      }, onEnter: () {
      }, onFocus: () {
      }, onBlur: () {
      }, onBlurCodeview: () {
      }, onInit: () {
      },
          //this is commented because it overrides the default Summernote handlers
          //     onImageLinkInsert: (String? url) {
          //   print('onImageLinkInsert url $url');
          // },
          onImageUpload: (FileUpload file) async {
      }, onImageUploadError:
              (FileUpload? file, String? base64Str, UploadError error) {
        print('base64Str is $base64Str');
        print('error is $error');
        if (file != null) {

        }
      }, onKeyDown: (int? keyCode) {

      }, onKeyUp: (int? keyCode) {
        print(' $keyCode key released');
      }, onMouseDown: () {
        print(' mouse downed');
      }, onMouseUp: () {
        print(' mouse released');
      }, onNavigationRequestMobile: (String url) {
        print(' onNavigationRequestMobile url $url');
        return NavigationActionPolicy.ALLOW;
      }, onPaste: () {
        print('pasted into editor');
      }, onScroll: () {
        print('editor scrolled');
      }),
      plugins: [
        SummernoteAtMention(
            getSuggestionsMobile: (String value) {
              var mentions = <String>['test1', 'test2', 'test3'];
              return mentions
                  .where((element) => element.contains(value))
                  .toList();
            },
            mentionsWeb: ['test1', 'test2', 'test3'],
            onSelect: (String value) {
              print('value is $value');
            }),
      ],
    );
  }
}
