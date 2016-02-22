//
// UIViewController+TopViewController.m
// Copyright (c) 2015 Dmitry Lizin (sdkdimon@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIViewController+TopViewController.h"

@implementation UIViewController (TopViewController)
//extension UIViewController {
//
//    static func topViewController(viewController: UIViewController? = nil) -> UIViewController? {
//        let viewController = viewController ?? UIApplication.sharedApplication().keyWindow?.rootViewController
//
//        if let navigationController = viewController as? UINavigationController
//            where !navigationController.viewControllers.isEmpty
//        {
//            return self.topViewController(navigationController.viewControllers.last)
//        } else if let tabBarController = viewController as? UITabBarController,
//            selectedController = tabBarController.selectedViewController
//        {
//            return self.topViewController(selectedController)
//        } else if let presentedController = viewController?.presentedViewController {
//            return self.topViewController(presentedController)
//        }
//
//        return viewController
//    }
//}

+(UIViewController *)topViewController:(UIViewController *)viewController{
    
    viewController = viewController != nil ? viewController : [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    if([viewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *navigationController = (UINavigationController *)viewController;
        NSArray <UIViewController *> *viewControllers = [navigationController viewControllers];
        NSInteger viewControllerLastIdx = [viewControllers count] - 1;
        if(viewControllerLastIdx >= 0)
        {
            return [self topViewController:[viewControllers objectAtIndex:viewControllerLastIdx]];
        }
    }else if([viewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self topViewController:[tabBarController selectedViewController]];
    } else {
        UIViewController *presentedViewController = [viewController presentedViewController];
        if(presentedViewController != nil){
            return [self topViewController:presentedViewController];
        }
    }
    return viewController;
}


@end
