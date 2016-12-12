//
//  QWTextView.h
//  jiaFen
//
//  Created by 王权伟 on 15/10/1.
//  Copyright © 2015年 加分教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QWTextView : UITextView
@property (strong, nonatomic) UIColor * PlaceholderColor;
@property (strong, nonatomic) NSAttributedString * placeholderText;
@property (strong, nonatomic) NSString * placeholder;
-(void) setPlaceholderColor:(UIColor *)color;
-(void) setPlaceholderText:(NSAttributedString *)str;
-(void) placeholderHidden;

@end
