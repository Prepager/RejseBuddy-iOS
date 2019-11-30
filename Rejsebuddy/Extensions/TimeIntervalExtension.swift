import Foundation

extension TimeInterval {
    /**
     Pretty print the time interval
     */
    func prettyPrint() -> String {
        // Define holder variable.
        var temp = Int(self)
        
        // Calculate total hours.
        let hours = Int(temp / 3600)
        temp -= hours * 3600
        
        // Calculate total minutes.
        let minutes = Int(temp / 60)
        temp -= minutes * 60
        
        // Return hours and minutes.
        return String(format: "%02d:%02d", hours, minutes)
    }
}
