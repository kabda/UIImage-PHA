# UIImage-PHA
UIImage-PHA是UIImage的一个Category，用于比较两个UIImage的相似度，使用OC实现；

##基于感知哈希算法
[感知哈希算法](http://baike.baidu.com/link?url=WZeSauV-SeUHmE1V7h62_JPWVT60ASC6JDarS9HUD211xH1ccihsBafsOmupyZ8zHmZ6U54m_QhmcrHPZA743a)(简称PHA)是哈希算法的一类, 主要用来做相似图片的搜索工作。

##运算原理
 1. 缩小尺寸, 快速去除高频和细节, 只保留结构明暗;
 2. 简化色彩, 将图片转为64级灰度图;
 3. 计算平均值, 比较像素的灰度(大于或等于平均值, 记为1; 小于平均值, 记为0);
 4. 计算哈希值并比较相似度(理论上, 不相同的数据位不超过5, 就说明两张图片很相似; 如果大于10, 就说明这是两张不同的图片);

##使用方法
快速比较：

``` Object-C
NSInteger differentValue = [UIImage differentValueCountWithImage:image1 andAnotherImage:image2];
NSInteger differentValue = [image1 differentValueCountWithdAnotherImage:image2];
```

自定义比较:

``` Object-C
NSString *pHashString1 = [image1 pHashStringValueWithSize:CGSizeMake(8.0, 8.0)];
NSString *pHashString2 = [image2 pHashStringValueWithSize:CGSizeMake(8.0, 8.0)];
NSInteger differentValue = [UIImage differentValueCountWithString:pHashString1 andString:pHashString2];
```

##CocoaPods
`pod 'UIImage+PHA', '~> 0.0.3'`
