//
//  CanSendLocalNotifications.swift
//
//  Created by MisnikovRoman on 03/03/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UserNotifications

//  Для добавления локальных уведомлений с кастомными текстовыми сообщениями
//  необходимо:
//
//  (1/2) В файле AppDelegate импортировать библиотеку локальных уведомлений
//
//  import UserNotification
//
//  (2/2) Добавить расширения для класса AppDelegate
//
//	extension AppDelegate: UNUserNotificationCenterDelegate {
//		private func setupLocalNotifications() {
//			let localNotificationCenter = UNUserNotificationCenter.current()
//			let options: UNAuthorizationOptions = [.badge, .alert]
//			localNotificationCenter.requestAuthorization(options: options) { (didAllow, error) in
//				if !didAllow {
//					print("⚠️ User has declined notifications")
//				}
//			}
//			localNotificationCenter.delegate = self
//		}
//
//		func userNotificationCenter(
//			_ center: UNUserNotificationCenter,
//			willPresent notification: UNNotification,
//			withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
//			) {
//			let options: UNNotificationPresentationOptions = [.alert]
//			completionHandler(options)
//		}
//	}

protocol CanSendLocalNotifications {
	func notify(with: String)
}

extension CanSendLocalNotifications {
	func notify(with text: String) {
		// изменяемый контейнер данных для уведомления
		let content = UNMutableNotificationContent()
		content.title = "⚠️ Отладочное сообщение"
		content.body = text

		// триггер, которому сработает уведомление (время, календарь, геопозиция)
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)

		// запрос в систему на показ уведомления
		let notificationRequest = UNNotificationRequest(identifier: "debugNotification", content: content, trigger: trigger)

		// объект центра уведомления
		let notificationCenter = UNUserNotificationCenter.current()

		// проверка разрешения на показ уведомлений
		notificationCenter.getNotificationSettings { (settings) in
			if settings.authorizationStatus != .authorized {
				// Notifications not allowed
				assertionFailure("Ошибка показа уведомлений")
			}
		}

		// добавление уведомления в центр уведомлений
		notificationCenter.add(notificationRequest) { (error) in
			if error != nil {
				print("❌ Ошибка показа уведомлений: \(error!.localizedDescription)")
				assertionFailure("Ошибка показа уведомлений")
			}
		}
	}
}
