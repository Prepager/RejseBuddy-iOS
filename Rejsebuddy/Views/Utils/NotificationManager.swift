import Foundation
import UserNotifications

class NotificationManager {
    
    /**
     Request permission to show notifications.
     */
    func request(completion: @escaping () -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { (granted, error) in
            if granted && error == nil {
                completion()
            }
        }
    }
    
    /**
     Remove all pending notifications.
     */
    func removeAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    /**
     Schedule a new notification.
     */
    func schedule(id: String, title: String, text: String, date: Date) {
        // Define the notification content.
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = text
        content.sound = .default
        
        // Define trigger based on passed date.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([
                .year, .month, .day, .hour, .minute, .second
            ], from: date),
            
            repeats: false
        )
        
        // Create request for content with trigger.
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        // Attempt to add the defined notification to the schedule.
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                dump(error)
            } else {
                print("Scheduled: " + id)
            }
        }
    }
    
}
