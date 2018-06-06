//
//  CustomURLProtocol.m
//  NSURLProtocol
//
//  Created by ZhiHua Shen on 2018/5/28.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "CustomURLProtocol.h"
#import <MobileCoreServices/MobileCoreServices.h>


@implementation CustomURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {

    NSString *fileName = request.URL.absoluteString.lastPathComponent;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return YES;
    }
    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {

    NSMutableURLRequest *request = self.request.mutableCopy;
    
    NSString *fileName = request.URL.absoluteString.lastPathComponent;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    NSString *mineType = [self mimeTypeForFileAtPath:path];
    
    NSData *date = [NSData dataWithContentsOfFile:path];
    
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:mineType expectedContentLength:date.length textEncodingName:nil];
    
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    [self.client URLProtocol:self didLoadData:date];
    
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {
    
}

- (NSString *)mimeTypeForFileAtPath:(NSString *)path
{
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
        return nil;
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)(MIMEType);
}

@end
