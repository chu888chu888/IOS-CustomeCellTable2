
#import "MSMenuCell.h"

@implementation MSMenuCell

#pragma mark - UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:18.0];
        UIView *selectedBackgroundView = [UIView new];
        //selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
        self.selectedBackgroundView = selectedBackgroundView;
    }
    return self;
}

@end
