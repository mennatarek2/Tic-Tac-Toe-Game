import 'package:flutter/material.dart';

class XoButton extends StatelessWidget {
  const XoButton({
    super.key,
    required this.symbol,
    required this.onClick,
    required this.index,
  });
  final String symbol;
  final Function onClick;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: () {
          onClick(index);
        },
        child: symbol.isEmpty
            ? Text(symbol)
            : Image.asset('assets/images/$symbol.png'),
      ),
    );
  }
}
