// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:typed_data';
import 'dart:js';
import 'dart:html';
import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter_hbb/web/bridge.dart';
import 'package:flutter_hbb/common.dart';

final List<StreamSubscription<MouseEvent>> mouseListeners = [];
final List<StreamSubscription<KeyboardEvent>> keyListeners = [];

typedef HandleEvent = Future<void> Function(Map<String, dynamic> evt);

class PlatformFFI {
  final _eventHandlers = <String, Map<String, HandleEvent>>{};
  final RustdeskImpl _ffiBind = RustdeskImpl();

  static String getByName(String name, [String arg = '']) {
    return context.callMethod('getByName', [name, arg]);
  }

  static void setByName(String name, [String value = '']) {
    context.callMethod('setByName', [name, value]);
  }

  PlatformFFI._();
  static final PlatformFFI instance = PlatformFFI._();

  static get localeName => window.navigator.language;
  RustdeskImpl get ffiBind => _ffiBind;

  static Future<String> getVersion() async => getByName('version');

  bool registerEventHandler(String eventName, String handlerName, HandleEvent handler) {
    var handlers = _eventHandlers[eventName];
    if (handlers == null) {
      _eventHandlers[eventName] = {handlerName: handler};
      return true;
    } else {
      if (handlers.containsKey(handlerName)) return false;
      handlers[handlerName] = handler;
      return true;
    }
  }

  void unregisterEventHandler(String eventName, String handlerName) {
    _eventHandlers[eventName]?.remove(handlerName);
  }

  void Function(Map<String, dynamic>)? _onGlobalEventCb;
  void Function(int, Uint8List)? _onRgbaCb;

  Future<bool> tryHandle(Map<String, dynamic> evt) async {
    final name = evt['name'];
    if (name != null) {
      final handlers = _eventHandlers[name];
      if (handlers != null && handlers.isNotEmpty) {
        for (var handler in handlers.values) {
          await handler(evt);
        }
        return true;
      }
    }
    return false;
  }

  String translate(String name, String locale) => _ffiBind.translate(name: name, locale: locale);

  Uint8List? getRgba(SessionID sessionId, int display, int bufSize) => null;
  int getRgbaSize(SessionID sessionId, int display) => 0;
  void nextRgba(SessionID sessionId, int display) {}
  void registerPixelbufferTexture(SessionID sessionId, int display, int ptr) {}
  void registerGpuTexture(SessionID sessionId, int display, int ptr) {}

  Future<void> init(String appType) async {
    context.callMethod('init');
    version = getByName('version');
    window.onContextMenu.listen((event) => event.preventDefault());

    context['onRegisteredEvent'] = (String message) {
      try {
        Map<String, dynamic> event = json.decode(message);
        tryHandle(event);
        _onGlobalEventCb?.call(event);
      } catch (e) {
        print('json.decode fail(): $e');
      }
    };

    context['onGlobalEvent'] = (String message) {
      try {
        Map<String, dynamic> event = json.decode(message);
        tryHandle(event);
        _onGlobalEventCb?.call(event);
      } catch (e) {
        print('onGlobalEvent fail: $e');
      }
    };

    context['onRgba'] = (int display, Uint8List? rgba) {
      if (rgba != null) _onRgbaCb?.call(display, rgba);
    };
  }

  void setEventCallback(void Function(Map<String, dynamic>) fun) => _onGlobalEventCb = fun;
  void setRgbaCallback(void Function(int, Uint8List) fun) => _onRgbaCb = fun;

  void startDesktopWebListener() {
    mouseListeners.add(window.document.onContextMenu.listen((evt) => evt.preventDefault()));
  }
  void stopDesktopWebListener() {
    for (var ml in mouseListeners) { ml.cancel(); }
    mouseListeners.clear();
    for (var kl in keyListeners) { kl.cancel(); }
    keyListeners.clear();
  }

  void setMethodCallHandler(FMethod callback) {}
  invokeMethod(String method, [dynamic arguments]) async => true;
  void syncAndroidServiceAppDirConfigPath() {}
}