import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

class CreditTermTag extends StatefulWidget {
  const CreditTermTag({
    Key? key,
    required this.id,
    required this.term,
    required this.termNameUz,
    required this.termNameRu,
    required this.isCheck,
    required this.isCheckId,
  }) : super(key: key);

  final int id;
  final int term;
  final String termNameUz;
  final String termNameRu;
  final bool isCheck;
  final int isCheckId;

  @override
  CreditTermTagState createState() => CreditTermTagState();
}

class CreditTermTagState extends State<CreditTermTag> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.isCheck ? backgrounColorWhite : tagBackgroundColor,
      child: Center(
        child: Text('${widget.term.toString()} ${widget.termNameRu}'),
      ),
    );
  }
}
