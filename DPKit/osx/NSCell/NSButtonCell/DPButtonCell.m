//
// Created by Dani Postigo on 2/8/14.
//

#import "DPButtonCell.h"

#define SNRButtonCheckboxTextOffset               3.f
#define SNRButtonCheckboxCheckmarkColor           [NSColor colorWithDeviceWhite:0.780 alpha:1.000]
#define SNRButtonCheckboxCheckmarkLeftOffset      4.f
#define SNRButtonCheckboxCheckmarkTopOffset       1.f
#define SNRButtonCheckboxCheckmarkLineWidth       2.f

static NSString *const SNRButtonReturnKeyEquivalent = @"\r";


@implementation DPButtonCell {
    NSBezierPath *__bezelPath;
    NSButtonType __buttonType;
}

@synthesize textFont;
@synthesize textColor;
@synthesize cornerRadius;

@synthesize highlightOverlayColor;

@synthesize buttonGradient;
@synthesize buttonBorderColor;
@synthesize buttonHighlightColor;
@synthesize buttonDropShadow;
@synthesize buttonTitleShadow;
@synthesize buttonDisabledAlpha;

@synthesize checkboxTitleShadow;

@synthesize checkboxCheckmarkShadow;

- (id) initWithCoder: (NSCoder *) coder {
    self = [super initWithCoder: coder];
    if (self) {
        [self setup];
    }

    return self;
}

#define SNRButtonBlueTextShadowColor              [NSColor colorWithDeviceWhite:0.000 alpha:0.600]
#define SNRButtonBlueGradientBottomColor          [NSColor colorWithDeviceRed:0.000 green:0.310 blue:0.780 alpha:1.000]
#define SNRButtonBlueGradientTopColor             [NSColor colorWithDeviceRed:0.000 green:0.530 blue:0.870 alpha:1.000]

- (void) setup {
    cornerRadius = 3.0;
    buttonDisabledAlpha = 0.7;
    __buttonType = (NSButtonType) [[self valueForKey: @"buttonType"] unsignedIntegerValue];

    [self setupColors];

}

- (void) setupColors {
    BOOL drawBlueButton = YES;
    if (drawBlueButton) {

        NSColor *topColor = [NSColor colorWithDeviceRed: 0.0 green: 0.53 blue: 0.87 alpha: 1.0];
        NSColor *bottomColor = [NSColor colorWithDeviceRed: 0.0 green: 0.31 blue: 0.78 alpha: 1.0];

        buttonHighlightColor = [NSColor colorWithDeviceWhite: 1.0 alpha: 0.25];
        buttonGradient = [[NSGradient alloc] initWithStartingColor: bottomColor endingColor: topColor];

        self.buttonTitleShadow.shadowColor = SNRButtonBlueTextShadowColor;
        buttonTitleShadow.shadowBlurRadius = 2.0;
    }
}

- (void) setButtonType: (NSButtonType) aType {
    __buttonType = aType;
    [super setButtonType: aType];
}

- (void) drawWithFrame: (NSRect) cellFrame inView: (NSView *) controlView {
    if (!self.isEnabled) CGContextSetAlpha([[NSGraphicsContext currentContext] graphicsPort], self.buttonDisabledAlpha);

    [super drawWithFrame: cellFrame inView: controlView];

    if (__bezelPath && self.isHighlighted) {
        [self.highlightOverlayColor set];
        [__bezelPath fill];
    }
}

- (void) drawBezelWithFrame: (NSRect) frame inView: (NSView *) controlView {
    [self drawButtonBezelWithFrame: frame inView: controlView];
}

- (NSRect) drawTitle: (NSAttributedString *) title withFrame: (NSRect) frame inView: (NSView *) controlView {
    switch (__buttonType) {
        case NSSwitchButton:
            return [self drawCheckboxTitle: title withFrame: frame inView: controlView];
            break;
        default:
            return [self drawButtonTitle: title withFrame: frame inView: controlView];
            break;
    }
}

- (void) drawImage: (NSImage *) image withFrame: (NSRect) frame inView: (NSView *) controlView {
    if (__buttonType == NSSwitchButton) {
        [self drawCheckboxBezelWithFrame: frame inView: controlView];
    }
}

