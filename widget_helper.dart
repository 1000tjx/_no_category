import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class WidgetHelper {
  final BuildContext? context;
  double screenWidth = 0;
  double screenHeight = 0;
  WidgetHelper(this.context, {dynamic screenSize}) {
    screenWidth = screenSize?.width ?? 0;
    screenHeight = screenSize?.height ?? 0;
  }
  // colors
  Color primaryColor = Colors.black;
  Color primaryColorDark = Colors.black;

  /* WIDGETS */
  // container card
  Widget container({
    dynamic child,
    dynamic margin,
    dynamic padding,
    double spreedRadius = 5,
    double blurRadius = 7,
    dynamic offset,
    dynamic color = Colors.white,
    dynamic width,
    dynamic height,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(25),
      margin: margin ??
          EdgeInsets.only(
            top: screenHeight * .15,
            left: screenWidth * 0.04,
            right: screenWidth * 0.04,
          ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: spreedRadius,
            blurRadius: blurRadius,
            offset: offset ?? Offset(0, 3),
          )
        ],
      ),
      child: child,
    );
  }

  // text
  Widget text(
    String text, {
    fontSize = 18,
    bool isSelectable = false,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    // init style
    TextStyle textStyle = TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
    if (isSelectable) {
      return SelectableText(text, style: textStyle);
    } else {
      return Text(text, style: textStyle);
    }
  }

  // text form field
  Widget textFormField({
    dynamic labelText,
    dynamic validator,
    dynamic icon,
    dynamic onChanged,
    bool obscureText = false,
    dynamic value,
  }) {
    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      initialValue: value,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.7),
          ),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      validator: validator,
    );
  }

  // button
  Widget button({
    dynamic child,
    dynamic buttonText,
    dynamic width,
    dynamic height,
    bool autoWidth = false,
    bool autoHeight = false,
    dynamic onPressed,
    dynamic onLongPress,
    dynamic color,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: autoWidth ? null : width ?? screenWidth * 0.25,
        height: autoHeight ? null : height ?? 50,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ElevatedButton.styleFrom(
          primary: color ?? primaryColor,
        ),
        child: child ??
            text(
              buttonText ?? "BUTTON",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
    );
  }

  // sidebar link
  Widget sidebarLink({
    required BuildContext context,
    required dynamic name,
    bool isReplacementPush = false,
    dynamic routeName,
    dynamic onTap,
    dynamic icon,
    double iconSize = 28,
    dynamic iconColor,
  }) {
    return GestureDetector(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Container(
            child: Row(
              children: [
                Icon(
                  icon ?? Icons.home_outlined,
                  size: iconSize,
                  color: iconColor,
                ),
                Container(width: 15),
                text(
                  name ?? 'LINK',
                  fontSize: 18,
                ),
              ],
            ),
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ),
      onTap: onTap ??
          () {
            if (ModalRoute.of(context)?.settings.name != routeName) {
              if (isReplacementPush) {
                Navigator.pushReplacementNamed(context, routeName);
              } else {
                Navigator.pushNamed(context, routeName);
              }
            }
          },
    );
  }

  Widget clickable({required Widget child, dynamic onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: child,
      ),
    );
  }

  TableRow makeRow({
    required List<String> columns,
    dynamic textColor,
    dynamic backgroundColor,
    double? padding,
    double? borderRadius,
    bool customChild = false,
    dynamic child,
  }) {
    List<Widget> columnWidgets = [];
    for (int i = 0; i < columns.length; i++) {
      columnWidgets.add(
        Center(
            child: Container(
          padding: EdgeInsets.all(padding ?? 15),
          child: customChild
              ? child
              : text(
                  columns[i],
                  color: textColor ?? Colors.white,
                  isSelectable: true,
                ),
        )),
      );
    }
    return TableRow(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.purple,
        borderRadius: BorderRadius.circular(borderRadius ?? 2),
      ),
      children: columnWidgets,
    );
  }

  Future<void> selectDate(
    BuildContext context, {
    dynamic initialDate,
    dynamic onDatePick,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      onDatePick(picked);
    }
  }

  Future<void> displayDialog(
    BuildContext context, {
    dynamic title,
    dynamic child,
    dynamic onCancel,
    dynamic onConfirm,
    dynamic cancelButtonText,
    dynamic confirmButtonText,
    dynamic cancelButtonColor,
    dynamic confirmButtonColor,
    dynamic actions,
    bool isDissmissable = false,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: isDissmissable, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: child,
          ),
          actions: isDissmissable == false
              ? actions ??
                  <Widget>[
                    button(
                      autoWidth: true,
                      height: 30,
                      child: text(
                        cancelButtonText ?? 'CANCEL',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      color: cancelButtonColor ?? Colors.red,
                      onPressed: onCancel ??
                          () {
                            Navigator.pop(context);
                          },
                    ),
                    Container(width: 2),
                    button(
                      autoWidth: true,
                      height: 30,
                      child: text(
                        confirmButtonText ?? 'CONFIRM',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      color: confirmButtonColor ?? Colors.green,
                      onPressed: onConfirm ??
                          () {
                            Navigator.pop(context);
                          },
                    ),
                  ]
              : <Widget>[
                  button(
                    autoWidth: true,
                    height: 30,
                    child: text(
                      cancelButtonText ?? 'OK',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    color: cancelButtonColor ?? primaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
        );
      },
    );
  }

  Widget clickableImage({
    dynamic onTap,
    required Image image,
    double borderRadius = 20,
  }) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: image,
        ),
        clickable(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius),
              ),
            ),
            width: image.width,
            child: Icon(
              Icons.add,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // require file_picker: 3.0.2+2
  Future<void> pickFile({
    dynamic onPick,
    dynamic onNoPick,
    FileType fileType = FileType.image,
    bool allowMultiple = false,
    bool isWeb = true,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowMultiple: allowMultiple,
        withData: isWeb,
        withReadStream: !isWeb,
      );
      if (result != null) {
        onPick(result);
      } else {
        // User canceled the picker
        onNoPick();
      }
    } catch (e) {
      onNoPick();
    }
  }
}
