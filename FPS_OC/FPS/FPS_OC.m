//
//  FPS_OC.m
//  JPFPSStatus
//
//  Created by 薛林 on 16/12/16.
//  Copyright © 2016年 coderyi. All rights reserved.
//

#import "FPS_OC.h"

@interface FPS_OC (){
    CADisplayLink *displayLink;
    NSTimeInterval lastTime;
    NSUInteger count;
}
@property(nonatomic,copy) void (^fpsHandler)(NSInteger fpsValue);

@end


@implementation FPS_OC
@synthesize fpsLabel;
@synthesize toolbar;

- (void)dealloc {
    [displayLink setPaused:YES];
    [displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

+ (FPS_OC *)sharedFps {
    static FPS_OC *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FPS_OC alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationDidBecomeActiveNotification)
                                                     name: UIApplicationDidBecomeActiveNotification
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillResignActiveNotification)
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: nil];
        
        // Track FPS using display link
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
        [displayLink setPaused:YES];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        // fpsLabel
        toolbar = [UIToolbar new];
        toolbar.frame = CGRectMake(0, 64, 100, 40);
        fpsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
        fpsLabel.font=[UIFont systemFontOfSize:15];
        fpsLabel.textColor=[UIColor colorWithRed:0.33 green:0.84 blue:0.43 alpha:1.00];
        fpsLabel.backgroundColor=[UIColor clearColor];
        fpsLabel.textAlignment=NSTextAlignmentCenter;
        fpsLabel.tag=101;
        fpsLabel.layer.cornerRadius = 10;
        fpsLabel.layer.masksToBounds = YES;
        [toolbar addSubview:fpsLabel];
        
    }
    return self;
}

- (void)displayLinkTick:(CADisplayLink *)link {
    if (lastTime == 0) {
        lastTime = link.timestamp;
        return;
    }
    
    count++;
    NSTimeInterval interval = link.timestamp - lastTime;
    if (interval < 1) return;
    lastTime = link.timestamp;
    float fps = count / interval;
    count = 0;
    
    
    fpsLabel.backgroundColor = [UIColor colorWithRed:0.29 green:0.28 blue:0.27 alpha:1.00];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, text.length - 3)];
    
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(text.length - 4, 1)];
    
    [fpsLabel setAttributedText:text];
    if (_fpsHandler) {
        _fpsHandler((int)round(fps));
    }
    
}

- (void)start {
    
    NSArray *rootVCViewSubViews=[[UIApplication sharedApplication].delegate window].rootViewController.view.subviews;
    for (UIView *label in rootVCViewSubViews) {
        if ([label isKindOfClass:[UILabel class]]&& label.tag==101) {
            return;
        }
    }
    
    [displayLink setPaused:NO];
    
    [[((NSObject <UIApplicationDelegate> *)([UIApplication sharedApplication].delegate)) window].rootViewController.view addSubview:toolbar];
}

- (void)invalid {
    
    [displayLink setPaused:YES];
    
    NSArray *rootVCViewSubViews=[[UIApplication sharedApplication].delegate window].rootViewController.view.subviews;
    for (UIView *label in rootVCViewSubViews) {
        if ([label isKindOfClass:[UILabel class]]&& label.tag==101) {
            [label removeFromSuperview];
            return;
        }
    }
    
}

- (void)applicationDidBecomeActiveNotification {
    [displayLink setPaused:NO];
}

- (void)applicationWillResignActiveNotification {
    [displayLink setPaused:YES];
}
@end
