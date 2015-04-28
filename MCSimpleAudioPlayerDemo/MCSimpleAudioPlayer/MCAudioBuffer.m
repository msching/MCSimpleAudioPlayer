//
//  MCAudioBuffer.m
//  MCSimpleAudioPlayer
//
//  Created by Chengyin on 14-7-28.
//  Copyright (c) 2014年 Chengyin. All rights reserved.
//

#import "MCAudioBuffer.h"

@interface MCAudioBuffer ()
{
@private
    NSMutableArray *_bufferBlockArray;
    UInt32 _bufferedSize;
}
@end

@implementation MCAudioBuffer

+ (instancetype)buffer
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _bufferBlockArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)hasData
{
    return _bufferBlockArray.count > 0;
}

- (UInt32)bufferedSize
{
    return _bufferedSize;
}

- (void)enqueueFromDataArray:(NSArray *)dataArray
{
    for (MCParsedAudioData *data in dataArray)
    {
        [self enqueueData:data];
    }
}

- (void)enqueueData:(MCParsedAudioData *)data
{
    if ([data isKindOfClass:[MCParsedAudioData class]])
    {
        [_bufferBlockArray addObject:data];
        _bufferedSize += data.data.length;
    }
}

- (NSData *)dequeueDataWithSize:(UInt32)requestSize packetCount:(UInt32 *)packetCount descriptions:(AudioStreamPacketDescription **)descriptions
{
    if (requestSize == 0 && _bufferBlockArray.count == 0)
    {
        return nil;
    }
    
    SInt64 size = requestSize;
    int i = 0;
    for (i = 0; i < _bufferBlockArray.count ; ++i)
    {
        MCParsedAudioData *block = _bufferBlockArray[i];
        SInt64 dataLength = [block.data length];
        if (size > dataLength)
        {
            size -= dataLength;
        }
        else
        {
            if (size < dataLength)
            {
                i--;
            }
            break;
        }
    }
    
    if (i < 0)
    {
        return nil;
    }
    
    UInt32 count = (i >= _bufferBlockArray.count) ? (UInt32)_bufferBlockArray.count : (i + 1);
    *packetCount = count;
    if (count == 0)
    {
        return nil;
    }
    
    if (descriptions != NULL)
    {
        *descriptions = (AudioStreamPacketDescription *)malloc(sizeof(AudioStreamPacketDescription) * count);
    }
    NSMutableData *retData = [[NSMutableData alloc] init];
    for (int j = 0; j < count; ++j)
    {
        MCParsedAudioData *block = _bufferBlockArray[j];
        if (descriptions != NULL)
        {
            AudioStreamPacketDescription desc = block.packetDescription;
            desc.mStartOffset = [retData length];
            (*descriptions)[j] = desc;
        }
        [retData appendData:block.data];
    }
    NSRange removeRange = NSMakeRange(0, count);
    [_bufferBlockArray removeObjectsInRange:removeRange];
    
    _bufferedSize -= retData.length;
    
    return retData;
}

- (void)clean
{
    _bufferedSize = 0;
    [_bufferBlockArray removeAllObjects];
}

#pragma mark -
- (void)dealloc
{
    [_bufferBlockArray removeAllObjects];
}
@end
