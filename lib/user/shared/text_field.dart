import 'package:flutter/material.dart';
import 'package:control_style/control_style.dart';

class TextFormShare extends StatelessWidget {
  final TextEditingController? controllerr;
  final String? Function(String?)? textvalidator;
  final String? labelname;
  final Function()? suffixAction;
  final IconData? suffixIcon;
  final TextInputType? textkeytype;
  final bool obscureText;
  final Function()? onpressed;
  const TextFormShare(
      {super.key,
      this.controllerr,
      this.textvalidator,
      //this.textname,
      this.labelname,
      this.suffixAction,
      this.suffixIcon,
      this.textkeytype,
      this.obscureText = false,
      this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controllerr,
        keyboardType: textkeytype,
        validator: textvalidator,
        cursorColor: const Color(0xff28CC9E),
        decoration: InputDecoration(
          border: DecoratedInputBorder(
              shadow: [
                BoxShadow(
                    color:
                        const Color.fromARGB(255, 191, 4, 4).withOpacity(0.25),
                    blurRadius: 4)
              ],
              child:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          labelStyle: TextStyle(
              backgroundColor: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xff132F2B).withOpacity(0.8)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 13.0),
          enabledBorder: DecoratedInputBorder(
            shadow: [
              BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.25),
                  blurRadius: 4)
            ],
            child: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff28CC9E)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          focusedBorder: DecoratedInputBorder(
            shadow: [
              BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.25),
                  blurRadius: 4)
            ],
            child: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff28CC9E)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: labelname,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: suffixAction,
                )
              : null,
        ),
      ),
    );
  }
}
