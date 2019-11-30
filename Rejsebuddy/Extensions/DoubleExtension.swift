import Foundation

extension Double {
    /**
     Get whole number of double as string.
     */
    var clean: String {
        return String(format: "%.0f", self)
    }
}
