//
//  StoreViewController.h
//  Cambio
//
//  Created by Paul Castronova on 7/7/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import "StoreViewController.h"
#import "AppDelegate.h"
#import "BookObject.h"

@implementation StoreViewController

@synthesize m_pBookShelfListArray;

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    m_fScreenWidth = screenRect.size.width;
    m_fScreenHeight = screenRect.size.height;
    
    m_fMainScale = 1.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        m_fMainScale = 2.0;
    }
    
    [self.view setBackgroundColor:kBackMainColor];
    
    [self updateNavTitleView];
    [self getBookShelfList];
    [self addBookshelfList];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (void)updateNavTitleView
{
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.2, m_fScreenWidth*0.05)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -m_fScreenWidth*0.005, m_fScreenWidth*0.035, m_fScreenWidth*0.06)];
    [navTitleView addSubview:titleImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(m_fScreenWidth*0.04, 0, m_fScreenWidth*0.14, m_fScreenWidth*0.05)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"Shop"];
    [titleLabel setFont:[UIFont systemFontOfSize:16*m_fMainScale]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navTitleView addSubview:titleLabel];
    
    self.navigationItem.titleView = navTitleView;
}



- (void) getBookShelfList
{
    if (m_pBookShelfListArray == NULL) {
        m_pBookShelfListArray = [[NSMutableArray alloc] init];
    }
    else {
        [m_pBookShelfListArray removeAllObjects];
    }
    
    for (int i = 0; i < 9; i++) {
        BookObject *oneBookObject = [[BookObject alloc] init];
        oneBookObject.m_pBookDescString = @"The story revolves around a girl called Little Red Riding Hood. The girl walks through the woods to deliver food to her sickly grandmother(wine and cake depending on the translation). In the Grimm's version, she had the order from her mother to stay";

  
                switch (i) {
                    case 0:
                        oneBookObject.m_pBookTitleString = @"Little Red Riding-Hood";
                        oneBookObject.m_pBookIconImageString = @"LRRH.png";
                        oneBookObject.m_pBookImageString = @"LRRH_dialog.png";
                        oneBookObject.m_pBookPriceString = @"$4.99";
                        break;
                    case 1:
                        oneBookObject.m_pBookTitleString = @"The Frog Prince";
                        oneBookObject.m_pBookIconImageString = @"FP.png";
                        oneBookObject.m_pBookImageString = @"FP_dialog.png";
                        oneBookObject.m_pBookPriceString = @"$4.99";
                        break;
                    case 2:
                        oneBookObject.m_pBookTitleString = @"The Emperor's New Clothes";
                        oneBookObject.m_pBookIconImageString = @"ENC.png";
                        oneBookObject.m_pBookImageString = @"ENC_dialog.png";
                        oneBookObject.m_pBookPriceString = @"$4.99";
                        break;
                    case 3:
                        oneBookObject.m_pBookTitleString = @"Hansel and Gretel";
                        oneBookObject.m_pBookIconImageString = @"HG.png";
                        oneBookObject.m_pBookImageString = @"HG_dialog.png";
                        oneBookObject.m_pBookPriceString = @"$4.99";
                        break;
                    case 4:
                        oneBookObject.m_pBookTitleString = @"Shoemaker and the Elves";
                        oneBookObject.m_pBookIconImageString = @"SE.png";
                        oneBookObject.m_pBookImageString = @"SE_dialog.png";
                        oneBookObject.m_pBookPriceString = @"$4.99";
                        break;
                    case 5:
                        oneBookObject.m_pBookTitleString = @"Peter Rabbit";
                        oneBookObject.m_pBookIconImageString = @"PR.png";
                        oneBookObject.m_pBookImageString = @"PR_dialog.png";
                        oneBookObject.m_pBookPriceString = @"$4.99";
                        break;
                    case 6:
                        oneBookObject.m_pBookTitleString = @"Sleeping Beauty";
                        oneBookObject.m_pBookIconImageString = @"SB.png";
                        oneBookObject.m_pBookImageString = @"SB_dialog.png";
                        oneBookObject.m_pBookPriceString = @"$4.99";
                        break;
                    case 7:
                        oneBookObject.m_pBookTitleString = @"Rumplestiltskin";
                        oneBookObject.m_pBookIconImageString = @"RN.png";
                        oneBookObject.m_pBookImageString = @"RN_dialog.png";
                         oneBookObject.m_pBookPriceString = @"$4.99";
                        break;
                    case 8:
                        oneBookObject.m_pBookTitleString = @"The Three Little Pigs";
                        oneBookObject.m_pBookIconImageString = @"TLP.png";
                        oneBookObject.m_pBookImageString = @"TLP_dialog.png";
                        oneBookObject.m_pBookPriceString = @"$4.99";
                        break;

        }
        
        [m_pBookShelfListArray addObject:oneBookObject];
    }
}

