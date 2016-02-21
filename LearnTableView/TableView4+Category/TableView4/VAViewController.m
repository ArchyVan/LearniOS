//
//  VAViewController.m
//  TableView4
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "VAViewController.h"
#import "VAMessage.h"
#import "VAMessageCell.h"
#import "VAMessageFrame.h"
@interface VAViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong)NSMutableArray * messageFrames;

@property (nonatomic,strong)NSDictionary * autoreply;
@property (weak, nonatomic) IBOutlet UITextField *inputView;


@end

@implementation VAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    self.tableView.allowsSelection = NO;
    
    self.tableView.delegate = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.inputView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    self.inputView.leftViewMode = UITextFieldViewModeAlways;
    self.inputView.delegate = self;
    
}
- (void)dealloc
{
    [[NSNotificationCenter  defaultCenter]removeObserver:self];
}

- (void)addMessage:(NSString *)text type:(VAMessageType)type
{
    VAMessage * msg = [[VAMessage alloc] init];
    msg.type = type;
    msg.text = text;
    NSDate * now =[NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    fmt.dateFormat = @"HH:mm";
    
    msg.time = [fmt stringFromDate:now];
    
    VAMessageFrame * lastMF = [self.messageFrames lastObject];
    VAMessage * lastMsg = lastMF.message;
    msg.hideTime = [msg.time isEqualToString:lastMsg.time];
    
    VAMessageFrame * mf = [[VAMessageFrame alloc]init];
    
    mf.message = msg;
    [self.messageFrames addObject:mf];
    
    [self.tableView reloadData];
    
    NSIndexPath * lastPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

- (NSString *)replayWithText:(NSString *)text
{
    for (int i = 0; i < text.length; i++) {
        NSString * word = [text substringWithRange:NSMakeRange(i, 1)];
        if (self.autoreply[word]) {
            return self.autoreply[word];
        }
    }
    return @"Gun.....";
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addMessage:textField.text type:VAMessageTypeMe];
    
    NSString *reply = [self replayWithText:textField.text];
    [self addMessage:reply type:VAMessageTypeOther];
    
    self.inputView.text = nil;
    
    return  YES;
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}


/*
 UIKeyboardAnimationCurveUserInfoKey = 7;  // 动画的执行节奏(速度)
 UIKeyboardAnimationDurationUserInfoKey = "0.25"; // 键盘弹出\隐藏动画所需要的时间
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 216}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 588}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 372}";
 UIKeyboardFrameChangedByUserInteraction = 0;
 
 // 键盘弹出
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 480}, {320, 216}}";// 键盘刚出来那一刻的frame
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 264}, {320, 216}}"; //  键盘显示完毕后的frame
 
 // 键盘隐藏
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 264}, {320, 216}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 480}, {320, 216}}";
 */

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(NSDictionary *)autoreply
{
    if (_autoreply == nil) {
        _autoreply = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoreply.plist" ofType:nil]];
        
    }
    return _autoreply;
}
-(NSMutableArray *)messageFrames
{
    if (_messageFrames == nil) {
        NSArray * dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil]];
                               
        NSMutableArray *mfArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            VAMessage * msg = [VAMessage messageWithDict:dict];
            
            VAMessageFrame * lastMf = [mfArray lastObject];
            
            VAMessage *lastMsg = lastMf.message;
            
            msg.hideTime = [msg.time isEqualToString:lastMsg.time];
            
            VAMessageFrame *mf = [[VAMessageFrame alloc]init];
            
            mf.message =msg;
            
            [mfArray addObject:mf];
        }
        _messageFrames = mfArray;
    }
    return _messageFrames;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VAMessageCell *cell = [VAMessageCell cellWithTableView:tableView];
    
    cell.messageFrame = self.messageFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VAMessageFrame *mf = self.messageFrames[indexPath.row];
    return mf.cellHeight;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
