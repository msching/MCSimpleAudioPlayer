//
//  MCAudioBuffer.h
//  MCSimpleAudioPlayer
//
//  Created by Chengyin on 14-7-28.
//  Copyright (c) 2014年 Chengyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "MCParsedAudioData.h"

@interface MCAudioBuffer : NSObject

+ (instancetype)buffer;

- (void)enqueueData:(MCParsedAudioData *)data;
- (void)enqueueFromDataArray:(NSArray *)dataArray;

- (BOOL)hasData;
- (UInt32)bufferedSize;

//descriptions needs free
- (NSData *)dequeueDataWithSize:(UInt32)requestSize packetCount:(UInt32 *)packetCount descriptions:(AudioStreamPacketDescription **)descriptions;

- (void)clean;
@end
