//
//  NSString+Octions.m
//  VVM
//
//  Created by ZMJ on 2018/8/25.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import "NSString+Octions.h"

@implementation NSString (Octions)

+ (BOOL)isEmptyConsiderWhitespace:(NSString *)string {
    if ([NSString isNotEmpty:string]) {
        return ![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length];
    }
    else {
        return YES;
    }
}


#pragma mark - 字符串简单变换
+ (NSString *)trimString:(NSString *)string {
    ReturnEmptyWhenObjectIsEmpty(string)
    return [string trimString];
}
- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+ (BOOL)isUrl:(NSString *)string {
    ReturnNOWhenObjectIsEmpty(string)
    return [string isUrl];
}

- (BOOL)isUrl {
    return [NSString isMatchRegex:RegexUrl withString:self];
}
+ (BOOL)isNotUrl:(NSString *)string {
    return ![self isUrl:string];
}

//版本升级
+ (NSUInteger)compareWithVersion:(NSString *)version2{
    
    NSUInteger compareResultNumber=0;
    //按照.来分解成数组
    NSArray *version2Array=[NSString splitString:version2 byRegex:@"\\."];
    NSArray* reversedArray = [[version2Array reverseObjectEnumerator] allObjects];
    
    for (int i=0; i<[reversedArray count]; i++) {
        
        NSUInteger version1Value=   pow(10, i+1)*[reversedArray[i] integerValue];
        
        compareResultNumber=compareResultNumber+version1Value;
        
    }
    return compareResultNumber;
}

+ (BOOL)isMatchRegex:(NSString*)pattern withString:(NSString *)string {
    ReturnNOWhenObjectIsEmpty(string)
    return [string isMatchRegex:pattern options:NSRegularExpressionCaseInsensitive];
}
- (BOOL)isMatchRegex:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    ReturnNOWhenObjectIsEmpty(pattern)
    
    //方法一：缺点是无法兼容大小写的情况
    //    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    //    return [identityCardPredicate evaluateWithObject:self];
    
    //方法二：
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                options:options
                                                                                  error:&error];
    if (error) {
        NSLog(@"Error by creating Regex: %@",[error description]);
        return NO;
    }
    
    return ([expression numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])] > 0);
}


+ (NSArray *)splitString:(NSString *)string byRegex:(NSString *)pattern {
    if ([NSString isEmpty:string]) {
        return @[];
    }
    return [string splitByRegex:pattern options:NSRegularExpressionCaseInsensitive];
}
- (NSArray *)splitByRegex:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    if ([NSString isEmpty:pattern]) {
        return @[];
    }
#define SpecialPlaceholderString @"_&&_"   //特殊占位符
    NSString *newString = [self replaceByRegex:pattern to:SpecialPlaceholderString options:options];
    NSArray *sourceArray = [newString componentsSeparatedByString:SpecialPlaceholderString];
    NSMutableArray *components = [NSMutableArray array];
    for (NSString *component in sourceArray) {
        if (![NSString isEmptyConsiderWhitespace:component]) {
            [components addObject:[component trimString]];
        }
    }
    return components;
}


- (NSString *)replaceByRegex:(NSString *)pattern to:(NSString *)toString options:(NSRegularExpressionOptions)options{
    ReturnEmptyWhenObjectIsEmpty(pattern)
    //方法一：缺点是仅仅用于普通字符串，无法兼容正则表达式的情况
    //    return [self stringByReplacingOccurrencesOfString:pattern withString:toString];
    
    //方法二：
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                options:options
                                                                                  error:&error];
    if (error) {
        NSLog(@"Error by creating Regex: %@",[error description]);
        return @"";
    }
    return [expression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:toString];
}

+ (BOOL)isEmpty:(id)object {
    return (object == nil
            || [object isKindOfClass:[NSNull class]]
            || ([object respondsToSelector:@selector(length)] && [(NSData *)object length] == 0)
            || ([object respondsToSelector:@selector(count)]  && [(NSArray *)object count] == 0));
}

+ (BOOL)isNotEmpty:(id)object {
    return ( ! [self isEmpty:object]);
}



