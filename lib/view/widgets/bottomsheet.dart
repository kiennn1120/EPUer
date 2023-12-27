import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../view/widgets/ui_outlined_button.dart';
import '../../view/widgets/ui_text.dart';
import '../../view/widgets/ui_textinput.dart';

class BottomSheetComponent {
  static Widget buildLoading() {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  static Widget buildHeaderBottomSheet() {
    return Container(
      height: DimensManager.dimens.setHeight(4),
      width: DimensManager.dimens.setWidth(40),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(DimensManager.dimens.setHeight(2)),
      ),
      margin: EdgeInsets.symmetric(vertical: DimensManager.dimens.setHeight(8)),
    );
  }

  static Widget buildHeaderTitle({
    required String title,
    bool withBottomBorder = true,
    required BuildContext context,
  }) {
    return Container(
      padding: EdgeInsets.only(
        bottom: DimensManager.dimens.setHeight(19.5),
        top: DimensManager.dimens.setHeight(16),
      ),
      width: DimensManager.dimens.setWidth(414),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: (withBottomBorder)
            ? const Border(bottom: BorderSide(color: AppColors.black, width: 0.5))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UIText(
            title,
            style: TextStyle(
              fontSize: DimensManager.dimens.setSp(18),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static showApply({
    required BuildContext context,
    required String title,
    required String titleInput,
    required void Function()? onPressedApply,
    TextEditingController? controller,
    bool? numberType,
    int? maxLength,
  }) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(DimensManager.dimens.setHeight(16)),
            topRight: Radius.circular(DimensManager.dimens.setHeight(16)),
          ),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomSheetComponent.buildHeaderBottomSheet(),
                  BottomSheetComponent.buildHeaderTitle(
                    title: title,
                    context: context,
                  ),
                  SizedBox(
                    height: DimensManager.dimens.setHeight(12),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DimensManager.dimens.setWidth(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: DimensManager.dimens.setHeight(5),
                                  left: DimensManager.dimens.setWidth(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: DimensManager.dimens.setHeight(16),
                                    ),
                                    UITextInput(
                                      maxLength: maxLength,
                                      numberType: numberType ?? false,
                                      controller: controller,
                                      title: titleInput,
                                      isRequired: true,
                                    ),
                                    SizedBox(
                                      height: DimensManager.dimens.setHeight(26),
                                    ),
                                    UIOutlineButton(
                                        onPressed: () {
                                          onPressedApply?.call();
                                          Navigator.pop(context);
                                        },
                                        backgroundColor: AppColors.primaryColor,
                                        titleStyle: const TextStyle(color: AppColors.white),
                                        title: "Tạo mới"),
                                    SizedBox(
                                      height: DimensManager.dimens.setHeight(26),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
