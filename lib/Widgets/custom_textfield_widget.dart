// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// //import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../utilitis/text_style_helper.dart';
// import '../utilitis/theme_helper.dart';
//
// class CustomTextFieldWidget extends StatefulWidget {
//   final TextEditingController? controller;
//   final bool? obscure;
//   final bool? readOnly;
//   final String? hint;
//   final Color? backGroundColor, focusedBorderColor;
//   final TextStyle? style;
//   final TextStyle? hintStyle;
//   final int? maxLine, minLines;
//   final String? Function(String?)? validator;
//   final TextInputType? textInputType;
//   final bool? enable, isDense;
//   final Color? borderColor;
//   final TextAlignVertical? textAlignVertical;
//   final bool disableBorder;
//   final FocusNode? focusNode;
//   final Color? readOnlyBorderColor;
//   final double? borderRadiusValue, width, height;
//   final EdgeInsets? insidePadding;
//   final void Function(String?)? onSave;
//   final Widget? prefixIcon, suffixIcon;
//   final void Function(String)? onchange;
//   final Function()? onSuffixTap;
//   final void Function()? onTap;
//   final List<TextInputFormatter>? formatter;
//   final TextInputAction? textInputAction;
//   final bool? expands;
//
//   const CustomTextFieldWidget({
//     Key? key,
//     this.isDense,
//     this.style,
//     this.onchange,
//     this.textAlignVertical,
//     this.insidePadding,
//     this.validator,
//     this.maxLine,
//     this.hint,
//     this.backGroundColor,
//     this.readOnlyBorderColor,
//     this.controller,
//     this.obscure = false,
//     this.enable = true,
//     this.readOnly = false,
//     this.textInputType = TextInputType.text,
//     this.borderColor,
//     this.borderRadiusValue,
//     this.prefixIcon,
//     this.width,
//     this.hintStyle,
//     this.suffixIcon,
//     this.onSuffixTap,
//     this.height,
//     this.onTap,
//     this.formatter,
//     this.focusNode,
//     this.focusedBorderColor,
//     this.onSave,
//     this.minLines,
//     this.disableBorder = false,
//     this.textInputAction,
//     this.expands,
//   }) : super(key: key);
//
//   @override
//   CustomTextFieldWidgetState createState() => CustomTextFieldWidgetState();
// }
//
// class CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
//   late FocusNode _focusNode;
//   bool _isFocused = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode = widget.focusNode ?? FocusNode();
//
//     _focusNode.addListener(() {
//       setState(() {
//         _isFocused = _focusNode.hasFocus;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     if (widget.focusNode == null) {
//       _focusNode.dispose();
//     }
//     super.dispose();
//   }
//
//   InputBorder? getBorder(
//       {double? radius, Color? color, bool isFocused = false}) {
//     if (widget.disableBorder) return null;
//     final borderColor = widget.readOnly == true
//         ? widget.readOnlyBorderColor ?? ThemeClass.of(context).waiting
//         : (isFocused
//             ? (widget.focusedBorderColor ?? ThemeClass.of(context).primaryColor)
//             : ThemeClass.of(context).waiting);
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(20),
//       borderSide: BorderSide(
//         color: borderColor,
//         width: 1,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       //height: widget.height,
//    //   width: widget.width ?? 327.w,
//       width: widget.width ?? 345,
//       child: TextFormField(
//         focusNode: _focusNode,
//         controller: widget.controller,
//         obscureText: widget.obscure ?? false,
//         readOnly: widget.readOnly ?? false,
//         enabled: widget.enable,
//         maxLines: widget.maxLine ?? null,
//         minLines: null,
//         //  maxLines: widget.maxLine ?? 1,
//         keyboardType: widget.textInputType,
//         style: widget.style ??
//             TextStyleHelper.of(context)
//                 .b_16
//                 .copyWith(color: ThemeClass.of(context).mainBlack),
//         textInputAction: widget.textInputAction,
//         onTap: widget.onTap,
//         onFieldSubmitted: widget.onSave,
//         inputFormatters: widget.formatter ?? [],
//         expands: widget.expands ?? false,
//         onChanged: widget.onchange,
//         textAlignVertical:widget.textAlignVertical?? TextAlignVertical.top,
//         validator: widget.validator,
//         decoration: InputDecoration(
//           isDense: true,
//           disabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: BorderSide(
//               color: ThemeClass.of(context).waiting,
//               width: 1,
//             ),
//           ),
//           errorStyle:
//               TextStyle(height: 1, color: ThemeClass.of(context).cancel),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: BorderSide(
//               color: ThemeClass.of(context).cancel,
//               width: 1,
//             ),
//           ),
//           enabledBorder: getBorder(
//             radius: 20,
//             color: widget.borderColor,
//             isFocused: _isFocused,
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: BorderSide(
//                 color: ThemeClass.of(context).primaryColor, width: 1.0),
//           ),
//           focusedBorder: getBorder(
//             radius: 20,
//             color: widget.focusedBorderColor ??
//                 ThemeClass.of(context).primaryColor,
//             isFocused: _isFocused,
//           ),
//           fillColor: widget.backGroundColor ??
//               ThemeClass.of(context).textFieldBackground,
//           filled: true,
//           hintText: widget.hint,
//           hintStyle: widget.hintStyle,
//           prefixIcon: widget.prefixIcon != null
//               ? Padding(
//                   padding: EdgeInsetsDirectional.symmetric(horizontal: 12),
//                   child: widget.prefixIcon,
//                 )
//               : null,
//           prefixIconConstraints: BoxConstraints(
//               minWidth: widget.prefixIcon == null ? 0 : 48,
//               maxHeight: 48),
//           suffixIconConstraints: BoxConstraints(
//               minWidth: widget.suffixIcon == null ? 0 : 48, maxHeight: 24),
//           suffixIcon: widget.suffixIcon != null
//               ? Padding(
//                   padding: EdgeInsetsDirectional.symmetric(horizontal: 12),
//                   child: InkWell(
//                     onTap: widget.onSuffixTap,
//                     child: widget.suffixIcon,
//                   ),
//                 )
//               : null,
//           contentPadding:
//               EdgeInsets.symmetric(vertical:5, horizontal: 24),
//         ),
//       ),
//     );
//   }
// }
