//
//  ViewController.m
//  NSCharacterSet
//
//  Created by archy on 16/6/30.
//  Copyright © 2016年 archy. All rights reserved.
//

#import "ViewController.h"
#import "OperationString.h"
@interface ViewController ()

@end

@implementation ViewController
//    控制符
//    + (NSCharacterSet *)controlCharacterSet;
//返回字符集包含只在空白的空格字符（U +0020）和标签（U +0009）。
//    + (NSCharacterSet *)whitespaceCharacterSet;
//空格和换行符,返回的字符集包含Unicode通用类别Z * U000A〜U000D和U0085。
//    + (NSCharacterSet *)whitespaceAndNewlineCharacterSet;
//小数
//    + (NSCharacterSet *)decimalDigitCharacterSet;
//返回一个字符集包含的字符类别字母和标志。
//    + (NSCharacterSet *)letterCharacterSet;
//返回包含字符类别中的小写字母的字符集。
//    + (NSCharacterSet *)lowercaseLetterCharacterSet;
//大写字母, 返回一个包含字符的字符集，大写字母和词首字母大写字母类别。
//    + (NSCharacterSet *)uppercaseLetterCharacterSet;
//非基础
//    + (NSCharacterSet *)nonBaseCharacterSet;
// 返回一个字符集包含的类别字母，标志和数字的字符。
//    + (NSCharacterSet *)alphanumericCharacterSet;
//可分解
//    + (NSCharacterSet *)decomposableCharacterSet;
//返回包含在类的非字符或还没有被定义在3.2版的Unicode标准字符集。
//    + (NSCharacterSet *)illegalCharacterSet;
//返回一个字符集，包含标点符号的类别中的字符。
//    + (NSCharacterSet *)punctuationCharacterSet;
//返回一个包含字符类的词首字母大写字母的字符集。
//    + (NSCharacterSet *)capitalizedLetterCharacterSet;
//符号,返回一个包含的类别的符号中的字符的字符集。
//    + (NSCharacterSet *)symbolCharacterSet;
//返回包含换行符的字符集。
//    + (NSCharacterSet *)newlineCharacterSet NS_AVAILABLE(10_5, 2_0);
//    //返回的字符集包含的字符的Unicode值在一个给定的范围内。
//    + (NSCharacterSet *)characterSetWithRange:(NSRange)aRange;
//返回一个字符集包含一个给定的字符串中的字符
//    + (NSCharacterSet *)characterSetWithCharactersInString:(NSString *)aString;

//    + (NSCharacterSet *)characterSetWithBitmapRepresentation:(NSData *)data;

//    + (nullable NSCharacterSet *)characterSetWithContentsOfFile:(NSString *)fName;
//
//    - (instancetype) initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
//
//    - (BOOL)characterIsMember:(unichar)aCharacter;
//    @property (readonly, copy) NSData *bitmapRepresentation;
//    @property (readonly, copy) NSCharacterSet *invertedSet;
//
//
//    - (BOOL)longCharacterIsMember:(UTF32Char)theLongChar;
//
//    - (BOOL)isSupersetOfSet:(NSCharacterSet *)theOtherSet;
//    - (BOOL)hasMemberInPlane:(uint8_t)thePlane;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor greenColor];
    [self test4];
}

