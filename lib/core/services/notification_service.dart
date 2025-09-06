import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared/shared.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

/// A singleton service that handles push notifications using Firebase Cloud Messaging (FCM)
/// and local notifications via FlutterLocalNotificationsPlugin.
///
/// This service initializes timezone settings, sets up FCM and local notification
/// configurations, requests notification permissions, and listens for incoming messages.
class NotificationService {
  // Singleton instance of NotificationService
  static final NotificationService _instance = NotificationService._internal();

  /// Factory constructor to return the singleton instance of NotificationService.
  factory NotificationService() => _instance;

  /// Private named constructor to prevent external instantiation.
  NotificationService._internal();

  // Notification channel ID for Android
  static const String _channelId = 'card_pay_channel';

  // Channel name displayed in Android notification settings
  static const String _channelName = 'Card Pay Notifications';

  // Channel description displayed in Android notification settings
  static const String _channelDescription =
      'Notifications for financial transactions';

  // Firebase Messaging instance to handle push notifications
  late FirebaseMessaging _firebaseMessaging;

  // Flutter plugin for showing local notifications
  late FlutterLocalNotificationsPlugin _localNotifications;

  // Android-specific notification details
  late AndroidNotificationDetails _androidPlatformChannelSpecifics;

  // iOS-specific notification details
  late DarwinNotificationDetails _iosPlatformChannelSpecifics;

  // UUID generator instance for creating unique identifiers for notifications
  final Uuid _uuid = const Uuid();

  /// Initializes the notification service:
  /// - Sets up the local timezone.
  /// - Initializes Firebase Cloud Messaging.
  /// - Configures the local notification plugin.
  /// - Sets up the notification tap (interaction) handler.
  /// - Requests necessary permissions for showing notifications.
  /// - Creates notification channels for Android.
  /// - Begins listening for incoming messages.
  Future<void> initialize() async {
    // await _setupTimezone();
    await _initializeFirebase();
    await _initializeLocalNotifications();
    await _setupInteractedMessage();
    await _requestPermissions();
    await _createNotificationChannels();
    _listenToMessages();
  }

  /// Configures the local timezone for scheduling notifications properly.
  ///
  /// Uses the `timezone` and `flutter_native_timezone` packages to detect and set
  /// the user's local timezone.
  // Future<void> _setupTimezone() async {
  //   tz.initializeTimeZones();
  //   final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  //   tz.setLocalLocation(tz.getLocation(timeZoneName));
  // }

  /// Initializes Firebase Messaging and configures foreground notification behavior.
  ///
  /// Also obtains the current device token and triggers token refresh handling logic.
  Future<void> _initializeFirebase() async {
    _firebaseMessaging = FirebaseMessaging.instance;

    // Configure how notifications behave when the app is in the foreground
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Show alert
      badge: true, // Update app badge
      sound: true, // Play sound
    );

    // Obtain and manage the FCM token
    await _handleTokenRefresh();
  }

  // TODO:
  // - Implement `_initializeLocalNotifications` to set up `FlutterLocalNotificationsPlugin`.
  // - Implement `_setupInteractedMessage` to handle taps on notifications.
  // - Implement `_requestPermissions` for requesting notification permissions.
  // - Implement `_createNotificationChannels` for creating Android notification channels.
  // - Implement `_listenToMessages` to listen and handle incoming messages.
  // - Implement `_handleTokenRefresh` to manage FCM token lifecycle.
  Future<void> _initializeLocalNotifications() async {
    _localNotifications = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        details.payload;
      },
    );
  }

  Future<void> _createNotificationChannels() async {
    _androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: BigTextStyleInformation(''),
      playSound: true, // This alone plays the default system sound
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 250, 250, 250]),
    );

    _iosPlatformChannelSpecifics = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'notification.aiff',
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          AndroidNotificationChannel(
            _channelId,
            _channelName,
            description: _channelDescription,
            importance: Importance.max,
          ),
        );
  }

  Future<void> _requestPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logD('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      logD('User granted provisional permission');
    } else {
      logD('User declined or has not accepted permission');
    }
  }

  Future<void> _handleTokenRefresh() async {
    try {
      _firebaseMessaging.onTokenRefresh.listen((newToken) async {
        logD('FCM Token refreshed: $newToken');
        await _sendTokenToServer(newToken);
      });

      final token = await _firebaseMessaging.getToken();
      if (token != null) {
        logD('Initial FCM Token: $token');
        await _sendTokenToServer(token);
      }
    } catch (e, stackTrace) {
      logE(e, stackTrace: stackTrace);
    }
  }

  Future<void> _sendTokenToServer(String token) async {
    // Implement your API call to send the token to your backend
    // Example:
    // await ApiService().updatePushToken(token);
    logD('Token sent to server: $token');

    try {
      final response = await serviceLocator<AuthClient>().request(
        method: 'POST',
        path: 'core/push-token/update_token/',
        body: jsonEncode({"push_token": token}),
      );
      if (response.statusCode != 201) {
        logE("Error updating push token ${response.body}");
      }
    } catch (e, stackTrace) {
      logE("Error updating push token $e", stackTrace: stackTrace);
    }
  }

  void _listenToMessages() {
    FirebaseMessaging.onMessage.listen(_showLocalNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_onNotificationTap);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _setupInteractedMessage() async {
    RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    // Handle background messages
    await NotificationService()._showLocalNotification(message);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    // final android = message.notification?.android;

    if (notification != null) {
      final platformChannelSpecifics = NotificationDetails(
        android: _androidPlatformChannelSpecifics,
        iOS: _iosPlatformChannelSpecifics,
      );

      await _localNotifications.show(
        _uuid.v1().hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: message.data['route'],
      );
    }
  }

  Future<void> _onNotificationTap(RemoteMessage response) async {
    // Handle notification tap
    // Navigate to specific route
    // Example: Navigator.pushNamed(context, response.payload!);
    logD('Notification tapped with payload: ${response.data}');
  }

  void _handleMessage(RemoteMessage message) {
    // Handle message data
    logD('Message data: ${message.data}');

    if (message.data['type'] == 'transaction') {
      // Handle transaction-specific logic
    }
  }
}
