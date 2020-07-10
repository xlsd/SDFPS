//
//  AppDelegate.m
//  FPS_OC
//
//  Created by 薛林 on 16/12/16.
//  Copyright © 2016年 YunTianXia. All rights reserved.
//

#import "AppDelegate.h"
#import "FPSController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[FPSController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
