import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class TableInfoPanel extends StatelessWidget {
  final String? row1;
  final String? row2;
  final String? row3;

  const TableInfoPanel({
    Key? key,
    this.row1,
    this.row2,
    this.row3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 8.0),
          _buildRow(context, "tr.proposal_sum.row_t", row1!),
          const SizedBox(height: 8.0),
          _buildRow(context, "tr.proposal_sum.row_tx", row2!),
          const SizedBox(height: 8.0),
          _buildRow(context, "tr.proposal_sum.row_s", row3!),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Row(
        children: [
          Text(
            FlutterI18n.translate(context, label),
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.end,
          ),
          const SizedBox(width: 30),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