- (void) drawButtonBezelWithFrame: (NSRect) frame inView: (NSView *) controlView {
    NSShadow *dropShadow = self.buttonDropShadow;

    frame = NSInsetRect(frame, 0.5f, 0.5f);
    frame.size.height -= dropShadow.shadowBlurRadius;

    __bezelPath = [NSBezierPath bezierPathWithRoundedRect: frame xRadius: self.cornerRadius yRadius: self.cornerRadius];

    NSGradient *gradientFill = self.buttonGradient;
    // Draw the gradient fill
    [gradientFill drawInBezierPath: __bezelPath angle: 270.f];

    // Draw the border and drop shadow
    [NSGraphicsContext saveGraphicsState];
    [self.buttonBorderColor set];

    [dropShadow set];
    [__bezelPath stroke];
    [NSGraphicsContext restoreGraphicsState];

    // Draw the highlight line around the top edge of the pill
    // Outset the width of the rectangle by 0.5px so that the highlight "bleeds" around the rounded corners
    // Outset the height by 1px so that the line is drawn right below the border
    NSRect highlightRect = NSInsetRect(frame, -0.5f, 1.f);

    // Make the height of the highlight rect something bigger than the bounds so that it won't show up on the bottom
    highlightRect.size.height *= 2.f;
    [NSGraphicsContext saveGraphicsState];
    NSBezierPath *highlightPath = [NSBezierPath bezierPathWithRoundedRect: highlightRect xRadius: self.cornerRadius yRadius: self.cornerRadius];
    [__bezelPath addClip];
    [self.buttonHighlightColor set];
    [highlightPath stroke];
    [NSGraphicsContext restoreGraphicsState];
}

- (NSRect) drawButtonTitle: (NSAttributedString *) title withFrame: (NSRect) frame inView: (NSView *) controlView {
    NSString *label = title.string;

    NSShadow *textShadow = self.buttonTitleShadow;

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: self.textFont, NSFontAttributeName, self.textColor, NSForegroundColorAttributeName, textShadow, NSShadowAttributeName, nil];
    NSAttributedString *attrLabel = [[NSAttributedString alloc] initWithString: label attributes: attributes];

    NSSize labelSize = attrLabel.size;
    NSRect labelRect = NSMakeRect(NSMidX(frame) - (labelSize.width / 2.f), NSMidY(frame) - (labelSize.height / 2.f), labelSize.width, labelSize.height);
    [attrLabel drawInRect: NSIntegralRect(labelRect)];
    return labelRect;
}

- (void) drawCheckboxBezelWithFrame: (NSRect) frame inView: (NSView *) controlView {
    // At this time the checkbox uses the same style as the black button so we can use that method to draw the background
    frame.size.width -= 2.f;
    frame.size.height -= 1.f;
    [self drawButtonBezelWithFrame: frame inView: controlView];

    // Draw the checkmark itself
    if (self.state == NSOffState) {
        return;
    }

    NSBezierPath *path = [self checkmarkPathForRect: frame mixed: [self state] == NSMixedState];
    [path setLineWidth: SNRButtonCheckboxCheckmarkLineWidth];
    [SNRButtonCheckboxCheckmarkColor set];

    NSShadow *shadow = self.checkboxCheckmarkShadow;

    [NSGraphicsContext saveGraphicsState];
    [shadow set];
    [path stroke];
    [NSGraphicsContext restoreGraphicsState];
}

- (NSRect) drawCheckboxTitle: (NSAttributedString *) title withFrame: (NSRect) frame inView: (NSView *) controlView {
    NSString *label = [title string];

    NSShadow *textShadow = self.checkboxTitleShadow;

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: self.textFont, NSFontAttributeName, self.textColor, NSForegroundColorAttributeName, textShadow, NSShadowAttributeName, nil];
    NSAttributedString *attrLabel = [[NSAttributedString alloc] initWithString: label attributes: attributes];
    NSSize labelSize = attrLabel.size;
    NSRect labelRect = NSMakeRect(frame.origin.x + SNRButtonCheckboxTextOffset, NSMidY(frame) - (labelSize.height / 2.f), labelSize.width, labelSize.height);
    [attrLabel drawInRect: NSIntegralRect(labelRect)];
    return labelRect;
}

#pragma mark - Private

- (BOOL) isBlueButton {
    return [[self keyEquivalent] isEqualToString: SNRButtonReturnKeyEquivalent] && (__buttonType != NSSwitchButton);
}


#pragma mark Utility


