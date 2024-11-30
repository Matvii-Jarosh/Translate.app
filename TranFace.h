@interface TranFace: NSWindow
{  
  NSScrollView *fromTextScrollView;
  NSTextView *fromText;
  NSScrollView *toTextScrollView;
  NSTextView *toText;
  NSButton *trButton;
  NSButton *spButton;
  NSPopUpButton *fromPopUp;
  NSPopUpButton *toPopUp;
}
- (void) translateText: (id) sender;
- (void) speechText: (id) sender;
- (void)applicationDidFinishLaunching: (NSNotification *)aNotification;
@end
