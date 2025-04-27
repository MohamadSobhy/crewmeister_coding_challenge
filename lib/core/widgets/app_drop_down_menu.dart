import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../app_module.dart';
import '../theme/app_dimensions.dart';

class AppDropdownMenu<T> extends StatelessWidget {
  final List<T> list;
  final Function(T?)? onSelect;
  final String? hintText;
  final T? currentValue;
  final Color? hintColor;
  final bool? isLoading;
  final String? nameServices;
  final int? elevation;
  final String? Function(T?)? validator;
  final Color? fillColor;
  final String Function(T) valueFormatter;

  const AppDropdownMenu({
    super.key,
    this.list = const [],
    this.onSelect,
    this.hintText,
    this.currentValue,
    required this.valueFormatter,
    this.hintColor,
    this.isLoading = false,
    this.nameServices = "",
    this.elevation,
    this.validator,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<T>(
        alignment: AlignmentDirectional.centerStart,
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                hintText ?? '',
                style: AppModule.I.appStyles.text3(color: hintColor),
              ),
            ),
          ],
        ),
        items: list.map(
          (item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                valueFormatter.call(item),
                style: AppModule.I.appStyles.text3(),
              ),
            );
          },
        ).toList(),
        value: currentValue,
        onChanged: (value) => onSelect?.call(value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: fillColor != null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 1),
          enabledBorder: InputBorder.none,
        ),
        iconStyleData: IconStyleData(
          icon: isLoading == true
              ? SizedBox(
                  width: AppDimensions.dimen_40,
                  height: AppDimensions.dimen_20,
                  child: Center(child: const CircularProgressIndicator()),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: AppDimensions.dimen_55,
                  color: AppModule.I.appColors.darkCanvasColor
                      .withValues(alpha: 0.5),
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: AppDimensions.dimen_25,
                    color: hintColor,
                  ),
                ),
          iconEnabledColor: AppModule.I.appColors.grey,
          iconDisabledColor: AppModule.I.appColors.mediumGrey,
        ),
        buttonStyleData: ButtonStyleData(
          height: AppDimensions.dimen_55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: fillColor ?? AppModule.I.appColors.white,
          ),
          elevation: elevation,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: AppDimensions.dimen_30,
          padding: EdgeInsets.only(
            left: AppDimensions.dimen_16,
            right: AppDimensions.dimen_16,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: AppDimensions.dimen_200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppModule.I.appColors.white,
          ),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: Radius.circular(AppDimensions.dimen_8),
            thickness: WidgetStateProperty.all<double>(AppDimensions.dimen_6),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
          ),
        ),
      ),
    );
  }
}
