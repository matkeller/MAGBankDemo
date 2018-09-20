//
//  AppDelegate.swift
//  MAGBankDemo
//
//  Created by Matthew Keller on 9/19/18.
//  Copyright © 2018 Matthew Keller. All rights reserved.
//

import UIKit
import MASFoundation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
                if MASUser.current() != nil && (MASUser.current()?.isAuthenticated)! {
                    MASUser.current()?.lockSession(completion: { (completed, error) in
                        if completed == true {
                            // session lock successful
                            print ("Session locked")
                        }
                        else {
                            // session lock error
                            print ("Session NOT locked, but requested")
                        }
                    })
                } else {
                    print ("Session NOT locked, possibly not authenticated.")
                }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if MASUser.current() != nil && (MASUser.current()?.isSessionLocked)! {
            
            // Unlock the session with operation prompt message
            // (optionally, also can be unlocked without the message)
            MASUser.current()?.unlockSession(completion: { (completed, error) in
                if completed {
                    // session unlock successful
                    print ("Session unlock was successful")
                }
                else {
                    // session unlock failure
                    print ("Session unlock was NOT successful")
                }
            })
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

