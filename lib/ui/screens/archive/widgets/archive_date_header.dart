import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArchiveDateHeader extends StatelessWidget {
  const ArchiveDateHeader({
    super.key,
    required this.selectedDate,
    required this.articleCount,
  });

  final DateTime selectedDate;
  final int articleCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final formattedDate = DateFormat(
      'EEEE, d MMMM yyyy',
      'id_ID',
    ).format(selectedDate);

    return Padding(
      padding: EdgeInsets.fromLTRB(4, 24, 4, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Arsip Berita',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 15,
                color: colors.primary,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  formattedDate,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '$articleCount berita ditemukan',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
