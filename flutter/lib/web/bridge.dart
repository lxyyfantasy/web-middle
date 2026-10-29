import 'dart:async';
import 'dart:js' as js;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_hbb/consts.dart';

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

mixin _$EventToUI {
  Object get field0 => throw _privateConstructorUsedError;
}

sealed class EventToUI {
  const factory EventToUI.event(String field0) = EventToUI_Event;
  const factory EventToUI.rgba(int field0) = EventToUI_Rgba;
  const factory EventToUI.texture(int field0) = EventToUI_Texture;
}

class EventToUI_Event implements EventToUI {
  const EventToUI_Event(final String field0) : this.field = field0;
  final String field;
  String get field0 => field;
}

class EventToUI_Rgba implements EventToUI {
  const EventToUI_Rgba(final int field0) : this.field = field0;
  final int field;
  int get field0 => field;
}

class EventToUI_Texture implements EventToUI {
  const EventToUI_Texture(final int field0) : this.field = field0;
  final int field;
  int get field0 => field;
}

String _jsGet(String name, [String arg = '']) {
  final v = js.context.callMethod('getByName', [name, arg]);
  return (v == null) ? '' : v.toString();
}

void _jsSet(String name, [String value = '']) {
  js.context.callMethod('setByName', [name, value]);
}

class RustdeskImpl {
  // ---------- global event / lifecycle ----------
  Future<void> stopGlobalEventStream({required String appType, dynamic hint}) async {}
  Future<void> hostStopSystemKeyPropagate({required bool stopped, dynamic hint}) async {}
  Future<void> mainInit({required String appDir, dynamic hint}) async {}
  Future<void> mainStartDbusServer({dynamic hint}) async {}
  Future<void> mainStartIpcUrlServer({dynamic hint}) async {}
  Future<void> mainOnMainWindowClose({dynamic hint}) async {}
  void dispose() {}

