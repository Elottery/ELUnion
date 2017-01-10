Pod::Spec.new do |spec|
    spec.name             = 'ELUnion'
    spec.version          = '0.1.9'
    spec.summary          = 'A short description of ELUnion.'
    spec.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    spec.homepage         = 'https://github.com/Elottery'
    spec.license          = { :type => 'MIT', :file => 'LICENSE' }
    spec.author           = { 'NicolasKim' => 'jinqiucheng1006@live.cn' }
    spec.source           = { :git => 'https://github.com/Elottery/ELUnion.git', :branch => spec.version}
    spec.ios.deployment_target = '8.0'
    spec.header_dir = 'ELUnion'
    spec.default_subspec = 'ELUIKit'
    spec.subspec 'ELFoundation' do |cs|
        cs.prefix_header_contents = '#import <Foundation/Foundation.h>'
        cs.frameworks = 'CoreData'
        cs.user_target_xcconfig = { 'OTHER_LDFLAGS' => '-ObjC -all_load','CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'}
        cs.source_files = 'ELUnion/ELFoundation/Classes/**/*.{h,m}'
        cs.public_header_files = 'ELUnion/ELFoundation/Classes/**/*.{h}'
        cs.resources = ['ELUnion/ELFoundation/Classes/ELSocket/SocketDBModel.xcdatamodeld'];
        cs.dependency 'AFNetworking/Serialization'
        cs.dependency 'AFNetworking/Security'
        cs.dependency 'AFNetworking/Reachability'
        cs.dependency 'AFNetworking/NSURLSession'
        cs.dependency 'JSONModel', '~> 1.2.0'
        cs.dependency 'HYFileManager'
        cs.dependency 'CocoaAsyncSocket', '~> 7.5.0'
        cs.dependency 'ELUnion/ThirdLib'
    end
    spec.subspec 'ThirdLib' do |cs|
        cs.frameworks = 'SystemConfiguration','CoreGraphics','CoreTelephony','Security','CoreLocation','JavaScriptCore','CoreData','CFNetwork','UIKit','Foundation'
        cs.libraries  = 'iconv','sqlite3','stdc++','z'
        cs.subspec 'Wechat' do |css|
            css.source_files = ['ELUnion/ELFoundation/Lib/WXApi.h','ELUnion/ELFoundation/Lib/WechatAuthSDK.h','ELUnion/ELFoundation/Lib/WXApiObject.h']
            css.library = 'WeChatSDK'
            css.preserve_paths = 'ELUnion/ELFoundation/Lib/libWeChatSDK.a'
            css.vendored_library  = 'ELUnion/ELFoundation/Lib/libWeChatSDK.a'
        end
        cs.subspec 'BaiduMob' do |css|
            css.library = 'BaiduMobStat'
            css.source_files = 'ELUnion/ELFoundation/Lib/BaiduMobStat.h'
            css.preserve_paths = 'ELUnion/ELFoundation/Lib/libBaiduMobStat.a'
            css.vendored_library  = 'ELUnion/ELFoundation/Lib/libBaiduMobStat.a'
            end
        cs.subspec 'Tencent' do |css|
            css.preserve_paths = 'ELUnion/ELFoundation/Lib/TencentOpenAPI.framework'
            css.vendored_frameworks = 'ELUnion/ELFoundation/Lib/TencentOpenAPI.framework'
        end
    end
    spec.subspec 'ELUIKit' do |cs|
        cs.prefix_header_contents = '#import <UIKit/UIKit.h>'
        cs.resource_bundles = {'Imgs'   => ['ELUnion/ELUIKit/Assets/Images/*'],
                               'Others' => ['ELUnion/ELUIKit/Assets/Xib/*'],
                               'TOCropViewControllerBundle'=> ['ELUnion/ELUIKit/Assets/Strings/*']}
        cs.source_files =  ['ELUnion/ELUIKit/Classes/**/*.{h,m}']
        cs.private_header_files = ['ELUnion/ELUIKit/Classes/Category/ELBundleHelper.h',
                                   'ELUnion/ELUIKit/Classes/VIEW/ELActionSheet/ELShareActionSheetCell.h',
                                   'ELUnion/ELUIKit/Classes/VIEW/ELActionSheet/ELShareActionSheet.h',
                                   'ELUnion/ELUIKit/Classes/VIEW/ELActionSheet/ELActionSheet.h']
        cs.dependency      'ELUnion/ELFoundation'
        cs.dependency      'SDWebImage'
        cs.dependency      'DYMRollingBanner', '~> 2.1.7'
        cs.dependency      'MBProgressHUD'
        cs.dependency      'MJRefresh', '~> 3.1.10'     
    end
end
