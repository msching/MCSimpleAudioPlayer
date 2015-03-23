//
//  NSTimer+BlocksSupport.m
//  MCSimpleAudioPlayerDemo
//
//  Created by Chengyin on 15-3-13.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NSTimer+BlocksSupport.h"

@implementation NSTimer (BlocksSupport)
+ (NSTimer*)bs_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(bs_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)bs_blockInvoke:(NSTimer*)timer
{
    void (^block)() = timer.userInfo;
    if (block)
    {
        block();
    }
}
@end
