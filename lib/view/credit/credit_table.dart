import 'package:avto_baraka/api/models/credit_models.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/widgets/car_card/one_card_table_row.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CreditTable extends StatelessWidget {
  const CreditTable({
    super.key,
    required this.data,
  });

  final CreditData data;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        tableRow(
          S.of(context).kreditMuddati,
          data.yil.toString() + S.of(context).yil,
        ),
        tableRow(
          S.of(context).oylarSoni,
          data.data.oylarSoni.toString() + S.of(context).oy,
        ),
        tableRow(
          S.of(context).oylikTolov,
          NumberFormat.currency(
                locale: "uz-UZ",
                symbol: "",
                decimalDigits: 0,
              ).format(data.data.oylikTulov) +
              S.of(context).som,
        ),
        tableRow(
          S.of(context).birinchiTolovUsd,
          NumberFormat.currency(
            locale: "uz-UZ",
            symbol: "\$",
            decimalDigits: 0,
          ).format(data.data.summaTulovUsd),
        ),
        tableRow(
          S.of(context).birinchiTolovUzs,
          '${NumberFormat.currency(
            locale: "uz-UZ",
            symbol: "",
            decimalDigits: 0,
          ).format(data.data.summaTulov)} ${S.of(context).som}',
        ),
      ],
    );
  }
}
