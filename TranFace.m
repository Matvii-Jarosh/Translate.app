#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "TranFace.h"
#import "TranModule.h"
#import "Speech.h"

#define ADD_TO_WINDOW(gui_el) [[self contentView] addSubview: gui_el]; \
  [gui_el release];

@implementation TranFace: NSWindow

// Init Face of app
-(id)init
{
  // ADD LABELS
  NSTextField *fromLabel = [[NSTextField alloc] initWithFrame: NSMakeRect(10, 470, 50, 20)];
  [fromLabel setEditable: NO];
  [fromLabel setSelectable: NO];
  [fromLabel setBezeled: NO];
  [fromLabel setBordered: NO];
  [fromLabel setDrawsBackground: NO];
  [fromLabel setAlignment: NSCenterTextAlignment];
  [fromLabel setStringValue: @"From:"];

  NSTextField *toLabel = [[NSTextField alloc] initWithFrame: NSMakeRect(250, 470, 50, 20)];
  [toLabel setEditable: NO];
  [toLabel setSelectable: NO];
  [toLabel setBezeled: NO];
  [toLabel setBordered: NO];
  [toLabel setDrawsBackground: NO];
  [toLabel setAlignment: NSCenterTextAlignment];
  [toLabel setStringValue: @"To:"];
  
  // ADD FROM SCROLL VIEW
  fromTextScrollView = [[NSScrollView alloc] initWithFrame: NSMakeRect(10, 260, 475, 200)]; 
  [fromTextScrollView setHasHorizontalScroller: YES];
  [fromTextScrollView setHasVerticalScroller: YES];
  [fromTextScrollView setBorderType: NSBezelBorder];
  [fromTextScrollView setDrawsBackground: YES];

  // ADD FROM TEXT
  fromText = [[NSTextView alloc] initWithFrame: NSMakeRect(10, 230, 450, 225)];
  [fromText setEditable: YES];
  [fromText setMaxSize: NSMakeSize(FLT_MAX, FLT_MAX)];
  [fromText setVerticallyResizable:YES];
  [fromText setHorizontallyResizable:YES];

  // ADD FROM TEXT TO FROM SCROLL VIEW
  [fromTextScrollView setDocumentView: fromText];

  // ADD TO SCROLL VIEW
  toTextScrollView = [[NSScrollView alloc] initWithFrame: NSMakeRect(10, 0, 475, 200)]; 
  [toTextScrollView setHasHorizontalScroller: YES];
  [toTextScrollView setHasVerticalScroller: YES];
  [toTextScrollView setBorderType: NSBezelBorder];
  [toTextScrollView setDrawsBackground: YES];

  // ADD TO TEXT
  toText = [[NSTextView alloc] initWithFrame: NSMakeRect(10, 230, 450, 225)];
  [toText setEditable: NO];
  [toText setSelectable: YES];
  [toText setMaxSize: NSMakeSize(FLT_MAX, FLT_MAX)];
  [toText setVerticallyResizable:YES];
  [toText setHorizontallyResizable:YES];

  // ADD TO TEXT TO TO SCROLL VIEW
  [toTextScrollView setDocumentView: toText];

  // ADD TRANSLATE BUTTON
  trButton = [[NSButton alloc] initWithFrame: NSMakeRect(140, 215, 100, 30)];
  [trButton setTitle: @"Translate text"];
  [trButton setAction:@selector(translateText:)];

  // ADD SPEECH BUTTON
  spButton = [[NSButton alloc] initWithFrame: NSMakeRect(260, 215, 100, 30)];
  //[spButton setButtonType: NSOnOffButton];
  [spButton setTitle: @"Speech text"];
  [spButton setAction:@selector(speechText:)];

  // ADD POP UPS
  NSArray *langTitles = [[NSArray alloc] initWithObjects: @"en", @"ru", @"fr", @"de", @"uk", @"es", @"pt", nil];
  
  fromPopUp = [[NSPopUpButton alloc] initWithFrame: NSMakeRect(100, 470, 100, 20)];
  [fromPopUp addItemsWithTitles: langTitles];

  toPopUp = [[NSPopUpButton alloc] initWithFrame: NSMakeRect(350, 470, 100, 20)];
  [toPopUp addItemsWithTitles: langTitles];
  [toPopUp selectItemAtIndex: 1];

  [self initWithContentRect: NSMakeRect (100, 100, 500, 500)
		  styleMask: (NSTitledWindowMask | NSMiniaturizableWindowMask)
		    backing: NSBackingStoreBuffered
		      defer: NO];

  ADD_TO_WINDOW(fromTextScrollView);
  ADD_TO_WINDOW(toTextScrollView);
  ADD_TO_WINDOW(fromLabel);
  ADD_TO_WINDOW(toLabel);
  ADD_TO_WINDOW(trButton);
  ADD_TO_WINDOW(spButton);
  ADD_TO_WINDOW(fromPopUp);
  ADD_TO_WINDOW(toPopUp);
  
  [self setTitle: @"Translate.app"];
  [self center];

  return self;
}

// Seeting Menu
- (void)applicationDidFinishLaunching: (NSNotification *)aNotification
{
  NSMenu *mainMenu;
  NSMenu *menu;
  NSMenuItem *menuItem;

  mainMenu = AUTORELEASE ([NSMenu new]);
  
  // Info
  [mainMenu addItemWithTitle: @"Info" 
		      action: @selector (orderFrontStandardInfoPanel:) 
	       keyEquivalent: @""];
  // Edit
  menuItem = [mainMenu addItemWithTitle: @"Edit" 	
				 action: NULL 
			  keyEquivalent: @""];
  menu = AUTORELEASE ([NSMenu new]);
  [mainMenu setSubmenu: menu forItem: menuItem];
  
  [menu addItemWithTitle: @"Cut" 
		  action: @selector (cut:) 
	   keyEquivalent: @"x"];
  
  [menu addItemWithTitle: @"Copy" 
		  action: @selector (copy:) 
	   keyEquivalent: @"c"];
   
  [menu addItemWithTitle: @"Paste" 
		  action: @selector (paste:) 
	   keyEquivalent: @"v"];
  
  [menu addItemWithTitle: @"SelectAll" 
		  action: @selector (selectAll:) 
	   keyEquivalent: @"a"];

  [mainMenu addItemWithTitle: @"Hide" 
		      action: @selector (hide:) 
	       keyEquivalent: @"h"];  
  [mainMenu addItemWithTitle: @"Quit" 
		      action: @selector (terminate:)
	       keyEquivalent: @"q"];	

  // Add manu option
  [NSApp setMainMenu: mainMenu];
  
  [self orderFront: self];
}

- (void) translateText: (id) sender
{
  NSString *trText = [TranModule translate: [fromText text]
				  fromLang: [fromPopUp titleOfSelectedItem]
				    toLang: [toPopUp titleOfSelectedItem]];  
  [toText setText: trText];
}

- (void) speechText: (id) sender
{
  [Speech playSpeech: sender
		text: [toText text]];
}
@end