+ (OCTIcon)octicon_enumForIconIdentifier:(NSString *)string {
    NSDictionary *enums = [self octicon_enumDictionary];
    return [enums[string] integerValue];
}

+ (NSString *)octicon_iconDescriptionForEnum:(OCTIcon)icon {
    NSDictionary *dict = [self octicon_enumDictionary];
    
    for (NSString *key in dict) {
        NSNumber *value = [dict valueForKey:key];
        if ([value integerValue] == icon)
            return key;
    }
    return nil;
}

+ (NSString *)octicon_iconStringForEnum:(OCTIcon)value {
    return [self octicon_icons][value];
}

+ (NSString *)octicon_iconStringForIconIdentifier:(NSString*)identifier {
    return [self octicon_iconStringForEnum:[self octicon_enumForIconIdentifier:identifier]];
}

+ (NSArray *)octicon_icons {
    static NSArray *octiconIcons;
    if (!octiconIcons) {
        octiconIcons = @[@"\uf02d",
                         @"\uf08a",
                         @"\uf08e",
                         @"\uf08b",
                         @"\uf03f",
                         @"\uf040",
                         @"\uf03e",
                         @"\uf0a0",
                         @"\uf0a1",
                         @"\uf071",
                         @"\uf09f",
                         @"\uf03d",
                         @"\uf069",
                         @"\uf007",
                         @"\uf07b",
                         @"\uf0d3",
                         @"\uf048",
                         @"\uf0c5",
                         @"\uf091",
                         @"\uf068",
                         @"\uf03a",
                         @"\uf076",
                         @"\uf0a3",
                         @"\uf0a4",
                         @"\uf078",
                         @"\uf0a2",
                         @"\uf084",
                         @"\uf0d6",
                         @"\uf035",
                         @"\uf046",
                         @"\uf00b",
                         @"\uf00c",
                         @"\uf05f",
                         @"\uf065",
                         @"\uf02b",
                         @"\uf04f",
                         @"\uf045",
                         @"\uf0ca",
                         @"\uf07d",
                         @"\uf096",
                         @"\uf056",
                         @"\uf057",
                         @"\uf27c",
                         @"\uf038",
                         @"\uf04d",
                         @"\uf06b",
                         @"\uf099",
                         @"\uf06d",
                         @"\uf06c",
                         @"\uf06e",
                         @"\uf09a",
                         @"\uf04e",
                         @"\uf094",
                         @"\uf010",
                         @"\uf016",
                         @"\uf012",
                         @"\uf014",
                         @"\uf017",
                         @"\uf0b1",
                         @"\uf0b0",
                         @"\uf011",
                         @"\uf013",
                         @"\uf0d2",
                         @"\uf0cc",
                         @"\uf02f",
                         @"\uf042",
                         @"\uf00e",
                         @"\uf08c",
                         @"\uf020",
                         @"\uf01f",
                         @"\uf0ac",
                         @"\uf023",
                         @"\uf009",
                         @"\uf0b6",
                         @"\uf043",
                         @"\u2665",
                         @"\uf07e",
                         @"\uf08d",
                         @"\uf070",
                         @"\uf09e",
                         @"\uf09d",
                         @"\uf0cf",
                         @"\uf059",
                         @"\uf028",
                         @"\uf026",
                         @"\uf027",
                         @"\uf019",
                         @"\uf072",
                         @"\uf0a5",
                         @"\uf0a6",
                         @"\uf073",
                         @"\uf049",
                         @"\uf00d",
                         @"\uf0d8",
                         @"\uf000",
                         @"\uf05c",
                         @"\uf07f",
                         @"\uf062",
                         @"\uf061",
                         @"\uf060",
                         @"\uf06a",
                         @"\uf092",
                         @"\uf03b",
                         @"\uf03c",
                         @"\uf051",
                         @"\uf00a",
                         @"\uf0c9",
                         @"\uf077",
                         @"\uf0be",
                         @"\uf089",
                         @"\uf075",
                         @"\uf024",
                         @"\uf0d7",
                         @"\uf0a8",
                         @"\uf074",
                         @"\uf0a9",
                         @"\uf0a7",
                         @"\uf080",
                         @"\uf09c",
                         @"\uf008",
                         @"\uf037",
                         @"\uf0c4",
                         @"\uf0d1",
                         @"\uf058",
                         @"\uf018",
                         @"\uf041",
                         @"\uf0bd",
                         @"\uf0bb",
                         @"\uf0bf",
                         @"\uf0bc",
                         @"\uf0d4",
                         @"\uf05d",
                         @"\uf0af",
                         @"\uf052",
                         @"\uf053",
                         @"\uf085",
                         @"\uf0c0",
                         @"\uf02c",
                         @"\uf063",
                         @"\uf030",
                         @"\uf001",
                         @"\uf04c",
                         @"\uf04a",
                         @"\uf002",
                         @"\uf006",
                         @"\uf005",
                         @"\uf033",
                         @"\uf034",
                         @"\uf047",
                         @"\uf066",
                         @"\uf067",
                         @"\uf02e",
                         @"\uf097",
                         @"\uf07c",
                         @"\uf036",
                         @"\uf032",
                         @"\uf0c6",
                         @"\uf0b2",
                         @"\uf02a",
                         @"\uf0c7",
                         @"\uf08f",
                         @"\uf087",
                         @"\uf015",
                         @"\uf088",
                         @"\uf0c8",
                         @"\uf05e",
                         @"\uf031",
                         @"\uf0d0",
                         @"\uf05b",
                         @"\uf044",
                         @"\uf05a",
                         @"\uf0aa",
                         @"\uf039",
                         @"\uf0ba",
                         @"\uf064",
                         @"\uf081",
                         @"\u26A1"];
    }
    return octiconIcons;
}

