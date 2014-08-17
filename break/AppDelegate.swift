//
//  AppDelegate.swift
//  break
//
//  Created by stormhouse on 14-8-15.
//  Copyright (c) 2014 stormhouse. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    let intervel = "50:00"
    var intervelSleep = 300
    var breaker: Int = 300
    var timer:NSTimer?
    var sleeper:NSTimer?
                            
    @IBOutlet var window: NSWindow
    @IBOutlet var timerLabel : NSTextField
    
    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var menu: NSMenu = NSMenu()
    var menuItem : NSMenuItem = NSMenuItem()
    
    override func awakeFromNib() {
        self.wakeup()
//        statusItem: NSStatusItem =statusBar.statusItemWithLength(CGFloat(NSVariableStatusItemLength))
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.title = ""
        statusBarItem.menu = menu
        statusBarItem.highlightMode = true
        
        //Add menuItem to menu
        menuItem.title = "Preference"
        menuItem.action = Selector("setWindowVisible")
        menuItem.keyEquivalent = ""
//        menuItem.state = 1
        menu.addItem(menuItem)
        
        menu.addItem(NSMenuItem.separatorItem())
        var restartItem = NSMenuItem()
        restartItem.title = "Restart"
        restartItem.keyEquivalent = "s"

        
        var postponeItem = NSMenuItem()
        postponeItem.title = "Postpone"
        postponeItem.keyEquivalent = "p"
        menu.addItem(restartItem)
        menu.addItem(postponeItem)
        
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItemWithTitle("About", action: Selector("orderFrontStandardAboutPanel:"), keyEquivalent: "")
        menu.addItemWithTitle("Quit", action: Selector("terminate:"), keyEquivalent: "")
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        self.window!.orderOut(self)
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }

    func setWindowVisible(){
        self.window!.orderFront(self)
    }
    func sleep(){
        self.sleeper = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("sleepToggle"), userInfo: nil, repeats: true)
    }
    func wakeup(){
        self.timerLabel.stringValue = intervel
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    func sleepToggle(){
        if(self.breaker%2 == 0){
            self.statusBarItem.title = "time out"
        }else{
            self.statusBarItem.title = " "
        }
        if(self.breaker == 0){
            breaker = intervelSleep
            self.sleeper!.invalidate()
            self.wakeup()
        }
        breaker = breaker-1
        
    }
    func update(){
        var text:String = timerLabel.stringValue as String
        var mmss = text.componentsSeparatedByString(":")
        var mm:Int? = mmss[0].toInt()
        var ss:Int? = (mmss[1].toInt()!-1)
        if(mm==0 && ss==0){
            self.timer!.invalidate()
            self.statusBarItem.title = "time out"
            self.sleep()
            return
        }
        
        if(ss == -1){
            ss = 59
            mm = mm!-1
        }
        var mStr:String? = String(mm!)
        var sStr:String? = String(ss!)
        if(mm<10){
            mStr = "0"+String(mm!)
        }
        if(ss<10){
            sStr = "0"+String(ss!)
        }
        var lastResult = mStr!+":"+sStr!
        statusBarItem.title = lastResult
        timerLabel.stringValue = lastResult
    }

}

