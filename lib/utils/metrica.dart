import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:http/http.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

class Metrica {
  Metrica._();

  static sendEvent(String title, [Map<String, Object>? errors]) {
    try {
      if (errors == null) {
        AppMetrica.reportEvent(title);
      } else {
        AppMetrica.reportEventWithMap(title, errors);
      }
    } catch (e) {
      'Metrica error: $e'.dpRed().print();
    }
  }

  static requestError(VoidCallback request, String errorTitle) async {
    try {
      return request();
    } catch (e) {
      'Metrica - $errorTitle'.dpRed().print();
      if (e is HttpException) {
        e.message.toString().print();
      }
      rethrow;
    }
  }

  static bool onResponseDefaultError(Response response, String title,
      {Map<String, Object>? extraFields, bool ignoreDefault = false}) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      var defaultError = {'Ошибка': utf8.decode(response.bodyBytes)};
      if (extraFields != null && !ignoreDefault) {
        extraFields.addAll(defaultError);
      }
      'sendMetrica: (Ошибка - $title (${response.statusCode})) - ${extraFields ?? defaultError}'
          .dpRed()
          .print();
      AppMetrica.reportEventWithMap('Ошибка - $title (${response.statusCode})',
          extraFields ?? defaultError);
    }
    return true;
  }
}

extension ResponseMetricaBuilder on Response {
  MetricaBuilder errorMetrica(String title) =>
      MetricaBuilder(this, 'Ошибка', title);
}

class MetricaBuilder {
  final Response _response;
  String? _title;
  final String _type;
  String? _successType;
  String? _successTitle;
  Map<String, Object>? _extraFields;
  Map<String, Object>? _extraSuccessFields;
  bool _ignoreDefault = false;

  MetricaBuilder(this._response, this._type, this._title);

  MetricaBuilder _edit(VoidCallback act) {
    act();
    return this;
  }

  MetricaBuilder title(String title) => _edit(() => _title = title);

  MetricaBuilder extraFields(Map<String, Object> fields,
          [bool ignoreDefault = false]) =>
      _edit(() {
        _extraFields = fields;
        _ignoreDefault = ignoreDefault;
      });

  MetricaBuilder success(String type, String title,
          [Map<String, Object>? extra]) =>
      _edit(() {
        _successType = type;
        _successTitle = title;
        _extraSuccessFields = extra;
      });

  MetricaBuilder successRequest({String? title, Map<String, Object>? extra}) =>
      _edit(() {
        _successType = 'Запрос';
        _successTitle = title ?? _title;
        _extraSuccessFields = extra;
      });

  MetricaBuilder successMessage(String title, [Map<String, Object>? extra]) =>
      _edit(() {
        _successType = '';
        _successTitle = title;
        _extraSuccessFields = extra;
      });

  MetricaBuilder successExtra(Map<String, Object> extra) =>
      _edit(() => _extraSuccessFields = extra);

  bool build() {
    try {
      if (_response.statusCode >= 200 && _response.statusCode < 300) {
        if (_successTitle != null) {
          'sendMetrica: (${_successType?.isNotEmpty == true ? '$_successType - ' : ''}$_successTitle) - $_extraSuccessFields'
              .dpRed()
              .print();
          AppMetrica.reportEventWithMap(
              '${_successType?.isNotEmpty == true ? '$_successType - ' : ''}$_successTitle',
              _extraSuccessFields);
        }
      } else {
        var defaultError = {'Ошибка': utf8.decode(_response.bodyBytes)};
        if (_extraFields != null && !_ignoreDefault) {
          _extraFields!.addAll(defaultError);
        }
        'sendMetrica: ($_type - $_title (${_response.statusCode})) - ${_extraFields ?? defaultError}'
            .dpRed()
            .print();
        AppMetrica.reportEventWithMap(
            '$_type - $_title (${_response.statusCode})',
            _extraFields ?? defaultError);
      }
    } finally {}
    return !(_response.statusCode > 200 && _response.statusCode < 300);
  }
}
