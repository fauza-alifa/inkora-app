import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/theme/app_theme.dart';

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
    'SEN',
    'SEL',
    'RAB',
    'KAM',
    'JUM',
    'SAB',
    'MIN',
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
    final isDark = theme.brightness == Brightness.dark;

    final calendarBackground = isDark
        ? AppTheme.inkoraBlue
        : AppTheme.primaryOrange.withValues(alpha: 0.1);

    final secondaryTextColor = colors.onSurfaceVariant;

    final firstDayOfMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month,
      1,
    );

    final daysInMonth = DateUtils.getDaysInMonth(
      _displayedMonth.year,
      _displayedMonth.month,
    );

    final startingOffset = firstDayOfMonth.weekday - 1;
    final totalCells = ((startingOffset + daysInMonth + 6) ~/ 7) * 7;

    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: calendarBackground,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calendar header
          _buildMonthHeader(theme, colors),

          SizedBox(height: 24),

          // Weekday labels
          Row(
            children: _weekdays.map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: secondaryTextColor,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 12),

          // Calendar dates
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: totalCells,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final dayNumber = index - startingOffset + 1;

              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return SizedBox.shrink();
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

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(
                color: AppTheme.primaryOrange,
                label: 'Dipilih',
                theme: theme,
                colors: colors,
              ),

              SizedBox(width: 22),

              _buildLegend(
                color: Colors.transparent,
                label: 'Hari ini',
                theme: theme,
                colors: colors,
                outlined: true,
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
        _buildMonthButton(
          icon: Icons.chevron_left_rounded,
          enabled: _canGoPrevious,
          tooltip: 'Bulan sebelumnya',
          onPressed: () => _changeMonth(-1),
          colors: colors,
        ),

        Spacer(),

        Text(
          monthLabel,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),

        Spacer(),

        _buildMonthButton(
          icon: Icons.chevron_right_rounded,
          enabled: _canGoNext,
          tooltip: 'Bulan berikutnya',
          onPressed: () => _changeMonth(1),
          colors: colors,
        ),
      ],
    );
  }

  Widget _buildMonthButton({
    required IconData icon,
    required bool enabled,
    required String tooltip,
    required VoidCallback onPressed,
    required ColorScheme colors,
  }) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: enabled ? onPressed : null,
        tooltip: tooltip,
        icon: Icon(
          icon,
          size: 26,
          color: enabled
              ? colors.onSurface
              : colors.onSurface.withValues(alpha: 0.25),
        ),
        splashRadius: 20,
        visualDensity: VisualDensity.compact,
      ),
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
    final foregroundColor = isSelected
        ? Colors.white
        : isDisabled
        ? colors.onSurface.withValues(alpha: 0.25)
        : colors.onSurface;

    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 180),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryOrange : Colors.transparent,
          shape: BoxShape.circle,
          border: isToday && !isSelected
              ? Border.all(color: AppTheme.primaryOrange, width: 1.5)
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: isDisabled ? null : () => _selectDate(date),
            child: Center(
              child: Text(
                '${date.day}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foregroundColor,
                  fontWeight: isSelected || isToday
                      ? FontWeight.w800
                      : FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend({
    required Color color,
    required String label,
    required ThemeData theme,
    required ColorScheme colors,
    bool outlined = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: outlined
                ? Border.all(color: AppTheme.primaryOrange, width: 1.5)
                : null,
          ),
        ),

        SizedBox(width: 7),

        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
