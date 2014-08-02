//
//  MCParsedAudioData.h
//  MCAudioFileStream
//
//  Created by Chengyin on 14-7-12.
//  Copyright (c) 2014年 Chengyin. All rights reserved.
//  https://github.com/msching/MCAudioFileStream

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface MCParsedAudioData : NSObject

@property (nonatomic,readonly) NSData *data;
@property (nonatomic,readonly) AudioStreamPacketDescription packetDescription;

+ (instancetype)parsedAudioDataWithBytes:(const void *)bytes
                       packetDescription:(AudioStreamPacketDescription)packetDescription;
@end
