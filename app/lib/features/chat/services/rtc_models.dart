/// RTC 信令消息模型
/// 与 Go rtc-service 信令协议对齐
library;

// ============ 通话状态枚举 ============

enum CallState {
  idle,
  ringingOut,
  ringingIn,
  connecting,
  connected,
  ended,
}

enum MediaType {
  audio,
  video,
}

enum CallMode {
  p2p,
  sfu,
}

// ============ 通话信息 ============

class CurrentCall {
  final String callId;
  final String peerId;
  final String peerName;
  final String? peerAvatar;
  final MediaType mediaType;
  CallMode mode;
  DateTime? startTime;

  CurrentCall({
    required this.callId,
    required this.peerId,
    required this.peerName,
    this.peerAvatar,
    required this.mediaType,
    this.mode = CallMode.p2p,
    this.startTime,
  });
}

// ============ 通用信令消息 ============

class RtcMessage {
  final String type;
  final Map<String, dynamic>? data;

  RtcMessage({required this.type, this.data});

  factory RtcMessage.fromJson(Map<String, dynamic> json) {
    return RtcMessage(
      type: json['type'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        if (data != null) 'data': data,
      };
}

// ============ 客户端消息数据 ============

class InviteData {
  final String callId;
  final String targetUserId;
  final String mediaType;
  final String sdp;

  InviteData({
    required this.callId,
    required this.targetUserId,
    required this.mediaType,
    required this.sdp,
  });

  Map<String, dynamic> toJson() => {
        'callId': callId,
        'targetUserId': targetUserId,
        'mediaType': mediaType,
        'sdp': sdp,
      };
}

class AnswerData {
  final String callId;
  final String sdp;

  AnswerData({required this.callId, required this.sdp});

  factory AnswerData.fromJson(Map<String, dynamic> json) {
    return AnswerData(
      callId: json['callId'] as String? ?? '',
      sdp: json['sdp'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'callId': callId, 'sdp': sdp};
}

class ICEData {
  final String callId;
  final String candidate;

  ICEData({required this.callId, required this.candidate});

  factory ICEData.fromJson(Map<String, dynamic> json) {
    return ICEData(
      callId: json['callId'] as String? ?? '',
      candidate: json['candidate'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'callId': callId, 'candidate': candidate};
}

class CallControlData {
  final String callId;
  final String? reason;

  CallControlData({required this.callId, this.reason});

  factory CallControlData.fromJson(Map<String, dynamic> json) {
    return CallControlData(
      callId: json['callId'] as String? ?? '',
      reason: json['reason'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'callId': callId,
        if (reason != null) 'reason': reason,
      };
}

// ============ 服务端消息数据 ============

class IncomingCallData {
  final String callId;
  final String callerUserId;
  final String callerName;
  final String? callerAvatar;
  final String mediaType;
  final String sdp;

  IncomingCallData({
    required this.callId,
    required this.callerUserId,
    required this.callerName,
    this.callerAvatar,
    required this.mediaType,
    required this.sdp,
  });

  factory IncomingCallData.fromJson(Map<String, dynamic> json) {
    return IncomingCallData(
      callId: json['callId'] as String? ?? '',
      callerUserId: json['callerUserId'] as String? ?? '',
      callerName: json['callerName'] as String? ?? '',
      callerAvatar: json['callerAvatar'] as String?,
      mediaType: json['mediaType'] as String? ?? 'audio',
      sdp: json['sdp'] as String? ?? '',
    );
  }
}

class CallEndedData {
  final String callId;
  final String reason;

  CallEndedData({required this.callId, required this.reason});

  factory CallEndedData.fromJson(Map<String, dynamic> json) {
    return CallEndedData(
      callId: json['callId'] as String? ?? '',
      reason: json['reason'] as String? ?? 'unknown',
    );
  }
}

class SFUFallbackData {
  final String callId;
  final String livekitUrl;
  final String token;

  SFUFallbackData({
    required this.callId,
    required this.livekitUrl,
    required this.token,
  });

  factory SFUFallbackData.fromJson(Map<String, dynamic> json) {
    return SFUFallbackData(
      callId: json['callId'] as String? ?? '',
      livekitUrl: json['livekitUrl'] as String? ?? '',
      token: json['token'] as String? ?? '',
    );
  }
}

class TURNConfigData {
  final List<String> urls;
  final String username;
  final String credential;

  TURNConfigData({
    required this.urls,
    required this.username,
    required this.credential,
  });

  factory TURNConfigData.fromJson(Map<String, dynamic> json) {
    return TURNConfigData(
      urls: (json['urls'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      username: json['username'] as String? ?? '',
      credential: json['credential'] as String? ?? '',
    );
  }
}

class RtcErrorData {
  final int code;
  final String message;

  RtcErrorData({required this.code, required this.message});

  factory RtcErrorData.fromJson(Map<String, dynamic> json) {
    return RtcErrorData(
      code: json['code'] as int? ?? 0,
      message: json['message'] as String? ?? '',
    );
  }
}
