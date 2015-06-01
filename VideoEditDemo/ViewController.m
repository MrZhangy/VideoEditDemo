//
//  ViewController.m
//  VideoEditDemo
//
//  Created by zhangyafeng on 15/5/30.
//  Copyright (c) 2015年 think. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#define kVideoURL @"/Users/think/Documents/xcodePro/VideoEditDemo/VideoEditDemo/meinv.mp4"
#define KNetWorkingURL @"http://js.a.yximgs.com/upic/2015/05/11/19/BMjAxNTA1MTExOTIwMTJfNzI0MTkzXzIyMTYzMzcyOV8xXzM=.mp4"

@interface ViewController ()
- (IBAction)playVideo:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *videoView;

@end

@implementation ViewController
{
    //需要导入#import <MediaPlayer/MediaPlayer.h>
    MPMoviePlayerController * theMoviPlayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playVideo:(id)sender {
    //播放本地音视频文件
    NSURL *movieURL = [NSURL fileURLWithPath:kVideoURL] ;
    //播放网络音视频文件
    NSURL *netWrokingURL = [NSURL URLWithString:KNetWorkingURL];
    
    theMoviPlayer = [[MPMoviePlayerController alloc] initWithContentURL:netWrokingURL];
    //指定播放的类型，MPMovieControlStyleEmbedded嵌入视频播放，可以全屏
    //MPMovieControlStyleFullscreen ,默认就是全屏播放
    theMoviPlayer.controlStyle = MPMovieControlStyleEmbedded;
    //设置视频旋转的角度
//    theMoviPlayer.view.transform = CGAffineTransformConcat(theMoviPlayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    //注意需要指定moviPlayer.view的frame否则默认是framezero
    [theMoviPlayer.view setFrame:self.videoView.bounds];
    [self.videoView addSubview:theMoviPlayer.view];
    [theMoviPlayer play];
    
}
@end
