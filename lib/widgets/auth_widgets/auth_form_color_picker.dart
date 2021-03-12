import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
  final Color currentColor;
  final Function changeColor;
  ColorPickerWidget(this.changeColor, this.currentColor);
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Vyber si Farbu!',style: TextStyle(color: Colors.white),),
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Vyber si farbu!', ),
              content: SingleChildScrollView(
                child: SlidePicker(
                  displayThumbColor: false,
                  pickerColor: widget.currentColor,
                  paletteType: PaletteType.rgb,
                  enableAlpha: false,
                  showLabel: false,
                  showIndicator: true,
                  onColorChanged: (color) {
                    widget.changeColor(color);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
