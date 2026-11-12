import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArchiveCalendar extends StatefulWidget {
  const ArchiveCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.firstDate,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime? firstDate;

  @override
  State<ArchiveCalendar> createState() => _ArchiveCalendarState();
}

class _ArchiveCalendarState extends State<ArchiveCalendar> {
  late DateTime _displayedMonth;

  static const List<String> _weekdays = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];

  @override
  void initState() {
    super.initState();

    _displayedMonth = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
    );
  }

  @override
  void didUpdateWidget(covariant ArchiveCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedDate != widget.selectedDate) {
      final selected = widget.selectedDate;

      if (selected.year != _displayedMonth.year ||
          selected.month != _displayedMonth.month) {
        _displayedMonth = DateTime(selected.year, selected.month);
      }
    }
  }

  DateTime get _today => DateUtils.dateOnly(DateTime.now());

  DateTime get _minimumDate =>
      DateUtils.dateOnly(widget.firstDate ?? DateTime(2000));

  bool get _canGoNext {
    final nextMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1);

    return !nextMonth.isAfter(DateTime(_today.year, _today.month));
  }

  bool get _canGoPrevious {
    final previousMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month - 1,
    );

    return !previousMonth.isBefore(
      DateTime(_minimumDate.year, _minimumDate.month),
    );
  }

  void _changeMonth(int offset) {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + offset,
      );
    });
  }

  void _selectDate(DateTime date) {
    if (date.isAfter(_today) || date.isBefore(_minimumDate)) {
      return;
    }

    widget.onDateSelected(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final firstDayOfMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month,
      1,
    );

    final daysInMonth = DateUtils.getDaysInMonth(
      _displayedMonth.year,
      _displayedMonth.month,
    );

    // Kalender dimulai dari hari Senin.
    final startingOffset = firstDayOfMonth.weekday - 1;

    final totalCells = ((startingOffset + daysInMonth + 6) ~/ 7) * 7;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          _buildMonthHeader(theme, colors),
          const SizedBox(height: 20),

          // Nama hari.
          Row(
            children: _weekdays.map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          // Grid tanggal.
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalCells,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              final dayNumber = index - startingOffset + 1;

              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const SizedBox.shrink();
              }

              final date = DateTime(
                _displayedMonth.year,
                _displayedMonth.month,
                dayNumber,
              );

              final isSelected = DateUtils.isSameDay(date, widget.selectedDate);

              final isToday = DateUtils.isSameDay(date, _today);

              final isDisabled =
                  date.isAfter(_today) || date.isBefore(_minimumDate);

              return _buildDayCell(
                date: date,
                isSelected: isSelected,
                isToday: isToday,
                isDisabled: isDisabled,
                theme: theme,
                colors: colors,
              );
            },
          ),

          const SizedBox(height: 12),

          // Keterangan kalender.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Tanggal dipilih',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(color: colors.primary),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Hari ini',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthHeader(ThemeData theme, ColorScheme colors) {
    final monthLabel = DateFormat('MMMM yyyy', 'id_ID').format(_displayedMonth);

    return Row(
      children: [
        IconButton(
          onPressed: _canGoPrevious ? () => _changeMonth(-1) : null,
          icon: const Icon(Icons.chevron_left_rounded),
          tooltip: 'Bulan sebelumnya',
        ),
        Expanded(
          child: Text(
            monthLabel,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        IconButton(
          onPressed: _canGoNext ? () => _changeMonth(1) : null,
          icon: const Icon(Icons.chevron_right_rounded),
          tooltip: 'Bulan berikutnya',
        ),
      ],
    );
  }

  Widget _buildDayCell({
    required DateTime date,
    required bool isSelected,
    required bool isToday,
    required bool isDisabled,
    required ThemeData theme,
    required ColorScheme colors,
  }) {
    final backgroundColor = isSelected ? colors.primary : Colors.transparent;

    final foregroundColor = isSelected
        ? colors.onPrimary
        : isDisabled
        ? colors.onSurface.withValues(alpha: 0.25)
        : colors.onSurface;

    return Material(
      color: backgroundColor,
      shape: CircleBorder(
        side: isToday && !isSelected
            ? BorderSide(color: colors.primary, width: 1.5)
            : BorderSide.none,
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: isDisabled ? null : () => _selectDate(date),
        child: Center(
          child: Text(
            '${date.day}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: foregroundColor,
              fontWeight: isSelected || isToday
                  ? FontWeight.w700
                  : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