- (NSBezierPath *) checkmarkPathForRect: (NSRect) rect mixed: (BOOL) mixed {
    NSBezierPath *path = [NSBezierPath bezierPath];
    if (mixed) {
        NSPoint left = NSMakePoint(rect.origin.x + SNRButtonCheckboxCheckmarkLeftOffset, round(NSMidY(rect)));
        NSPoint right = NSMakePoint(NSMaxX(rect) - SNRButtonCheckboxCheckmarkLeftOffset, left.y);
        [path moveToPoint: left];
        [path lineToPoint: right];
    } else {
        NSPoint top = NSMakePoint(NSMaxX(rect), rect.origin.y);
        NSPoint bottom = NSMakePoint(round(NSMidX(rect)), round(NSMidY(rect)) + SNRButtonCheckboxCheckmarkTopOffset);
        NSPoint left = NSMakePoint(rect.origin.x + SNRButtonCheckboxCheckmarkLeftOffset, round(bottom.y / 2.f));
        [path moveToPoint: top];
        [path lineToPoint: bottom];
        [path lineToPoint: left];
    }
    return path;
}

#define SNRButtonBlackHighlightColor              [NSColor colorWithDeviceWhite:1.000 alpha:0.050]
#define SNRButtonBlackGradientBottomColor         [NSColor colorWithDeviceWhite:0.150 alpha:1.000]
#define SNRButtonBlackGradientTopColor            [NSColor colorWithDeviceWhite:0.220 alpha:1.000]



#pragma mark Button colors


- (NSColor *) buttonBorderColor {
    if (buttonBorderColor == nil) buttonBorderColor = [NSColor blackColor];
    return buttonBorderColor;
}


- (NSColor *) buttonHighlightColor {
    if (buttonHighlightColor == nil) {
        buttonHighlightColor = SNRButtonBlackHighlightColor;
    }
    return buttonHighlightColor;
}


- (NSGradient *) buttonGradient {
    if (buttonGradient == nil) {
        buttonGradient = [[NSGradient alloc] initWithStartingColor: SNRButtonBlackGradientBottomColor endingColor: SNRButtonBlackGradientTopColor];
    }
    return buttonGradient;
}


- (NSShadow *) buttonDropShadow {
    if (buttonDropShadow == nil) {
        buttonDropShadow = [NSShadow new];
        buttonDropShadow.shadowColor = [NSColor colorWithDeviceWhite: 1.0 alpha: 0.05];
        buttonDropShadow.shadowBlurRadius = 1.0;
        buttonDropShadow.shadowOffset = NSMakeSize(0, -1.0);
    }
    return buttonDropShadow;
}


- (NSShadow *) buttonTitleShadow {
    if (buttonTitleShadow == nil) {
        buttonTitleShadow = [NSShadow new];
        buttonTitleShadow.shadowColor = [NSColor blackColor];
        buttonTitleShadow.shadowBlurRadius = 1.0;
        buttonTitleShadow.shadowOffset = NSMakeSize(0.0, 1.0);
    }
    return buttonTitleShadow;
}



#pragma mark Text

- (NSFont *) textFont {
    if (textFont == nil) {
        textFont = [NSFont systemFontOfSize: 11.f];
    }
    return textFont;
}


- (NSColor *) textColor {
    if (textColor == nil) textColor = [NSColor whiteColor];
    return textColor;
}

- (NSColor *) highlightOverlayColor {
    if (highlightOverlayColor == nil) highlightOverlayColor = [NSColor colorWithDeviceWhite: 0.000 alpha: 0.300];
    return highlightOverlayColor;
}


#pragma mark Other defaults




#pragma mark Getters, checkmark

#define SNRButtonCheckboxCheckmarkShadowOffset    NSMakeSize(0.f, 0.f)
#define SNRButtonCheckboxCheckmarkShadowBlurRadius 3.f
#define SNRButtonCheckboxCheckmarkShadowColor     [NSColor colorWithDeviceWhite:0.000 alpha:0.750]

- (NSShadow *) checkboxTitleShadow {
    if (checkboxTitleShadow == nil) {
        checkboxTitleShadow = [NSShadow new];
        checkboxTitleShadow.shadowColor = [NSColor blackColor];
        checkboxTitleShadow.shadowBlurRadius = 1.0;
        checkboxTitleShadow.shadowOffset = NSMakeSize(0.0, 1.0);
    }
    return checkboxTitleShadow;
}


- (NSShadow *) checkboxCheckmarkShadow {
    if (checkboxCheckmarkShadow == nil) {
        checkboxCheckmarkShadow = [NSShadow new];
        checkboxCheckmarkShadow.shadowColor = SNRButtonCheckboxCheckmarkShadowColor;
        checkboxCheckmarkShadow.shadowBlurRadius = SNRButtonCheckboxCheckmarkShadowBlurRadius;
        checkboxCheckmarkShadow.shadowOffset = SNRButtonCheckboxCheckmarkShadowOffset;

    }
    return checkboxCheckmarkShadow;
}

@end