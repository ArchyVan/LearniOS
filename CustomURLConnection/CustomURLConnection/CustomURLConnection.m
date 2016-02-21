//
//  CustomURLConnection.m
//  CustomURLConnection
//
//  Created by Archy on 15/6/24.
//  Copyright (c) 2015年 Van. All rights reserved.
//
#include <unistd.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <arpa/inet.h>
#include <sys/types.h>
#import "CustomURLConnection.h"

@implementation CustomURLConnection

- (id)initWithUrl:(NSURL *)url delegate:(id)delegate
{
    self = [super init];
    if (self ) {
        self.url = url;
        self.delegate = delegate;
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMain:) object:nil];
        
        
        [_thread start];
    }
    return self;
}

- (void) threadMain:(id)arg
{
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    
    int port = _url.port.intValue;
    if (port == 0) {
        port = 80;
    }
    struct sockaddr_in serverAddress;
    memset(&serverAddress, 0, sizeof(serverAddress));
    
    serverAddress.sin_family = AF_INET;
    serverAddress.sin_port = htons(80);
    serverAddress.sin_addr.s_addr = inet_addr("10.0.8.8");
    
    int ret = connect(sock, (struct sockaddr *)&serverAddress, sizeof(serverAddress));
    
    if (ret < 0) {
        perror("connect error");
        close(sock);
    }
    
    char *p = "GET /sns/my/user_list.php?page=2 HTTP/1.1\r\n";
    write(sock, p, strlen(p));
    
    char *p2 = "Host: 10.0.8.8\r\n";
    write(sock, p2, strlen(p2));
    
    char *p3 = "\r\n";
    write(sock, p3, strlen(p3));
    
    char responseBuf[1024];

    ret = read(sock, responseBuf, 1024);
    
    
    char responseHeaderBuffer[1024];
    int index;
    int ch;
    while (1) {
        ret = read(sock, &ch, 1);
        if (ch == '\n') {
            if (ch == '\n' && index > 3) {
                char ch1 = responseHeaderBuffer[index-3];
                char ch2 = responseHeaderBuffer[index-2];
                char ch3 = responseHeaderBuffer[index-1];
                
                if (ch1 == '\r' && ch2 == '\n'&& ch3 == '\r') {
                    responseHeaderBuffer[index++] = (char)ch;
                    break;
                } else {
                    responseHeaderBuffer[index++] = (char)ch;
                }
            }
        } else {
            responseHeaderBuffer[index++] = (char)ch;
        }
    }
    
    NSString *s = [NSString stringWithFormat:@"%s",responseHeaderBuffer];
    NSArray *arr = [s componentsSeparatedByString:@"\r\n"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    int row = 0;
    for (NSString *eachItem in arr) {
        
        NSArray *subArr = [eachItem componentsSeparatedByString:@":"];
        if (subArr.count == 2) {
            NSString *key = [subArr objectAtIndex:0];
            NSString *value = [subArr objectAtIndex:1];
            [dict setObject:value forKey:key];
        }
        
    }
    if ([_delegate respondsToSelector:@selector(customConnection:didReceiveResponse:)]) {
        [_delegate customConnection:self didReceiveResponse:dict];
    }
    unsigned int len = [[dict objectForKey:@"Content-Length"] intValue];
#define MAX_LEN 1024
    char *datap = malloc(len);
    int haveRead = 0;
    while (haveRead < len) {
        int thisRead = read(sock, datap, MAX_LEN);
        if (thisRead > 0) {
            haveRead += thisRead;
            NSData *d = [[NSData alloc] initWithBytes:datap length:thisRead];
            [_delegate customConnection:self didReceiveData:d];
        }
    }

}
@end
