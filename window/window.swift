import Cocoa

public class Window {
    var window: NSWindow?
    
    public static func create(width: CInt, height: CInt) -> Window {
        let w = Window();
        let contentRect = NSMakeRect(0, 0, CGFloat(width), CGFloat(height))
        w.window = NSWindow(contentRect: contentRect, 
                          styleMask: [.titled, .closable, .miniaturizable, .resizable], 
                          backing: .buffered, 
                          defer: false)
        w.window?.center()
        w.window?.title = "My Swift Window"
        
        let viewController = NSViewController()
        viewController.view = NSView(frame: contentRect)
        // Customize your viewController's view or set up additional UI elements here
        
        w.window?.contentViewController = viewController
        return w
    }
    
    public func show() {
        window?.makeKeyAndOrderFront(nil)
    }
}
