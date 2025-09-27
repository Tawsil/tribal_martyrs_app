import 'package:intl/intl.dart';

class DateFormatter {
	static String format(DateTime date, {String pattern = 'yyyy/MM/dd'}) {
		return DateFormat(pattern, 'ar').format(date);
	}

	static DateTime? tryParse(String dateStr, {String pattern = 'yyyy/MM/dd'}) {
		try {
			return DateFormat(pattern, 'ar').parse(dateStr);
		} catch (_) {
			return null;
		}
	}
}
