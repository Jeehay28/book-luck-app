import 'dart:async';

import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/model/countdown_status.dart';

import '../services/networking.dart';
import '../utils/api_endpoints.dart';

class MinutesProvider extends ChangeNotifier {
  MinutesProvider() {
    _init();
  }

  Future<void> _init() async {
    await loadInitialReadTime('1');
  }

  Timer? _timer;

  // ================= internal state =================
  bool _isInitialized = false;
  int _seconds = 0;
  int _previous = 0;

  bool _isGoalAchieved = false;
  CountdownStatus _status = CountdownStatus.stopped;

  // ================= getters =================
  int get seconds => _seconds;
  int get minutes => (_seconds % 3600) ~/ 60;
  CountdownStatus get status => _status;
  bool get isGoalAchieved => _isGoalAchieved;

  String get formattedTime {
    final h = (_seconds ~/ 3600).toString().padLeft(2, '0');
    final m = ((_seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  /// ⭐ 버튼에 표시될 텍스트
  String get buttonText {
    switch (_status) {
      case CountdownStatus.stopped:
        return '독서 시작하기';
      case CountdownStatus.started:
      case CountdownStatus.paused:
        return formattedTime;
    }
  }

  // ==================================================
  // ================= API FUNCTIONS ==================
  // ==================================================

  // ================= API 호출 함수들 =================

  Future<void> _notifyReadingStart(String userId) async {
    try {
      final helper = NetworkHelper(ApiEndpoints.resumeReading, body: {
        'userId': userId,
      });
      await helper.postData();
    } catch (e) {
      debugPrint('Start reading API error: $e');
    }
  }

  Future<void> _notifyReadingPause(String userId) async {
    try {
      final helper = NetworkHelper(ApiEndpoints.pauseReading, body: {
        'userId': userId,
      });
      await helper.postData();
    } catch (e) {
      debugPrint('Pause reading API error: $e');
    }
  }

  Future<void> _notifyReadingStop(String userId) async {
    try {
      final helper = NetworkHelper(ApiEndpoints.stopReading, body: {
        'userId': userId,
      });
      await helper.postData();
    } catch (e) {
      debugPrint('Stop reading API error: $e');
    }
  }

  Future<void> loadInitialReadTime(String userId) async {
    try {
      if (_isInitialized) return; // 👈 이미 불렀으면 무시

      _isInitialized = true;

      final networkHelper = NetworkHelper(ApiEndpoints.getReadTime(userId));

      final result = await networkHelper.getData();

      if (result != null && result['accumulatedDuration'] != null) {
        final serverSeconds = result['accumulatedDuration'] as int;

        _seconds = serverSeconds;
        _previous = serverSeconds;
        _status = CountdownStatus.paused;
        _isInitialized = true;

        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to load initial read time: $e');
    }
  }

  // ==================================================
  // ================= TIMER LOGIC ====================
  // ==================================================

  // ================= start =================
  Future<void> startCountdown({required String userId}) async {
    if (_status == CountdownStatus.started) return;

    _timer?.cancel();

    if (!_isInitialized) {
      // 서버에서 아직 안 받아온 상태
      _seconds = 0;
      _previous = 0;
    } else {
      // 서버 기준으로 복원
      _seconds = _previous;
    }
    _isGoalAchieved = false;
    _status = CountdownStatus.started;

    notifyListeners(); // UI 즉시 반영

    await _notifyReadingStart(userId); // 🔥 서버 알림

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _seconds++;

      if (_seconds >= 3600) {
        _isGoalAchieved = true;
        stopCountdown(userId: userId);
        return;
      }

      notifyListeners();
    });
  }

  // ================= pause =================
  Future<void> pauseCountdown({required String userId}) async {
    if (_status != CountdownStatus.started) return;

    _timer?.cancel();
    _previous = _seconds;
    _status = CountdownStatus.paused;

    await _notifyReadingPause(userId); // 🔥 서버 알림

    notifyListeners();
  }

  // ================= stop =================
  Future<void> stopCountdown({required String userId}) async {
    _timer?.cancel();
    _previous = 0;
    _seconds = 0;
    _status = CountdownStatus.stopped;

    await _notifyReadingStop(userId); // 🔥 서버 알림

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
