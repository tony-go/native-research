import Cocoa

import Ui

public class AppDelegate: NSObject, NSApplicationDelegate {
    private var window: Window?

    public func setWindow(_ window: Window) {
        self.window = window
    }

    public func applicationDidFinishLaunching(_ aNotification: Notification) {
        window?.show()
    }
}

public class Application {
    public static func create() -> Application {
        return Application()
    }

    public func run() {
        let app = NSApplication.shared
        let delegate = AppDelegate()
        app.delegate = delegate
        app.run()
    }

    public func setWindow(_ window: Window) {
        let delegate = NSApplication.shared.delegate as! AppDelegate
        delegate.setWindow(window)
    }
}

