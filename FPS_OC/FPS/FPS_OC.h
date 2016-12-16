//
//  FPS_OC.h
//  Clode
//
//  Created by 薛林 on 16/12/16.
//  Copyright © 2016年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FPS_OC : NSObject

@property (nonatomic,strong)UILabel *fpsLabel;
@property (nonatomic, strong) UIView *toolbar;

+ (FPS_OC *)sharedFps;

- (void)start;
- (void)invalid;

@end
