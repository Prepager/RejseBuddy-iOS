import UIKit
import SwiftUI
import Foundation

class Keyboard: ObservableObject {
    
    var view: UIWindow?
    let tabBarHeight: CGFloat = 49.0
    
    var duration: CGFloat = 0
    var hasTabbar: Bool = true
    
    @Published var height: CGFloat = 0
    
    /**
     Adds keyboard observers.
     */
    init(hasTabbar: Bool = true) {
        // Save settings.
        self.hasTabbar = hasTabbar
        
        // Get the current application window.
        self.view = UIApplication.shared.windows.first { $0.isKeyWindow }
        
        // Add keyboard will show observer.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        // Add keyboard will hide observer.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    /**
     Removes keyboard observers.
     */
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /**
     Saves the keyboard height on show.
     */
    @objc func onShow(notification: Notification) {
        // Get keyboard and safe area instances.
        let keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let safeArea = self.view?.safeAreaInsets
        
        // Save the keyboard animation duration.
        self.duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! CGFloat
        
        // Save and animate height if found.
        if (keyboard?.height != nil) {
            withAnimation(.easeInOut(duration: Double(self.duration))) {
                self.height = keyboard!.height - (safeArea?.bottom ?? 0) - (
                    self.hasTabbar ? self.tabBarHeight : 0
                )
            }
        }
    }
    
    /**
     Resets the keyboard height on hide.
     */
    @objc func onHide() {
        withAnimation(.easeInOut(duration: Double(self.duration))) {
            self.height = 0
        }
    }
    
}
