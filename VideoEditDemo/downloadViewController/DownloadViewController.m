//
//  DownloadViewController.m
//  VideoEditDemo
//
//  Created by zhangyafeng on 15/5/30.
//  Copyright (c) 2015年 think. All rights reserved.
//

#import "DownloadViewController.h"
#import "AFNetworking.h"

#define kMP4URL @"http://ws.a.yximgs.com/upic/2015/05/11/21/BMjAxNTA1MTEyMTA1MDlfNjk2MDMzM18yMjE3NjA0NjZfMV8z.mp4"

@interface DownloadViewController ()
- (IBAction)downLoadMP4File:(id)sender;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//How to download a file and save it to the documents directory with AFNetworking
- (IBAction)downLoadMP4File:(id)sender {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kMP4URL]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    //设置存储路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:kMP4URL.lastPathComponent];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
     //设置下载进度检测
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSLog(@"bytesRead: %u, totalBytesRead: %lld, totalBytesExpectedToRead: %lld", bytesRead, totalBytesRead, totalBytesExpectedToRead);
    }];
    
    //检测是否下载成功
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully downloaded file to %@", path);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];
    
}
@end
