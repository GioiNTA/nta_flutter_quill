// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';

import '../models/documents/attribute.dart';
import '../models/themes/quill_custom_button.dart';
import '../models/themes/quill_dialog_theme.dart';
import '../models/themes/quill_icon_theme.dart';
import 'controller.dart';
import 'toolbar/arrow_indicated_button_list.dart';
import 'toolbar/camera_button.dart';
import 'toolbar/color_button.dart';
import 'toolbar/formula_button.dart';
import 'toolbar/history_button.dart';
import 'toolbar/image_button.dart';
import 'toolbar/image_video_utils.dart';
import 'toolbar/indent_button.dart';
import 'toolbar/link_style_button.dart';
import 'toolbar/quill_icon_button.dart';
import 'toolbar/select_alignment_button.dart';
import 'toolbar/select_header_style_button.dart';
import 'toolbar/toggle_check_list_button.dart';
import 'toolbar/toggle_style_button.dart';

export 'toolbar/clear_format_button.dart';
export 'toolbar/color_button.dart';
export 'toolbar/history_button.dart';
export 'toolbar/image_button.dart';
export 'toolbar/image_video_utils.dart';
export 'toolbar/indent_button.dart';
export 'toolbar/link_style_button.dart';
export 'toolbar/quill_font_size_button.dart';
export 'toolbar/quill_icon_button.dart';
export 'toolbar/select_alignment_button.dart';
export 'toolbar/select_header_style_button.dart';
export 'toolbar/toggle_check_list_button.dart';
export 'toolbar/toggle_style_button.dart';
export 'toolbar/video_button.dart';

typedef OnImagePickCallback = Future<String?> Function(File file);
typedef OnVideoPickCallback = Future<String?> Function(File file);
typedef FilePickImpl = Future<String?> Function(BuildContext context);
typedef WebImagePickImpl = Future<String?> Function(
    OnImagePickCallback onImagePickCallback);
typedef WebVideoPickImpl = Future<String?> Function(
    OnVideoPickCallback onImagePickCallback);
typedef MediaPickSettingSelector = Future<MediaPickSetting?> Function(
    BuildContext context);

// The default size of the icon of a button.
const double kDefaultIconSize = 18;

// The factor of how much larger the button is in relation to the icon.
const double kIconButtonFactor = 1.77;

class QuillToolbar extends StatelessWidget implements PreferredSizeWidget {
  const QuillToolbar({
    required this.children,
    this.toolbarHeight = 36,
    this.toolbarIconAlignment = WrapAlignment.center,
    this.toolbarSectionSpacing = 4,
    this.multiRowsDisplay = true,
    this.color,
    this.filePickImpl,
    this.customButtons = const [],
    this.locale,
    Key? key,
  }) : super(key: key);

