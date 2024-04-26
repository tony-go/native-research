import Cocoa
import Application

public class AppDelegate: NSObject, NSApplicationDelegate {
    public var window: NSWindow?

    public override init() {
        super.init()
        let rect = NSMakeRect(0, 0, 480, 300)
        window = NSWindow(contentRect: rect, styleMask: [.titled, .closable, .resizable], backing: .buffered, defer: false)
        window?.contentViewController = ViewController()
    }

    public func applicationDidFinishLaunching(_ aNotification: Notification) {
        window?.makeKeyAndOrderFront(nil)
    }
}

public class ViewController: NSViewController {
    public override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 480, 300))
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.red.cgColor
    }
}

class App: Application {
    public func run() {
        let app = NSApplication.shared
        let delegate = AppDelegate()
        app.delegate = delegate
        app.run()
    }
}