-(void)test4  //组合多个CharacterSet
{
    
    NSString *str = @" Price with tax: $250 ";
    NSLog(@"String:%@",str);
    NSMutableCharacterSet *characterSet =[NSMutableCharacterSet symbolCharacterSet];
//    [characterSet formUnionWithCharacterSet:[NSCharacterSet letterCharacterSet]]; //字符
//    [characterSet formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]]; //标点符号
//    [characterSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]]; //空白字符
    
    NSArray *arrayOfComponents =[str componentsSeparatedByCharactersInSet:characterSet];
    
    NSString *strOutPut =[arrayOfComponents componentsJoinedByString:@""];
    NSLog(@"New things:%@",strOutPut);
    
    NSMutableCharacterSet *decimalDigit =[NSMutableCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *characterSetInverted =[decimalDigit invertedSet];
    NSArray *array =[str componentsSeparatedByCharactersInSet:characterSetInverted];
    NSString *strResult =[array componentsJoinedByString:@""];
    NSLog(@"New string:%@",strResult);
}

-(void)test3 //使用stringByTrimmingCharactersInSet函数过滤字符串中的特殊字符
{
    //1.有字符串“A-B^C_D>E”,拆出单个字母
    NSString *str = @"      \nA~B^C_D>E       ";
    //去掉前边和后边的空格和换行符，中间部分无效
    str=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSCharacterSet *charset =[NSCharacterSet characterSetWithCharactersInString:@"^~_>"];
    NSArray *array =[str componentsSeparatedByCharactersInSet:charset];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"A-B^C_D>E--->[%@]",obj);
    }];
    NSLog(@"array %@",[array componentsJoinedByString:@" "]);
    
    //2.关于invertedset
    NSString *string =@"     123,45_6  7/8>9a     ";
    NSString *kNumber = @"0123456789.";
    //对于自定义字符串是非常重要的，经常使用
    //invertedSet方法是去反字符，把所有的的除了kNumber里的字符串都找出来（包含去空格功能），经常用于提交UItextfile的或者uitextview中的输入内容
    NSCharacterSet *numberset =[[NSCharacterSet characterSetWithCharactersInString:kNumber] invertedSet];
    
    NSString *filedString =[[string componentsSeparatedByCharactersInSet:numberset] componentsJoinedByString:@""];
    NSLog(@"number:%@",filedString);
    
    
    //3.去掉首尾指定的字符集
    NSString *str2 = @"天我爱北京天安门天";
    id cd = [NSCharacterSet characterSetWithCharactersInString:@"天门"];
    NSString *strResult = [str2 stringByTrimmingCharactersInSet:cd];
    NSLog(@"%@",strResult);
    
    //4.去除指定的字符集
    NSString *strMsg = @"我爱北京天安门";
    NSCharacterSet *characterset =[NSCharacterSet characterSetWithCharactersInString:@"天门"];
    NSMutableString *theString = [NSMutableString stringWithString:strMsg];
    NSString *resustStr1 =[self clearnIllegiCharacters:theString andChareaterSet:characterset];
    NSLog(@"%@",resustStr1);
}

//清除敏感字符
-(NSString *)clearnIllegiCharacters:(NSMutableString *)originString andChareaterSet:(NSCharacterSet *)cs {
    NSString *strResult = nil;
    NSRange range2;
    do
    {
        range2 = [originString rangeOfCharacterFromSet:cs options:NSLiteralSearch];
        if (range2.location!=NSNotFound) {
            [originString replaceCharactersInRange:range2 withString:@"*"];
        }
    }
    while(range2.location!=NSNotFound);
    
    strResult = [[NSString alloc]initWithString:originString];
    return strResult;
}



-(void)test2 //找到第一个大写字符、数字
{
    NSString *mystring = @"some text in an NSString... 123 Jack";
    NSCharacterSet *charecterSet =[NSCharacterSet uppercaseLetterCharacterSet];
    NSRange letterRange = [mystring rangeOfCharacterFromSet:charecterSet];
    if ([mystring substringWithRange:letterRange]) {
        NSLog(@"%@",[mystring substringWithRange:letterRange]);
    }
    NSMutableCharacterSet *decimaldigit =[NSMutableCharacterSet decimalDigitCharacterSet];
    NSRange decimaidigitalRange =[mystring rangeOfCharacterFromSet:decimaldigit];
    if ([mystring substringWithRange:decimaidigitalRange]) {
        NSLog(@"%@",[mystring substringWithRange:decimaidigitalRange]);
    }
}

-(void)test1  //挤压空格
{
    NSString *string =@" Lorem    ipsum  dolar   sit  amet. ";
    
    //去掉首尾的多余空格
    string =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSLog(@"%@",string);
    
    //用空格分隔字符串
    NSArray *components =[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    string =[components componentsJoinedByString:@""];
    NSLog(@"%@",string);
}


@end
