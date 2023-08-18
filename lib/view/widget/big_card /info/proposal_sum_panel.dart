import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ProposalSumPanel extends StatelessWidget {
  final String className;
  final String? row1;
  final String? row2;
  final String? row3;

  const ProposalSumPanel({
    Key? key,
    required this.className,
    this.row1,
    this.row2,
    this.row3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Container(
            width: 200,
            height: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 4.0),
                _buildRow(context, "tr.proposal_sum.row_t", row1!),
                const SizedBox(height: 8.0),
                _buildRow(context, "tr.proposal_sum.row_tx", row2!),
                const SizedBox(height: 8.0),
                _buildRow(context, "tr.proposal_sum.row_s", row3!),
                const SizedBox(height: 4.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              FlutterI18n.translate(context, label),
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
