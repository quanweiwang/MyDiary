//
//  QWTextView.m
//  jiaFen
//
//  Created by 王权伟 on 15/10/1.
//  Copyright © 2015年 加分教育. All rights reserved.
//

#import "QWTextView.h"

@interface QWTextView ()
@property (strong, nonatomic) UILabel * placeholderLabel;

@end

@implementation QWTextView
@synthesize placeholder = _placeholder;
@synthesize PlaceholderColor;
@synthesize placeholderText;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initConfig];
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextViewTextDidChangeNotification"
                                                 object:nil];
}

-(void) initConfig
{
    self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width, 21)];
    self.placeholderLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
    self.placeholderLabel.font = self.font;
    [self addSubview:self.placeholderLabel];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(placeholderHidden)
                                                name:@"UITextViewTextDidChangeNotification"
                                              object:nil];
    
}

-(void)setPlaceholder:(NSString *)placeholder
{
    self.placeholderLabel.text = placeholder;
}

-(void) setPlaceholderColor:(UIColor *)color
{
    self.placeholderLabel.textColor = color;
}

-(void) setPlaceholderText:(NSAttributedString *)str
{
    self.placeholderLabel.attributedText = str;
}

-(void) placeholderHidden
{
    if ([self.text length] > 0 ) {
        self.placeholderLabel.hidden = YES;
    }
    else
    {
        self.placeholderLabel.hidden = NO;
    }
}
-(void)setText:(NSString *)text
{
    [super setText:text];
    self.placeholderLabel.hidden = YES;
}
@end