  // ---------- options ----------
  Future<String> mainGetOption({required String key, dynamic hint}) async => mainGetOptionSync(key: key);
  String mainGetOptionSync({required String key, dynamic hint}) => _jsGet('option', key);
  Future<void> mainSetOption({required String key, required String value, dynamic hint}) async {
    _jsSet('option', jsonEncode({'name': key, 'value': value}));
  }
  String mainGetLocalOption({required String key, dynamic hint}) => _jsGet('option:local', key);
  Future<void> mainSetLocalOption({required String key, required String value, dynamic hint}) async {
    _jsSet('option:local', jsonEncode({'name': key, 'value': value}));
  }
  String getLocalFlutterOption({required String k, dynamic hint}) => _jsGet('option:flutter:local', k);
  Future<void> setLocalFlutterOption({required String k, required String v, dynamic hint}) async {
    _jsSet('option:flutter:local', jsonEncode({'name': k, 'value': v}));
  }
  String getLocalKbLayoutType({dynamic hint}) => _jsGet('option:local', 'kb_layout');
  Future<void> setLocalKbLayoutType({required String kbLayoutType, dynamic hint}) async {
    _jsSet('option:local', jsonEncode({'name': 'kb_layout', 'value': kbLayoutType}));
  }
  Future<String> mainGetOptions({dynamic hint}) async => mainGetOptionsSync();
  String mainGetOptionsSync({dynamic hint}) {
    final ls = js.context['localStorage'];
    const keys = ['custom-rendezvous-server', 'relay-server', 'api-server', 'key'];
    final map = <String, String>{};
    for (final k in keys) {
      final v = ls.callMethod('getItem', [k]);
      if (v is String && v.isNotEmpty) map[k] = v;
    }
    return jsonEncode(map);
  }
  Future<void> mainSetOptions({required String json, dynamic hint}) async {
    final ls = js.context['localStorage'];
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      map.forEach((k, v) => ls.callMethod('setItem', [k, v.toString()]));
    } catch (_) {}
  }
  Future<String> mainTestIfValidServer({required String server, required bool testWithProxy, dynamic hint}) async =>
      _jsGet('test_if_valid_server', server);
  Future<bool> mainIsUsingPublicServer({dynamic hint}) async => _jsGet('is_using_public_server') == 'true';
  Future<String> mainGetConnectStatus({dynamic hint}) async => _jsGet('get_conn_status');
  Future<void> mainCheckConnectStatus({dynamic hint}) async {}
  Future<String> mainGetApiServer({dynamic hint}) async {
    final ls = js.context['localStorage'];
    final v = ls.callMethod('getItem', ['api-server']);
    return (v == null || v is! String) ? '' : v;
  }
  Future<String> mainGetVersion({dynamic hint}) async => _jsGet('version');
  int versionToNumber({required String v, dynamic hint}) =>
      int.tryParse(_jsGet('get_version_number', v)) ?? 0;
  bool mainShowOption({required String key, dynamic hint}) => true;
  Future<void> mainSetUserDefaultOption({required String key, required String value, dynamic hint}) async {
    _jsSet('option:user:default', jsonEncode({'name': key, 'value': value}));
  }
  String mainGetUserDefaultOption({required String key, dynamic hint}) => _jsGet('option:user:default', key);
  Future<void> mainChangeTheme({required String dark, dynamic hint}) async {}
  Future<void> mainChangeLanguage({required String lang, dynamic hint}) async {}
  bool mainIsOptionFixed({required String key, dynamic hint}) => false;
  Future<bool> optionSynced({dynamic hint}) async => true;

  // ---------- identity ----------
  Future<String> mainGetMyId({dynamic hint}) async {
    final ls = js.context['localStorage'];
    final v = ls.callMethod('getItem', ['my-id']);
    return (v == null || v is! String) ? '' : v;
  }
  Future<String> mainGetUuid({dynamic hint}) async {
    final ls = js.context['localStorage'];
    final v = ls.callMethod('getItem', ['my-uuid']);
    return (v == null || v is! String) ? '' : v;
  }
  Future<void> mainDeviceId({required String id, dynamic hint}) async {}
  Future<void> mainDeviceName({required String name, dynamic hint}) async {}
  Future<void> mainChangeId({required String newId, dynamic hint}) async {}
  Future<String> mainGetAsyncStatus({dynamic hint}) async => '';
  String mainGetLoginDeviceInfo({dynamic hint}) => jsonEncode({'os': 'web'});

  // ---------- peers / recent / fav ----------
  Future<void> mainLoadRecentPeers({dynamic hint}) async => _jsSet('load_recent_peers');
  String mainLoadRecentPeersSync({dynamic hint}) => _jsGet('load_recent_peers_sync');
  Future<void> mainLoadFavPeers({dynamic hint}) async => _jsSet('load_fav_peers');
  Future<List<String>> mainGetFav({dynamic hint}) async {
    try {
      final raw = _jsGet('fav');
      if (raw.isEmpty) return [];
      return (jsonDecode(raw) as List).map((e) => e.toString()).toList();
    } catch (_) {
      return [];
    }
  }
  Future<void> mainStoreFav({required List<String> favs, dynamic hint}) async =>
      _jsSet('fav', jsonEncode(favs));
  Future<void> mainRemovePeer({required String id, dynamic hint}) async => _jsSet('remove', id);
  Future<void> mainForgetPassword({required String id, dynamic hint}) async => _jsSet('forget', id);
  Future<bool> mainPeerHasPassword({required String id, dynamic hint}) async =>
      _jsGet('peer_has_password', id) == 'true';
  Future<bool> mainPeerExists({required String id, dynamic hint}) async =>
      _jsGet('peer_exists', id) == 'true';
  String mainGetPeerSync({required String id, dynamic hint}) {
    try {
      final peers = jsonDecode(_jsGet('peers')) as List;
      for (final e in peers) {
        if (e is List && e.isNotEmpty && e[0] == id) {
          return jsonEncode({'id': id, 'info': jsonDecode(e[1].toString())});
        }
      }
    } catch (_) {}
    return '{}';
  }
  String mainGetPeerOptionSync({required String id, required String key, dynamic hint}) =>
      _jsGet('option:peer', jsonEncode({'id': id, 'name': key}));
  Future<String> mainGetPeerOption({required String id, required String key, dynamic hint}) async =>
      mainGetPeerOptionSync(id: id, key: key);
  bool mainSetPeerOptionSync({required String id, required String key, required String value, dynamic hint}) {
    _jsSet('option:peer', jsonEncode({'id': id, 'name': key, 'value': value}));
    return true;
  }
  Future<void> mainSetPeerOption({required String id, required String key, required String value, dynamic hint}) async {
    mainSetPeerOptionSync(id: id, key: key, value: value);
  }
  Future<void> mainSetPeerAlias({required String id, required String alias, dynamic hint}) async {
    _jsSet('option:peer', jsonEncode({'id': id, 'name': 'alias', 'value': alias}));
  }
  String mainGetPeerFlutterOptionSync({required String id, required String k, dynamic hint}) =>
      _jsGet('option:flutter:peer', k);
  void mainSetPeerFlutterOptionSync({required String id, required String k, required String v, dynamic hint}) {
    _jsSet('option:flutter:peer', jsonEncode({'name': k, 'value': v}));
  }
  Future<String> mainHandleRelayId({required String id, dynamic hint}) async {
    var newId = id;
    if (id.endsWith("\r") || id.endsWith("/r")) newId = id.substring(0, id.length - 2);
    return newId;
  }
  Future<String> mainGetLastRemoteId({dynamic hint}) async => _jsGet('option', 'last_remote_id');
  Future<void> queryOnlines({required List<String> ids, dynamic hint}) async =>
      _jsSet('query_onlines', jsonEncode(ids));
  int peerGetDefaultSessionsCount({required String id, dynamic hint}) => 1;

  // ---------- lan / discover ----------
  Future<void> mainDiscover({dynamic hint}) async {}
  Future<void> mainRemoveDiscovered({required String id, dynamic hint}) async {}
  Future<void> mainLoadLanPeers({dynamic hint}) async {}
  String mainLoadLanPeersSync({dynamic hint}) => '{}';

  // ---------- ab / group cache ----------
  Future<void> mainSaveAb({required String json, dynamic hint}) async {}
  Future<void> mainClearAb({dynamic hint}) async {}
  Future<String> mainLoadAb({dynamic hint}) async => '{}';
  Future<void> mainSaveGroup({required String json, dynamic hint}) async {}
  Future<void> mainClearGroup({dynamic hint}) async {}
  Future<String> mainLoadGroup({dynamic hint}) async => '{}';
  Future<String> mainLoadRecentPeersForAb({required String filter, dynamic hint}) async => '';
  Future<String> mainGetNewStoredPeers({dynamic hint}) async => '';

  // ---------- account auth (Web: 走纯前端 HTTP，见 user_model) ----------
  Future<void> mainAccountAuth({required String op, required bool rememberMe, dynamic hint}) async {}
  Future<void> mainAccountAuthCancel({dynamic hint}) async {}
  Future<String> mainAccountAuthResult({dynamic hint}) async => '';

  // ---------- translate ----------
  String translate({required String name, required String locale, dynamic hint}) =>
      _jsGet('translate', jsonEncode({'locale': locale, 'text': name}));

  // ---------- session (真实对接 connection.ts) ----------
  String sessionAddSync({
    required UuidValue sessionId, required String id,
    required bool isFileTransfer, required bool isPortForward, required bool isRdp,
    required String switchUuid, required bool forceRelay,
    required String password, required bool isSharedPassword, dynamic hint,
  }) {
    _jsSet('session_add_sync', jsonEncode({'id': id, 'password': password}));
    return '';
  }
  String sessionAddExistedSync({
    required String id,
    required UuidValue sessionId,
    required Int32List displays,
    dynamic hint,
  }) => '';
  Stream<EventToUI> sessionStart({required UuidValue sessionId, required String id, dynamic hint}) {
    _jsSet('connect', id);
    return const Stream.empty();
  }
  Stream<EventToUI> sessionStartWithDisplays({
    required UuidValue sessionId, required String id, required Int32List displays, dynamic hint,
  }) {
    _jsSet('connect', id);
    return const Stream.empty();
  }
  Future<void> sessionClose({required UuidValue sessionId, dynamic hint}) async => _jsSet('close');
  Future<void> sessionReconnect({required UuidValue sessionId, required bool forceRelay, dynamic hint}) async => _jsSet('reconnect');
  Future<void> sessionRefresh({required UuidValue sessionId, required int display, dynamic hint}) async => _jsSet('refresh');
  Future<void> sessionLogin({
    required UuidValue sessionId, required String osUsername, required String osPassword,
    required String password, required bool remember, dynamic hint,
  }) async {
    _jsSet('login', jsonEncode({
      'os_username': osUsername, 'os_password': osPassword,
      'password': password, 'remember': remember,
    }));
  }
  Future<void> sessionSend2Fa({required UuidValue sessionId, required String code, dynamic hint}) async =>
      _jsSet('send_2fa', code);
  Future<void> sessionInputKey({
    required UuidValue sessionId, required String name, required bool down,
    required bool press, required bool alt, required bool ctrl,
    required bool shift, required bool command, dynamic hint,
  }) async {
    _jsSet('input_key', jsonEncode({
      'name': name,
      if (down) 'down': 'true',
      if (press) 'press': 'true',
      if (alt) 'alt': 'true',
      if (ctrl) 'ctrl': 'true',
      if (shift) 'shift': 'true',
      if (command) 'command': 'true',
    }));
  }
  Future<void> sessionInputString({required UuidValue sessionId, required String value, dynamic hint}) async =>
      _jsSet('input_string', value);
  Future<void> sessionSendMouse({required UuidValue sessionId, required String msg, dynamic hint}) async =>
      _jsSet('send_mouse', msg);
  Future<void> sessionSendPointer({required UuidValue sessionId, required String msg, dynamic hint}) async =>
      _jsSet('send_mouse', msg);
  Future<void> sessionInputOsPassword({required UuidValue sessionId, required String value, dynamic hint}) async =>
      _jsSet('input_os_password', value);
  Future<void> sessionSwitchDisplay({required bool isDesktop, required UuidValue sessionId, required Int32List value, dynamic hint}) async =>
      _jsSet('switch_display', jsonEncode(value));
  Future<void> sessionLockScreen({required UuidValue sessionId, dynamic hint}) async => _jsSet('lock_screen');
  Future<void> sessionCtrlAltDel({required UuidValue sessionId, dynamic hint}) async => _jsSet('ctrl_alt_del');
  Future<void> sessionRestartRemoteDevice({required UuidValue sessionId, dynamic hint}) async => _jsSet('restart');
  Future<void> sessionSendNote({required UuidValue sessionId, required String note, dynamic hint}) async => _jsSet('send_note', note);
  Future<String> sessionAlternativeCodecs({required UuidValue sessionId, dynamic hint}) async => _jsGet('alternative_codecs');
  Future<void> sessionChangePreferCodec({required UuidValue sessionId, dynamic hint}) async => _jsSet('change_prefer_codec');
  String sessionGetAuditServerSync({required UuidValue sessionId, required String typ, dynamic hint}) =>
      _jsGet('audit_server', typ);
  Future<void> sessionToggleOption({required UuidValue sessionId, required String value, dynamic hint}) async =>
      _jsSet('toggle_option', value);
  Future<void> sessionTogglePrivacyMode({required UuidValue sessionId, required String implKey, required bool on, dynamic hint}) async =>
      _jsSet('toggle_option', jsonEncode({implKey, on}));
  Future<bool?> sessionGetRemember({required UuidValue sessionId, dynamic hint}) async =>
      _jsGet('remember') == 'true';
  Future<bool?> sessionGetToggleOption({required UuidValue sessionId, required String arg, dynamic hint}) async =>
      sessionGetToggleOptionSync(sessionId: sessionId, arg: arg);
  bool sessionGetToggleOptionSync({required UuidValue sessionId, required String arg, dynamic hint}) =>
      _jsGet('toggle_option', arg) == 'true';
  Future<String?> sessionGetOption({required UuidValue sessionId, required String arg, dynamic hint}) async {
    final v = _jsGet('option:session', arg);
    return v.isEmpty ? null : v;
  }
  Future<void> sessionPeerOption({required UuidValue sessionId, required String name, required String value, dynamic hint}) async {
    _jsSet('option:session', jsonEncode({'name': name, 'value': value}));
  }
  Future<String> sessionGetPeerOption({required UuidValue sessionId, required String name, dynamic hint}) async =>
      _jsGet('option:session', name);
  Future<String?> sessionGetFlutterOption({required UuidValue sessionId, required String k, dynamic hint}) async {
    final v = _jsGet('option:flutter:peer', k);
    return v.isEmpty ? null : v;
  }
  Future<void> sessionSetFlutterOption({required UuidValue sessionId, required String k, required String v, dynamic hint}) async {
    _jsSet('option:flutter:peer', jsonEncode({'name': k, 'value': v}));
  }
  Future<String?> sessionGetViewStyle({required UuidValue sessionId, dynamic hint}) async {
    final v = _jsGet('option:session', 'view_style');
    return v.isEmpty ? null : v;
  }
  Future<void> sessionSetViewStyle({required UuidValue sessionId, required String value, dynamic hint}) async =>
      _jsSet('option:session', jsonEncode({'name': 'view_style', 'value': value}));
  Future<String?> sessionGetScrollStyle({required UuidValue sessionId, dynamic hint}) async {
    final v = _jsGet('option:session', 'scroll_style');
    return v.isEmpty ? null : v;
  }
  Future<void> sessionSetScrollStyle({required UuidValue sessionId, required String value, dynamic hint}) async =>
      _jsSet('option:session', jsonEncode({'name': 'scroll_style', 'value': value}));
  Future<String?> sessionGetImageQuality({required UuidValue sessionId, dynamic hint}) async {
    final v = _jsGet('option:session', 'image_quality');
    return v.isEmpty ? null : v;
  }
  Future<void> sessionSetImageQuality({required UuidValue sessionId, required String value, dynamic hint}) async =>
      _jsSet('option:session', jsonEncode({'name': 'image_quality', 'value': value}));
  Future<String?> sessionGetKeyboardMode({required UuidValue sessionId, dynamic hint}) async {
    final v = _jsGet('option:session', 'keyboard_mode');
    return v.isEmpty ? null : v;
  }
  Future<void> sessionSetKeyboardMode({required UuidValue sessionId, required String value, dynamic hint}) async =>
      _jsSet('option:session', jsonEncode({'name': 'keyboard_mode', 'value': value}));
  String? sessionGetReverseMouseWheelSync({required UuidValue sessionId, dynamic hint}) =>
      _jsGet('option:session', 'reverse_mouse_wheel');
  Future<void> sessionSetReverseMouseWheel({required UuidValue sessionId, required String value, dynamic hint}) async =>
      _jsSet('option:session', jsonEncode({'name': 'reverse_mouse_wheel', 'value': value}));
  String? sessionGetDisplaysAsIndividualWindows({required UuidValue sessionId, dynamic hint}) =>
      _jsGet('option:session', 'displays_as_individual_windows');
  Future<void> sessionSetDisplaysAsIndividualWindows({required UuidValue sessionId, required String value, dynamic hint}) async {}
  String? sessionGetUseAllMyDisplaysForTheRemoteSession({required UuidValue sessionId, dynamic hint}) => '';
  Future<void> sessionSetUseAllMyDisplaysForTheRemoteSession({required UuidValue sessionId, required String value, dynamic hint}) async {}
  Future<Int32List?> sessionGetCustomImageQuality({required UuidValue sessionId, dynamic hint}) async {
    try {
      final v = _jsGet('option:session', 'custom_image_quality');
      if (v.isEmpty) return null;
      return Int32List.fromList([int.parse(v)]);
    } catch (_) { return null; }
  }
  Future<void> sessionSetCustomImageQuality({required UuidValue sessionId, required int value, dynamic hint}) async =>
      _jsSet('option:session', jsonEncode({'name': 'custom_image_quality', 'value': value}));
  Future<void> sessionSetCustomFps({required UuidValue sessionId, required int fps, dynamic hint}) async =>
      _jsSet('option:session', jsonEncode({'name': 'custom_fps', 'value': fps}));
  bool sessionIsKeyboardModeSupported({required UuidValue sessionId, required String mode, dynamic hint}) =>
      mode == kKeyLegacyMode;
  bool sessionIsMultiUiSession({required UuidValue sessionId, dynamic hint}) => false;
  Future<void> sessionSetSize({required UuidValue sessionId, required int display, required int width, required int height, dynamic hint}) async {}
  Future<void> sessionOnWaitingForImageDialogShow({required UuidValue sessionId, dynamic hint}) async {}
  Future<void> sessionRequestNewDisplayInitMsgs({required UuidValue sessionId, required int display, dynamic hint}) async {}
  int sessionGetRgbaSize({required UuidValue sessionId, required int display, dynamic hint}) => 0;
  void sessionNextRgba({required UuidValue sessionId, required int display, dynamic hint}) {}
  void sessionRegisterPixelbufferTexture({required UuidValue sessionId, required int display, required int ptr, dynamic hint}) {}
  void sessionRegisterGpuTexture({required UuidValue sessionId, required int display, required int ptr, dynamic hint}) {}
  int getNextTextureKey({dynamic hint}) => 0;

  // ---------- clipboard / misc ----------
  bool mainHasFileClipboard({dynamic hint}) => false;
  bool mainHasGpuTextureRender({dynamic hint}) => false;
  bool mainHasHwcodec({dynamic hint}) => false;
  bool mainHasVram({dynamic hint}) => false;
  String mainSupportedHwdecodings({dynamic hint}) => '';
  bool mainGetUseTextureRender({dynamic hint}) => false;
  Future<void> mainCheckHwcodec({dynamic hint}) async {}
  int getDoubleClickTime({dynamic hint}) => 500;
  Future<void> mainCheckMouseTime({dynamic hint}) async {}
  Future<double> mainGetMouseTime({dynamic hint}) async => 0;
  String mainGetInputSource({dynamic hint}) => 'Input source 2';
  Future<void> mainSetInputSource({required UuidValue sessionId, required String value, dynamic hint}) async {}
  void mainInitInputSource({dynamic hint}) {}
  String mainSupportedInputSource({dynamic hint}) => jsonEncode([['Input source 2', 'input_source_2_tip']]);
  String mainGetHardOption({required String key, dynamic hint}) => '';
  String mainGetEnv({required String key, dynamic hint}) => '';
  Future<String> mainGetHomeDir({dynamic hint}) async => '';
  Future<void> mainSetHomeDir({required String home, dynamic hint}) async {}
  String mainGetDataDirIos({dynamic hint}) => '';
  Future<String> mainGetSoftwareUpdateUrl({dynamic hint}) async => '';
  Future<String> mainGetBuildDate({dynamic hint}) async => '';
  String mainGetNewVersion({dynamic hint}) => '';
  bool mainUpdateMe({dynamic hint}) => false;
  bool mainGotoInstall({dynamic hint}) => false;
  bool mainIsInstalled({dynamic hint}) => false;
  bool mainIsInstalledLowerVersion({dynamic hint}) => false;
  bool mainIsInstalledDaemon({required bool prompt, dynamic hint}) => false;
  bool mainIsProcessTrusted({required bool prompt, dynamic hint}) => true;
  bool mainIsCanScreenRecording({required bool prompt, dynamic hint}) => true;
  bool mainIsCanInputMonitoring({required bool prompt, dynamic hint}) => true;
  bool mainIsShareRdp({dynamic hint}) => false;
  Future<void> mainSetShareRdp({required bool enable, dynamic hint}) async {}
  Future<bool> mainIsRoot({dynamic hint}) async => false;
  Future<bool> mainCheckSuperUserPermission({dynamic hint}) async => true;
  Future<void> mainStopService({dynamic hint}) async {}
  Future<void> mainStartService({dynamic hint}) async {}
  Future<void> mainUpdateTemporaryPassword({dynamic hint}) async {}
  Future<void> mainSetPermanentPassword({required String password, dynamic hint}) async {}
  Future<String> mainGetTemporaryPassword({dynamic hint}) async => '';
  Future<String> mainGetPermanentPassword({dynamic hint}) async => '';
  Future<String> mainGetFingerprint({dynamic hint}) async => '';
  bool mainCurrentIsWayland({dynamic hint}) => false;
  bool mainIsLoginWayland({dynamic hint}) => false;
  bool mainHideDocker({dynamic hint}) => false;
  Future<void> mainWol({required String id, dynamic hint}) async {}
  Future<void> mainCreateShortcut({required String id, dynamic hint}) async {}
  Future<void> sendUrlScheme({required String url, dynamic hint}) async {}
  Future<String> mainGetAppName({dynamic hint}) async => 'RustDesk';
  String mainGetAppNameSync({dynamic hint}) => 'RustDesk';
  String mainUriPrefixSync({dynamic hint}) => 'rustdesk://';
  Future<String> mainGetLicense({dynamic hint}) async => '';
  Future<String> mainGetLangs({dynamic hint}) async => '';
  Future<List<String>> mainGetSoundInputs({dynamic hint}) async => [];
  Future<String?> mainGetDefaultSoundInput({dynamic hint}) async => null;
  Future<void> mainSetSocks({required String proxy, required String username, required String password, dynamic hint}) async {}
  Future<List<String>> mainGetSocks({dynamic hint}) async => [];
  Future<bool> mainGetProxyStatus({dynamic hint}) async => false;
  Future<void> mainPostRequest({required String url, required String body, required String header, dynamic hint}) async {}
  Future<void> mainHttpRequest({required String url, required String method, String? body, required String header, dynamic hint}) async {}
  Future<String?> mainGetHttpStatus({required String url, dynamic hint}) async => null;
  Future<String> mainGenerate2Fa({dynamic hint}) async => '';
  Future<bool> mainVerify2Fa({required String code, dynamic hint}) async => false;
  bool mainHasValid2FaSync({dynamic hint}) => false;
  String mainDefaultPrivacyModeImpl({dynamic hint}) => '';
  String mainSupportedPrivacyModeImpls({dynamic hint}) => '[]';
  String mainGetMainDisplay({dynamic hint}) => _jsGet('main_display');
  String mainGetDisplays({dynamic hint}) => '';
  String mainGetNewStoredPeersSync({dynamic hint}) => '';
  Future<bool> isPresetPassword({dynamic hint}) async => false;
  bool isSelinuxEnforcing({dynamic hint}) => false;
  bool isIncomingOnly({dynamic hint}) => false;
  bool isOutgoingOnly({dynamic hint}) => false;
  bool isCustomClient({dynamic hint}) => false;
  bool isDisableSettings({dynamic hint}) => false;
  bool isDisableAb({dynamic hint}) => false;
  bool isDisableGroupPanel({dynamic hint}) => false;
  bool isDisableAccount({dynamic hint}) => false;
  bool isDisableInstallation({dynamic hint}) => false;
  bool isSupportMultiUiSession({required String version, dynamic hint}) => false;
  Future<void> mainTestWallpaper({required int second, dynamic hint}) async {}
  Future<bool> mainSupportRemoveWallpaper({dynamic hint}) async => false;
  Future<String> mainHandleWaylandScreencastRestoreToken({required String key, required String value, dynamic hint}) async => '';
  Future<String> mainGetError({dynamic hint}) async => '';
  String mainVideoSaveDirectory({required bool root, dynamic hint}) => '';

  // ---------- file transfer / port forward / rdp（Web 暂不支持，安全空实现） ----------
  Future<void> sessionReadRemoteDir({required UuidValue sessionId, required String path, required bool includeHidden, dynamic hint}) async {}
  Future<void> sessionSendFiles({required UuidValue sessionId, required int actId, required String path, required String to, required int fileNum, required bool includeHidden, required bool isRemote, dynamic hint}) async {}
  Future<void> sessionSetConfirmOverrideFile({required UuidValue sessionId, required int actId, required int fileNum, required bool needOverride, required bool remember, required bool isUpload, dynamic hint}) async {}
  Future<void> sessionRemoveFile({required UuidValue sessionId, required int actId, required String path, required int fileNum, required bool isRemote, dynamic hint}) async {}
  Future<void> sessionReadDirRecursive({required UuidValue sessionId, required int actId, required String path, required bool isRemote, required bool showHidden, dynamic hint}) async {}
  Future<void> sessionRemoveAllEmptyDirs({required UuidValue sessionId, required int actId, required String path, required bool isRemote, dynamic hint}) async {}
  Future<void> sessionCancelJob({required UuidValue sessionId, required int actId, dynamic hint}) async {}
  Future<void> sessionCreateDir({required UuidValue sessionId, required int actId, required String path, required bool isRemote, dynamic hint}) async {}
  Future<String> sessionReadLocalDirSync({required UuidValue sessionId, required String path, required bool showHidden, dynamic hint}) async => '';
  Future<String> sessionGetPlatform({required UuidValue sessionId, required bool isRemote, dynamic hint}) async => '';
  Future<void> sessionLoadLastTransferJobs({required UuidValue sessionId, dynamic hint}) async {}
  Future<void> sessionAddJob({required UuidValue sessionId, required int actId, required String path, required String to, required int fileNum, required bool includeHidden, required bool isRemote, dynamic hint}) async {}
  Future<void> sessionResumeJob({required UuidValue sessionId, required int actId, required bool isRemote, dynamic hint}) async {}
  Future<void> sessionAddPortForward({required UuidValue sessionId, required int localPort, required String remoteHost, required int remotePort, dynamic hint}) async {}
  Future<void> sessionRemovePortForward({required UuidValue sessionId, required int localPort, dynamic hint}) async {}
  Future<void> sessionNewRdp({required UuidValue sessionId, dynamic hint}) async {}
  Future<void> sessionRequestVoiceCall({required UuidValue sessionId, dynamic hint}) async {}
  Future<void> sessionCloseVoiceCall({required UuidValue sessionId, dynamic hint}) async {}
  Future<void> cmHandleIncomingVoiceCall({required int id, required bool accept, dynamic hint}) async {}
  Future<void> cmCloseVoiceCall({required int id, dynamic hint}) async {}
  Future<void> sessionElevateDirect({required UuidValue sessionId, dynamic hint}) async {}
  Future<void> sessionElevateWithLogon({required UuidValue sessionId, required String username, required String password, dynamic hint}) async {}
  Future<void> sessionSwitchSides({required UuidValue sessionId, dynamic hint}) async {}
  Future<void> sessionChangeResolution({required UuidValue sessionId, required int display, required int width, required int height, dynamic hint}) async {}
  Future<void> sessionSendSelectedSessionId({required UuidValue sessionId, required String sid, dynamic hint}) async {}
  Future<void> sessionHandleFlutterKeyEvent({required UuidValue sessionId, required String name, required int platformCode, required int positionCode, required int lockModes, required bool downOrUp, dynamic hint}) async {}
  void sessionEnterOrLeave({required UuidValue sessionId, required bool enter, dynamic hint}) {}
  Future<void> sessionSendChat({required UuidValue sessionId, required String text, dynamic hint}) async {}
  Future<void> setCurSessionId({required UuidValue sessionId, dynamic hint}) async {}
  Future<void> sessionToggleVirtualDisplay({required UuidValue sessionId, required int index, required bool on, dynamic hint}) async {}
  Future<void> sessionRecordScreen({required UuidValue sessionId, required bool start, required int display, required int width, required int height, dynamic hint}) async {}
  Future<void> sessionRecordStatus({required UuidValue sessionId, required bool status, dynamic hint}) async {}

  // ---------- cm (connection manager) ----------
  Future<String> cmGetClientsState({dynamic hint}) async => '[]';
  Future<String?> cmCheckClientsLength({required int length, dynamic hint}) async => null;
  Future<int> cmGetClientsLength({dynamic hint}) async => 0;
  Future<void> cmSendChat({required int connId, required String msg, dynamic hint}) async {}
  Future<void> cmLoginRes({required int connId, required bool res, dynamic hint}) async {}
  Future<void> cmCloseConnection({required int connId, dynamic hint}) async {}
  Future<void> cmRemoveDisconnectedConnection({required int connId, dynamic hint}) async {}
  Future<void> cmCheckClickTime({required int connId, dynamic hint}) async {}
  Future<double> cmGetClickTime({dynamic hint}) async => 0;
  Future<void> cmSwitchPermission({required int connId, required String name, required bool enabled, dynamic hint}) async {}
  bool cmCanElevate({dynamic hint}) => false;
  Future<void> cmElevatePortable({required int connId, dynamic hint}) async {}
  Future<void> cmSwitchBack({required int connId, dynamic hint}) async {}
  Future<String> cmGetConfig({required String name, dynamic hint}) async => '';
  Future<void> cmInit({dynamic hint}) async {}

  // ---------- install / plugin ----------
  bool installShowRunWithoutInstall({dynamic hint}) => false;
  Future<void> installRunWithoutInstall({dynamic hint}) async {}
  Future<void> installInstallMe({required String options, required String path, dynamic hint}) async {}
  String installInstallPath({dynamic hint}) => '';
  Future<void> pluginEvent({required String id, required String peer, required Uint8List event, dynamic hint}) async {}
  Stream<EventToUI> pluginRegisterEventStream({required String id, dynamic hint}) => const Stream.empty();
  String? pluginGetSessionOption({required String id, required String peer, required String key, dynamic hint}) => null;
  Future<void> pluginSetSessionOption({required String id, required String peer, required String key, required String value, dynamic hint}) async {}
  String? pluginGetSharedOption({required String id, required String key, dynamic hint}) => null;
  Future<void> pluginSetSharedOption({required String id, required String key, required String value, dynamic hint}) async {}
  Future<void> pluginReload({required String id, dynamic hint}) async {}
  void pluginEnable({required String id, required bool v, dynamic hint}) {}
  bool pluginIsEnabled({required String id, dynamic hint}) => false;
  bool pluginFeatureIsEnabled({dynamic hint}) => false;
  Future<void> pluginSyncUi({required String syncTo, dynamic hint}) async {}
  Future<void> pluginListReload({dynamic hint}) async {}
  Future<void> pluginInstall({required String id, required bool b, dynamic hint}) async {}
}