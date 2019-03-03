# Local Notifications in Swift
_Расшерение для добавления локальных уведомлений в проект_

Для добавления локальных уведомлений с кастомными текстовыми сообщениями необходимо:

1. В файле AppDelegate импортировать библиотеку локальных уведомлений

```swift
import UserNotification
```

2. Добавить расширение для класса AppDelegate
```swift
extension AppDelegate: UNUserNotificationCenterDelegate {

  private func setupLocalNotifications() {
    let localNotificationCenter = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.badge, .alert]
    localNotificationCenter.requestAuthorization(options: options) { (didAllow, error) in
      if !didAllow {
        print("⚠️ User has declined notifications")
      }
    }
    localNotificationCenter.delegate = self
  }
  
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
    let options: UNNotificationPresentationOptions = [.alert]
    completionHandler(options)
  }
}
```
