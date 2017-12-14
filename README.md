# SYPopGesture
一键解决pop手势问题

## 支持
*支持自定义leftButtonItem造成的pop手势不可用
*支持VC中包含UIScrollView相关view造成的pop手势不可用
## 如子视图包含UIScrollView UICollectionView UIPageViewController MapView UISlider等，造成的返回手势不可用都可以解决
*支持侧滑和全屏返回手势
*支持不同vc的使用不同的手势操作

## 安装
* 将UIViewController+SYPopGesture 扩展拖入工程，导入头文件 #import "UIViewController+SYPopGesture.h",即可使用

## 使用方式
* 默认是侧滑手势
* 设置为全屏pop手势    self.sy_isFullPopGesture = YES;
* 设置手势不可用       self.sy_interactivePopDisabled = YES;
  


