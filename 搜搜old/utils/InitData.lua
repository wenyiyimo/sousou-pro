require "vinx.core.Import"
import "utils.UpdateApp"
import "utils.SiteUtil"
import "utils.DownloadUtil"
SiteUtil().initSites()
--UpdateApp()

-- downloadUtil.startTasks({{url="https://sf16-sg.larksuitecdn.com/obj/tos-alisg-ve-0051c001-sg/oQ1QAIfjAAuqGoe92LeRfWGFKbhV4IMl2mxxrD?filename=1.mp4",name="84",pic=null,group="凡人修仙传"}})
import "com.baidu.mobstat.StatService" -- 导入baidu统计所需类
StatService() -- 百度移动统计部分
.setAppKey("4779d9e4fd") -- 此处写入您的AppKey
.start(this) -- 启动服务



task(200, function()

  if File("/sdcard/Download/搜搜/download").exists() and getFolderSize("/sdcard/Download/搜搜/download") >
    2400000000 then
    os.execute("rm -rf /sdcard/Download/搜搜/download")
    File("/sdcard/Download/搜搜/download").mkdirs()
   else
    File("/sdcard/Download/搜搜/download").mkdirs()
  end

  downloadUtil = DownloadUtil()
  downloadUtil.init()
end)



--检查剪切板权限
import "androidx.core.app.ActivityCompat"
import "android.Manifest"
import "androidx.core.content.ContextCompat"
import "android.content.pm.PackageManager"

function hasClipboardPermission()
  return ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE)
  == PackageManager.PERMISSION_GRANTED;

end

if not hasClipboardPermission() then
  ActivityCompat.requestPermissions(
  this,
  {Manifest.permission.READ_EXTERNAL_STORAGE},
  100);
  showToast("请授予剪切版权限，否则部分功能无法使用。")
end