+ (NSDictionary *)octicon_enumDictionary {
    static NSDictionary *enumDictionary;
    if (!enumDictionary) {
        enumDictionary = @{
                           @"Alert": @(OCTIconAlert),
                           @"AlignmentAlign": @(OCTIconAlignmentAlign),
                           @"AlignmentAlignedTo": @(OCTIconAlignmentAlignedTo),
                           @"AlignmentUnalign": @(OCTIconAlignmentUnalign),
                           @"ArrowDown": @(OCTIconArrowDown),
                           @"ArrowLeft": @(OCTIconArrowLeft),
                           @"ArrowRight": @(OCTIconArrowRight),
                           @"ArrowSmallDown": @(OCTIconArrowSmallDown),
                           @"ArrowSmallLeft": @(OCTIconArrowSmallLeft),
                           @"ArrowSmallRight": @(OCTIconArrowSmallRight),
                           @"ArrowSmallUp": @(OCTIconArrowSmallUp),
                           @"ArrowUp": @(OCTIconArrowUp),
                           @"Beer": @(OCTIconBeer),
                           @"Book": @(OCTIconBook),
                           @"Bookmark": @(OCTIconBookmark),
                           @"Briefcase": @(OCTIconBriefcase),
                           @"Broadcast": @(OCTIconBroadcast),
                           @"Browser": @(OCTIconBrowser),
                           @"Bug": @(OCTIconBug),
                           @"Calendar": @(OCTIconCalendar),
                           @"Check": @(OCTIconCheck),
                           @"Checklist": @(OCTIconChecklist),
                           @"ChevronDown": @(OCTIconChevronDown),
                           @"ChevronLeft": @(OCTIconChevronLeft),
                           @"ChevronRight": @(OCTIconChevronRight),
                           @"ChevronUp": @(OCTIconChevronUp),
                           @"CircleSlash": @(OCTIconCircleSlash),
                           @"CircuitBoard": @(OCTIconCircuitBoard),
                           @"Clippy": @(OCTIconClippy),
                           @"Clock": @(OCTIconClock),
                           @"CloudDownload": @(OCTIconCloudDownload),
                           @"CloudUpload": @(OCTIconCloudUpload),
                           @"Code": @(OCTIconCode),
                           @"ColorMode": @(OCTIconColorMode),
                           @"Comment": @(OCTIconComment),
                           @"CommentDiscussion": @(OCTIconCommentDiscussion),
                           @"CreditCard": @(OCTIconCreditCard),
                           @"Dash": @(OCTIconDash),
                           @"Dashboard": @(OCTIconDashboard),
                           @"Database": @(OCTIconDatabase),
                           @"DeviceCamera": @(OCTIconDeviceCamera),
                           @"DeviceCameraVideo": @(OCTIconDeviceCameraVideo),
                           @"DeviceDesktop": @(OCTIconDeviceDesktop),
                           @"DeviceMobile": @(OCTIconDeviceMobile),
                           @"Diff": @(OCTIconDiff),
                           @"DiffAdded": @(OCTIconDiffAdded),
                           @"DiffIgnored": @(OCTIconDiffIgnored),
                           @"DiffModified": @(OCTIconDiffModified),
                           @"DiffRemoved": @(OCTIconDiffRemoved),
                           @"DiffRenamed": @(OCTIconDiffRenamed),
                           @"Ellipsis": @(OCTIconEllipsis),
                           @"Eye": @(OCTIconEye),
                           @"FileBinary": @(OCTIconFileBinary),
                           @"FileCode": @(OCTIconFileCode),
                           @"FileDirectory": @(OCTIconFileDirectory),
                           @"FileMedia": @(OCTIconFileMedia),
                           @"FilePdf": @(OCTIconFilePdf),
                           @"FileSubmodule": @(OCTIconFileSubmodule),
                           @"FileSymlinkDirectory": @(OCTIconFileSymlinkDirectory),
                           @"FileSymlinkFile": @(OCTIconFileSymlinkFile),
                           @"FileText": @(OCTIconFileText),
                           @"FileZip": @(OCTIconFileZip),
                           @"Flame": @(OCTIconFlame),
                           @"Fold": @(OCTIconFold),
                           @"Gear": @(OCTIconGear),
                           @"Gift": @(OCTIconGift),
                           @"Gist": @(OCTIconGist),
                           @"GistSecret": @(OCTIconGistSecret),
                           @"GitBranch": @(OCTIconGitBranch),
                           @"GitCommit": @(OCTIconGitCommit),
                           @"GitCompare": @(OCTIconGitCompare),
                           @"GitMerge": @(OCTIconGitMerge),
                           @"GitPullRequest": @(OCTIconGitPullRequest),
                           @"Globe": @(OCTIconGlobe),
                           @"Graph": @(OCTIconGraph),
                           @"Heart": @(OCTIconHeart),
                           @"History": @(OCTIconHistory),
                           @"Home": @(OCTIconHome),
                           @"HorizontalRule": @(OCTIconHorizontalRule),
                           @"Hourglass": @(OCTIconHourglass),
                           @"Hubot": @(OCTIconHubot),
                           @"Inbox": @(OCTIconInbox),
                           @"Info": @(OCTIconInfo),
                           @"IssueClosed": @(OCTIconIssueClosed),
                           @"IssueOpened": @(OCTIconIssueOpened),
                           @"IssueReopened": @(OCTIconIssueReopened),
                           @"Jersey": @(OCTIconJersey),
                           @"JumpDown": @(OCTIconJumpDown),
                           @"JumpLeft": @(OCTIconJumpLeft),
                           @"JumpRight": @(OCTIconJumpRight),
                           @"JumpUp": @(OCTIconJumpUp),
                           @"Key": @(OCTIconKey),
                           @"Keyboard": @(OCTIconKeyboard),
                           @"Law": @(OCTIconLaw),
                           @"LightBulb": @(OCTIconLightBulb),
                           @"Link": @(OCTIconLink),
                           @"LinkExternal": @(OCTIconLinkExternal),
                           @"ListOrdered": @(OCTIconListOrdered),
                           @"ListUnordered": @(OCTIconListUnordered),
                           @"Location": @(OCTIconLocation),
                           @"Lock": @(OCTIconLock),
                           @"LogoGithub": @(OCTIconLogoGithub),
                           @"Mail": @(OCTIconMail),
                           @"MailRead": @(OCTIconMailRead),
                           @"MailReply": @(OCTIconMailReply),
                           @"MarkGithub": @(OCTIconMarkGithub),
                           @"Markdown": @(OCTIconMarkdown),
                           @"Megaphone": @(OCTIconMegaphone),
                           @"Mention" : @(OCTIconMention),
                           @"Microscope": @(OCTIconMicroscope),
                           @"Milestone": @(OCTIconMilestone),
                           @"MirrorPublic": @(OCTIconMirrorPublic),
                           @"MortarBoard" : @(OCTIconMortarBoard),
                           @"MoveDown": @(OCTIconMoveDown),
                           @"MoveLeft": @(OCTIconMoveLeft),
                           @"MoveRight": @(OCTIconMoveRight),
                           @"MoveUp": @(OCTIconMoveUp),
                           @"Mute": @(OCTIconMute),
                           @"NoNewline": @(OCTIconNoNewline),
                           @"Octoface": @(OCTIconOctoface),
                           @"Organization": @(OCTIconOrganization),
                           @"Package": @(OCTIconPackage),
                           @"Paintcan": @(OCTIconPaintcan),
                           @"Pencil": @(OCTIconPencil),
                           @"Person": @(OCTIconPerson),
                           @"Pin": @(OCTIconPin),
                           @"PlaybackFastForward": @(OCTIconPlaybackFastForward),
                           @"PlaybackPause": @(OCTIconPlaybackPause),
                           @"PlaybackPlay": @(OCTIconPlaybackPlay),
                           @"PlaybackRewind": @(OCTIconPlaybackRewind),
                           @"Plug": @(OCTIconPlug),
                           @"Plus": @(OCTIconPlus),
                           @"Podium": @(OCTIconPodium),
                           @"PrimitiveDot": @(OCTIconPrimitiveDot),
                           @"PrimitiveSquare": @(OCTIconPrimitiveSquare),
                           @"Pulse": @(OCTIconPulse),
                           @"Puzzle": @(OCTIconPuzzle),
                           @"Question": @(OCTIconQuestion),
                           @"Quote": @(OCTIconQuote),
                           @"RadioTower": @(OCTIconRadioTower),
                           @"Repo": @(OCTIconRepo),
                           @"RepoClone": @(OCTIconRepoClone),
                           @"RepoForcePush": @(OCTIconRepoForcePush),
                           @"RepoForked": @(OCTIconRepoForked),
                           @"RepoPull": @(OCTIconRepoPull),
                           @"RepoPush": @(OCTIconRepoPush),
                           @"Rocket": @(OCTIconRocket),
                           @"Rss": @(OCTIconRss),
                           @"Ruby": @(OCTIconRuby),
                           @"ScreenFull": @(OCTIconScreenFull),
                           @"ScreenNormal": @(OCTIconScreenNormal),
                           @"Search": @(OCTIconSearch),
                           @"Server": @(OCTIconServer),
                           @"Settings": @(OCTIconSettings),
                           @"LogIn": @(OCTIconLogIn),
                           @"LogOut": @(OCTIconLogOut),
                           @"Split": @(OCTIconSplit),
                           @"Squirrel": @(OCTIconSquirrel),
                           @"Star": @(OCTIconStar),
                           @"Steps" : @(OCTIconSteps),
                           @"Stop": @(OCTIconStop),
                           @"Sync": @(OCTIconSync),
                           @"Tag": @(OCTIconTag),
                           @"Telescope": @(OCTIconTelescope),
                           @"Terminal": @(OCTIconTerminal),
                           @"ThreeBars": @(OCTIconThreeBars),
                           @"Tools": @(OCTIconTools),
                           @"Trashcan": @(OCTIconTrashcan),
                           @"TriangleDown": @(OCTIconTriangleDown),
                           @"TriangleLeft": @(OCTIconTriangleLeft),
                           @"TriangleRight": @(OCTIconTriangleRight),
                           @"TriangleUp": @(OCTIconTriangleUp),
                           @"Unfold": @(OCTIconUnfold),
                           @"Unmute": @(OCTIconUnmute),
                           @"Versions": @(OCTIconVersions),
                           @"X": @(OCTIconX),
                           @"Zap": @(OCTIconZap),
                           };
    }
    return enumDictionary;
}
@end
