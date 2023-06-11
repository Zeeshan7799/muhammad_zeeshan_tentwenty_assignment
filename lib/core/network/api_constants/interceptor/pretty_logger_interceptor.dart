import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const int _maxLineWidth = 90;

final prettyDioLogger = PrettyDioLogger(requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: _maxLineWidth);