//
//  MCParsedAudioData.m
//  MCAudioFileStream
//
//  Created by Chengyin on 14-7-12.
//  Copyright (c) 2014年 Chengyin. All rights reserved.
//  https://github.com/msching/MCAudioFileStream

#import "MCParsedAudioData.h"

@implementation MCParsedAudioData
@synthesize data = _data;
@synthesize packetDescription = _packetDescription;

+ (instancetype)parsedAudioDataWithBytes:(const void *)bytes
                       packetDescription:(AudioStreamPacketDescription)packetDescription
{
    return [[self alloc] initWithBytes:bytes
                             packetDescription:packetDescription];
}

- (instancetype)initWithBytes:(const void *)bytes packetDescription:(AudioStreamPacketDescription)packetDescription
{
    if (bytes == NULL || packetDescription.mDataByteSize == 0)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _data = [NSData dataWithBytes:bytes length:packetDescription.mDataByteSize];
        _packetDescription = packetDescription;
    }
    return self;
}
@end