- (void) addBookshelfList
{
    _scrollView.frame = CGRectMake(0, m_fControlPanelHeight, m_fScreenWidth, m_fScreenHeight-m_fControlPanelHeight);
    
    int rowCount = 3;
    CGFloat imageWidth = m_fScreenWidth*0.28;
    CGFloat imageHeight = m_fScreenWidth*0.28;
    CGFloat imageXoffset = m_fScreenWidth*0.05;
    CGFloat imageYoffset = m_fScreenHeight*0.15;
    
    int  bookCount = (int)[m_pBookShelfListArray count];
    if (bookCount == 0) {
        return;
    }
    
    for (int i = 0; i < bookCount; i++) {
        
        BookObject *oneBookObject = [m_pBookShelfListArray objectAtIndex:i];
        
        UIButton *bookImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bookImageButton addTarget:self action:@selector(bookImageButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        [bookImageButton setBackgroundImage:[UIImage imageNamed:oneBookObject.m_pBookIconImageString] forState:UIControlStateNormal];
        [bookImageButton setTag:i];
        
        [bookImageButton setFrame:CGRectMake(m_fScreenWidth*0.03 + (imageWidth+imageXoffset) * (i%rowCount), m_fScreenHeight*0.05 + (imageHeight+imageYoffset) * (i/rowCount),
                                             imageWidth, imageHeight)];
        
        [_scrollView addSubview:bookImageButton];
        
        UILabel *bookTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageWidth, m_fScreenWidth*0.1)];
        bookTitleLabel.center = CGPointMake(bookImageButton.center.x, bookImageButton.center.y + imageHeight*0.7);
        [bookTitleLabel setTextColor:[UIColor blackColor]];
        [bookTitleLabel setFont:[UIFont systemFontOfSize:12*m_fMainScale]];
        [bookTitleLabel setText:oneBookObject.m_pBookTitleString];
        bookTitleLabel.textAlignment = NSTextAlignmentCenter;
        bookTitleLabel.numberOfLines = 0;
        bookTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [_scrollView addSubview:bookTitleLabel];
        
        UILabel *bookPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageWidth, m_fScreenWidth*0.1)];
        bookPriceLabel.center = CGPointMake(bookImageButton.center.x, bookTitleLabel.center.y + m_fScreenWidth*0.1);
        [bookPriceLabel setTextColor:[UIColor redColor]];
        [bookPriceLabel setText:oneBookObject.m_pBookPriceString];
        [bookPriceLabel setFont:[UIFont systemFontOfSize:12*m_fMainScale]];
        bookPriceLabel.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:bookPriceLabel];
    }
}

#pragma mark - custom alert

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

- (UIView *)createDemoView:(int)nBookIdx
{
    BookObject *oneBookObject = [m_pBookShelfListArray objectAtIndex:nBookIdx];
    
    UIView *bookView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.7, m_fScreenWidth*1.3)];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.7, m_fScreenWidth*0.5)];
    [titleImageView setImage:[UIImage imageNamed:oneBookObject.m_pBookImageString]];
    [bookView addSubview:titleImageView];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(closeButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"dialog_close_button.png"] forState:UIControlStateNormal];
    [closeButton setFrame:CGRectMake(m_fScreenWidth*0.63, m_fScreenWidth*0.02, m_fScreenWidth*0.05, m_fScreenWidth*0.05)];
    [bookView addSubview:closeButton];
    
    UILabel *bookTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.6, m_fScreenWidth*0.2)];
    bookTitleLabel.center = CGPointMake(titleImageView.center.x, titleImageView.center.y + m_fScreenWidth*0.38);
    bookTitleLabel.numberOfLines = 0;
    bookTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [bookTitleLabel setTextColor:[UIColor blackColor]];
    [bookTitleLabel setText:oneBookObject.m_pBookTitleString];
    [bookTitleLabel setFont:[UIFont boldSystemFontOfSize:20*m_fMainScale]];
    bookTitleLabel.textAlignment = NSTextAlignmentCenter;
    [bookView addSubview:bookTitleLabel];
    
    UILabel *bookDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.6, m_fScreenWidth*0.4)];
    bookDescLabel.center = CGPointMake(bookTitleLabel.center.x, bookTitleLabel.center.y + m_fScreenWidth*0.22);
    bookDescLabel.numberOfLines = 0;
    bookDescLabel.textAlignment = NSTextAlignmentLeft;
    [bookDescLabel setTextColor:[UIColor blackColor]];
    [bookDescLabel setText:oneBookObject.m_pBookDescString];
    [bookDescLabel setFont:[UIFont systemFontOfSize:10*m_fMainScale]];
    bookDescLabel.textAlignment = NSTextAlignmentLeft;
    [bookView addSubview:bookDescLabel];
    
    UILabel *bookPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.6, m_fScreenWidth*0.2)];
    bookPriceLabel.center = CGPointMake(titleImageView.center.x, m_fScreenWidth*1.05);
    [bookPriceLabel setTextColor:[UIColor redColor]];
    [bookPriceLabel setText:oneBookObject.m_pBookPriceString];
    [bookPriceLabel setFont:[UIFont boldSystemFontOfSize:24*m_fMainScale]];
    bookPriceLabel.textAlignment = NSTextAlignmentCenter;
    [bookView addSubview:bookPriceLabel];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton addTarget:self action:@selector(buyButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"store_buy_button.png"] forState:UIControlStateNormal];
    [buyButton setFrame:CGRectMake(m_fScreenWidth*0.21, m_fScreenWidth*1.14, m_fScreenWidth*0.275, m_fScreenWidth*0.1125)];
    [bookView addSubview:buyButton];
    
    return bookView;
}

#pragma mark - button actions

- (void) bookImageButtonCliked:(UIButton*)sender
{
    int nBookIndex = (int)sender.tag;
    
    // Here we need to pass a full frame
    m_pAlertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [m_pAlertView setContainerView:[self createDemoView:nBookIndex]];
    
    // Modify the parameters
    [m_pAlertView setButtonTitles:NULL];
    [m_pAlertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [m_pAlertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [m_pAlertView setUseMotionEffects:true];
    
    // And launch the dialog
    [m_pAlertView show];
}

- (void) closeButtonCliked:(UIButton*)sender
{
    if (m_pAlertView) {
        [m_pAlertView close];
    }
}

- (void) buyButtonCliked:(UIButton*)sender
{

}

- (IBAction)onClickPriceButton:(id)sender
{
    
}

- (IBAction)onClickCategoriesButton:(id)sender
{
    
}


@end
