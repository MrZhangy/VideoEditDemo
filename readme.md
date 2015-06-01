###How to download a file and save it to the documents directory with AFNetworking


##文件下载
<pre>
#define kMP4URL @"http://ws.a.yximgs.com/upic/2015/05/11/21/BMjAxNTA1MTEyMTA1MDlfNjk2MDMzM18yMjE3NjA0NjZfMV8z.mp4"
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
</pre>


##视频播放
<pre>
#define kVideoURL @"/Users/think/Documents/xcodePro/VideoEditDemo/VideoEditDemo/meinv.mp4"
#define KNetWorkingURL @"http://js.a.yximgs.com/upic/2015/05/11/19/BMjAxNTA1MTExOTIwMTJfNzI0MTkzXzIyMTYzMzcyOV8xXzM=.mp4"
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
</pre>