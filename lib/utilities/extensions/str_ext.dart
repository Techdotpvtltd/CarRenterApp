// ignore: dangling_library_doc_comments

/// Project: 	   CarRenterApp
/// File:    	   str_ext
/// Path:    	   lib/utilities/extensions/str_ext.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 13:39:16 -- Thursday
/// Description:
library;

extension TimeStr on String {
  /// Time format must be like 10:00
  bool timeGreaterThen({required String to}) {
    // Parese time
    final int selfTime = int.parse(replaceAll(':', ""));
    final int toTime = int.parse(to.replaceAll(':', ""));
    return selfTime > toTime;
  }

  bool timeLessThen({required String to}) {
    // Parese time
    final int selfTime = int.parse(replaceAll(':', ""));
    final int toTime = int.parse(to.replaceAll(':', ""));
    return selfTime < toTime;
  }
}