  factory QuillToolbar.basic({
    required QuillController controller,
    double toolbarIconSize = kDefaultIconSize,
    double toolbarSectionSpacing = 4,
    WrapAlignment toolbarIconAlignment = WrapAlignment.center,
    bool showDividers = true,
    bool showFontFamily = true,
    bool showFontSize = true,
    bool showBoldButton = true,
    bool showItalicButton = true,
    bool showSmallButton = false,
    bool showUnderLineButton = true,
    bool showStrikeThrough = true,
    bool showInlineCode = true,
    bool showColorButton = true,
    bool showBackgroundColorButton = true,
    bool showClearFormat = true,
    bool showAlignmentButtons = false,
    bool showLeftAlignment = true,
    bool showCenterAlignment = true,
    bool showRightAlignment = true,
    bool showJustifyAlignment = true,
    bool showHeaderStyle = true,
    bool showListNumbers = true,
    bool showListBullets = true,
    bool showListCheck = true,
    bool showCodeBlock = true,
    bool showQuote = true,
    bool showIndent = true,
    bool showLink = true,
    bool showUndo = true,
    bool showRedo = true,
    bool multiRowsDisplay = true,
    bool showImageButton = true,
    bool showVideoButton = true,
    bool showFormulaButton = false,
    bool showCameraButton = true,
    bool showDirection = false,
    bool showSearchButton = true,
    OnImagePickCallback? onImagePickCallback,
    OnVideoPickCallback? onVideoPickCallback,
    MediaPickSettingSelector? mediaPickSettingSelector,
    MediaPickSettingSelector? cameraPickSettingSelector,
    FilePickImpl? filePickImpl,
    WebImagePickImpl? webImagePickImpl,
    WebVideoPickImpl? webVideoPickImpl,
    List<QuillCustomButton> customButtons = const [],
    Map<String, String>? fontSizeValues,
    Map<String, String>? fontFamilyValues,
    QuillIconTheme? iconTheme,
    QuillDialogTheme? dialogTheme,
    Locale? locale,
    Key? key,
  }) {
    return QuillToolbar(
      key: key,
      toolbarHeight: toolbarIconSize * 2,
      toolbarSectionSpacing: toolbarSectionSpacing,
      toolbarIconAlignment: toolbarIconAlignment,
      multiRowsDisplay: multiRowsDisplay,
      customButtons: customButtons,
      locale: locale,
      children: [
        if (showUndo)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: HistoryButton(
              icon: 'assets/images/text_style_icons/previous.svg',
              iconSize: toolbarIconSize,
              controller: controller,
              undo: true,
              iconTheme: iconTheme,
            ),
          ),
        if (showRedo)
          HistoryButton(
            icon: 'assets/images/text_style_icons/forward.svg',
            iconSize: toolbarIconSize,
            controller: controller,
            undo: false,
            iconTheme: iconTheme,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        ),
        if (showHeaderStyle)
          SelectHeaderStyleButton(
            controller: controller,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        ),
        if (showColorButton)
          ColorButton(
            icon: Icons.color_lens,
            iconSize: toolbarIconSize,
            controller: controller,
            background: false,
            iconTheme: iconTheme,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        ),
        if (showBackgroundColorButton)
          ColorButton(
            icon: Icons.format_color_fill,
            iconSize: toolbarIconSize,
            controller: controller,
            background: true,
            iconTheme: iconTheme,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        ),
        // if (showFontFamily)
        //   QuillFontFamilyButton(
        //     iconTheme: iconTheme,
        //     iconSize: toolbarIconSize,
        //     attribute: Attribute.font,
        //     controller: controller,
        //     items: [
        //       for (MapEntry<String, String> fontFamily in fontFamilies.entries)
        //         PopupMenuItem<String>(
        //           key: ValueKey(fontFamily.key),
        //           value: fontFamily.value,
        //           child: Text(fontFamily.key.toString(),
        //               style: TextStyle(
        //                   color:
        //                       fontFamily.value == 'Clear' ? Colors.red : null)),
        //         ),
        //     ],
        //     onSelected: (newFont) {
        //       controller.formatSelection(Attribute.fromKeyValue(
        //           'font', newFont == 'Clear' ? null : newFont));
        //     },
        //     rawItemsMap: fontFamilies,
        //   ),
        // if (showFontSize)
        //   QuillFontSizeButton(
        //     iconTheme: iconTheme,
        //     iconSize: toolbarIconSize,
        //     attribute: Attribute.size,
        //     controller: controller,
        //     items: [
        //       for (MapEntry<String, String> fontSize in fontSizes.entries)
        //         PopupMenuItem<String>(
        //           key: ValueKey(fontSize.key),
        //           value: fontSize.value,
        //           child: Text(fontSize.key.toString(),
        //               style: TextStyle(
        //                   color: fontSize.value == '0' ? Colors.red : null)),
        //         ),
        //     ],
        //     onSelected: (newSize) {
        //       controller.formatSelection(Attribute.fromKeyValue(
        //           'size', newSize == '0' ? null : getFontSize(newSize)));
        //     },
        //     rawItemsMap: fontSizes,
        //   ),
        if (showBoldButton)
          ToggleStyleButton(
            attribute: Attribute.bold,
            icon: 'assets/images/text_style_icons/bold.svg',
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showItalicButton)
          ToggleStyleButton(
            attribute: Attribute.italic,
            icon: 'assets/images/text_style_icons/italic.svg',
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        // if (showSmallButton)
        //   ToggleStyleButton(
        //     attribute: Attribute.small,
        //     icon: 'assets/images/text_style_icons/italic.svg',
        //     iconSize: toolbarIconSize,
        //     controller: controller,
        //     iconTheme: iconTheme,
        //   ),
        if (showUnderLineButton)
          ToggleStyleButton(
            attribute: Attribute.underline,
            icon: 'assets/images/text_style_icons/under_line.svg',
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showStrikeThrough)
          ToggleStyleButton(
            attribute: Attribute.strikeThrough,
            icon: 'assets/images/text_style_icons/center_line.svg',
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        ),
        // if (showInlineCode)
        //   ToggleStyleButton(
        //     attribute: Attribute.inlineCode,
        //     icon: 'assets/images/text_style_icons/ellipsis_curlybraces.svg',
        //     iconSize: toolbarIconSize,
        //     controller: controller,
        //     iconTheme: iconTheme,
        //   ),

        // if (showClearFormat)
        //   ClearFormatButton(
        //     icon: Icons.format_clear,
        //     iconSize: toolbarIconSize,
        //     controller: controller,
        //     iconTheme: iconTheme,
        //   ),

        // if (showVideoButton)
        //   VideoButton(
        //     icon: Icons.movie_creation,
        //     iconSize: toolbarIconSize,
        //     controller: controller,
        //     onVideoPickCallback: onVideoPickCallback,
        //     filePickImpl: filePickImpl,
        //     webVideoPickImpl: webImagePickImpl,
        //     mediaPickSettingSelector: mediaPickSettingSelector,
        //     iconTheme: iconTheme,
        //     dialogTheme: dialogTheme,
        //   ),
        if ((onImagePickCallback != null || onVideoPickCallback != null) &&
            showCameraButton)
          CameraButton(
            icon: Icons.photo_camera,
            iconSize: toolbarIconSize,
            controller: controller,
            onImagePickCallback: onImagePickCallback,
            onVideoPickCallback: onVideoPickCallback,
            filePickImpl: filePickImpl,
            webImagePickImpl: webImagePickImpl,
            webVideoPickImpl: webVideoPickImpl,
            cameraPickSettingSelector: cameraPickSettingSelector,
            iconTheme: iconTheme,
          ),
        if (showFormulaButton)
          FormulaButton(
            icon: Icons.functions,
            iconSize: toolbarIconSize,
            controller: controller,
            onImagePickCallback: onImagePickCallback,
            filePickImpl: filePickImpl,
            webImagePickImpl: webImagePickImpl,
            mediaPickSettingSelector: mediaPickSettingSelector,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          ),
        // if (showDividers &&
        //     isButtonGroupShown[0] &&
        //     (isButtonGroupShown[1] ||
        //         isButtonGroupShown[2] ||
        //         isButtonGroupShown[3] ||
        //         isButtonGroupShown[4] ||
        //         isButtonGroupShown[5]))
        //   VerticalDivider(
        //     indent: 12,
        //     endIndent: 12,
        //     color: Colors.grey.shade400,
        //   ),
        if (showAlignmentButtons)
          SelectAlignmentButton(
            controller: controller,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
            showLeftAlignment: showLeftAlignment,
            showCenterAlignment: showCenterAlignment,
            showRightAlignment: showRightAlignment,
            showJustifyAlignment: showJustifyAlignment,
          ),
        // if (showDirection)
        //   ToggleStyleButton(
        //     attribute: Attribute.rtl,
        //     controller: controller,
        //     icon: 'assets/images/text_style_icons/ellipsis_curlybraces.svg',
        //     iconSize: toolbarIconSize,
        //     iconTheme: iconTheme,
        //   ),
        // if (showDividers &&
        //     isButtonGroupShown[1] &&
        //     (isButtonGroupShown[2] ||
        //         isButtonGroupShown[3] ||
        //         isButtonGroupShown[4] ||
        //         isButtonGroupShown[5]))
        //   VerticalDivider(
        //     indent: 12,
        //     endIndent: 12,
        //     color: Colors.grey.shade400,
        //   ),

        // if (showDividers &&
        //     showHeaderStyle &&
        //     isButtonGroupShown[2] &&
        //     (isButtonGroupShown[3] ||
        //         isButtonGroupShown[4] ||
        //         isButtonGroupShown[5]))
        //   VerticalDivider(
        //     indent: 12,
        //     endIndent: 12,
        //     color: Colors.grey.shade400,
        //   ),
        if (showListBullets)
          ToggleStyleButton(
            attribute: Attribute.ul,
            controller: controller,
            icon: 'assets/images/text_style_icons/list_bullet.svg',
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showListNumbers)
          ToggleStyleButton(
            attribute: Attribute.ol,
            controller: controller,
            icon: 'assets/images/text_style_icons/list_number.svg',
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),

        if (showListCheck)
          ToggleCheckListButton(
            attribute: Attribute.unchecked,
            controller: controller,
            icon: 'assets/images/text_style_icons/check_list.svg',
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        ),
        if (showIndent)
          IndentButton(
            icon: Icons.format_indent_increase,
            iconSize: toolbarIconSize,
            controller: controller,
            isIncrease: true,
            iconTheme: iconTheme,
          ),
        if (showIndent)
          IndentButton(
            icon: Icons.format_indent_decrease,
            iconSize: toolbarIconSize,
            controller: controller,
            isIncrease: false,
            iconTheme: iconTheme,
          ),

        if (showLink)
          LinkStyleButton(
            controller: controller,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          ),
        if (showImageButton)
          ImageButton(
            iconSize: toolbarIconSize,
            controller: controller,
            onImagePickCallback: onImagePickCallback,
            filePickImpl: filePickImpl,
            webImagePickImpl: webImagePickImpl,
            mediaPickSettingSelector: mediaPickSettingSelector,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          ),

        if (showQuote)
          ToggleStyleButton(
            attribute: Attribute.blockQuote,
            controller: controller,
            icon: 'assets/images/text_style_icons/quote_closing.svg',
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showCodeBlock)
          ToggleStyleButton(
            attribute: Attribute.codeBlock,
            controller: controller,
            icon: 'assets/images/text_style_icons/ellipsis_curlybraces.svg',
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),

        // if (showDividers && isButtonGroupShown[4] && isButtonGroupShown[5])
        //   VerticalDivider(
        //     indent: 12,
        //     endIndent: 12,
        //     color: Colors.grey.shade400,
        //   ),

        // if (showSearchButton)
        //   SearchButton(
        //     icon: Icons.search,
        //     iconSize: toolbarIconSize,
        //     controller: controller,
        //     iconTheme: iconTheme,
        //     dialogTheme: dialogTheme,
        //   ),
        if (customButtons.isNotEmpty)
          if (showDividers)
            VerticalDivider(
              indent: 12,
              endIndent: 12,
              color: Colors.grey.shade400,
            ),
        for (var customButton in customButtons)
          QuillIconButton(
              highlightElevation: 0,
              hoverElevation: 0,
              size: toolbarIconSize * kIconButtonFactor,
              icon: Icon(customButton.icon, size: toolbarIconSize),
              borderRadius: iconTheme?.borderRadius ?? 2,
              onPressed: customButton.onTap),
      ],
    );
  }

  final List<Widget> children;
  final double toolbarHeight;
  final double toolbarSectionSpacing;
  final WrapAlignment toolbarIconAlignment;
  final bool multiRowsDisplay;
  final Color? color;
  final FilePickImpl? filePickImpl;
  final Locale? locale;
  final List<QuillCustomButton> customButtons;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return I18n(
      initialLocale: locale,
      child: multiRowsDisplay
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: children,
                ),
              ),
            )
          : Container(
              constraints:
                  BoxConstraints.tightFor(height: preferredSize.height),
              color: color ?? Theme.of(context).canvasColor,
              child: ArrowIndicatedButtonList(buttons: children),
            ),
    );
  }
}
