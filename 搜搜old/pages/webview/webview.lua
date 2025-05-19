require("import");
import("common.BaseActivity");
import "pages.webview.layout"

import "pages.webview.WebHeartUtil"
import "pages.webview.WebHisUtil"
import "pages.webview.WebUrlUtil"

import "com.xunlei.downloadlib.XLTaskHelper";

webHisUtli = WebHisUtil()
webHeartUtil = WebHeartUtil()
webUrlUtil = WebUrlUtil()

activity.setContentView(layout);

XLTaskHelper.init(this);

webSearchHis = webHisUtli.getHistorys()
webHts = webHeartUtil.getHearts()
webUrls = webUrlUtil.getHistorys()
webDefaultUrl = nil
isPop = false
resDatas = {}
resPop = false
searchPop = false
menuPop=false
toolPop=false
searchTipDatas = {}
html = ""
icon=""
navUrl=...
fullscreen=false
viewSource=false
customView=false

webDefaultUrl = settingUtil.getSettingKey("webDefaultUrl", "https://xydh.fun/dieheart")
webDefaultUA = settingUtil.getSettingKey("webDefaultUA",
'Mozilla/5.0 (Linux; Android 10.1.2; Build/NJH47F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.109 Safari/537.36')

webSearchUrl = settingUtil.getSettingKey("webSearchUrl", "https://cn.bing.com/search?q=searchKey")


if navUrl and tostring(navUrl)~="nil" then

  webView.loadUrl(navUrl)
 elseif length(webUrls) > 0 then

  webTitle.setText(webUrls[1].name)
  webView.loadUrl(webUrls[1].url)
 else
  webView.loadUrl(webDefaultUrl)
end
webView.addJavascriptInterface({},"JsInterface")
webView.getSettings().setSupportZoom(true) -- 支持缩放
webView.getSettings().setBuiltInZoomControls(true); -- 支持缩放
webView.getSettings().setLoadWithOverviewMode(true); --
webView.getSettings().setDisplayZoomControls(false); -- 隐藏自带的右下角缩放控件

webView.getSettings().setLoadsImagesAutomatically(true); -- 图片自动加载
webView.getSettings().setUseWideViewPort(true) -- 图片自适应

webView.setHorizontalScrollBarEnabled(false) -- 设置是否显示水平滚动条
-- webView.setVerticalScrollbarOverlay(true)--设置垂直滚动条是否有叠加样式
-- webView.setScrollBarStyle(webView.SCROLLBARS_OUTSIDE_OVERLAY)--设置滚动条的样式
webView.setVerticalScrollBarEnabled(false); -- 垂直不显示

webView.getSettings().setDomStorageEnabled(true); -- dom储存数据
webView.getSettings().setDatabaseEnabled(true); -- 数据库
webView.getSettings().setAppCacheEnabled(true); -- 启用缓存
--webView.getSettings().setCacheMode(webView.getSettings().LOAD_CACHE_ELSE_NETWORK); -- 设置缓存加载方式
webView.getSettings().setAllowFileAccess(true); -- 允许访问文件
webView.getSettings().setSaveFormData(true); -- 保存表单数据，就是输入框的内容，但并不是全部输入框都会储存
webView.getSettings().setAllowContentAccess(true); -- 允许访问内容
webView.getSettings().setJavaScriptEnabled(true); -- 支持js脚本
-- webView.getSettings().supportMultipleWindows() --设置多窗口
webView.setLayerType(View.LAYER_TYPE_HARDWARE, nil); -- 硬件加速
webView.getSettings().setPluginsEnabled(true) -- 支持插件
webView.getSettings().setJavaScriptCanOpenWindowsAutomatically(true); -- //支持通过JS打开新窗口

webView.getSettings().setUserAgentString(webDefaultUA) -- 设置浏览器标识(UA)
webView.getSettings().setDefaultTextEncodingName("utf-8") -- 设置编码格式
webView.getSettings().setTextZoom(100) -- 设置字体大小:100表示正常,120表示文字放大1.2倍
webView.getSettings().setAcceptThirdPartyCookies(true) -- 接受第三方cookie
webView.getSettings().setSafeBrowsingEnabled(true) -- 安全浏览
webView.getSettings().setGeolocationEnabled(true); -- 启用地理定位

home.onClick = function()
  webDefaultUrl = settingUtil.getSettingKey("webDefaultUrl", "https://xydh.fun/dieheart")
  webView.loadUrl(webDefaultUrl)
  webView.clearHistory()
end

flush.onClick = function()
  webView.reload()
end

-- 状态监听
webView.setWebViewClient {
  shouldOverrideUrlLoading = function(view, url)
    -- Url即将跳转
    resDatas = {}
    res.setVisibility(View.GONE)
    resNum.setText(tostring(length(resDatas)))

    if startsWith(url, 'magnet:') or startsWith(url, 'thunder:') or startsWith(url, 'ed2k:') or startsWith(url, 'ftp:')then

      local site={}
      site.name="temp"
      site.type="temp"
      local fileName =XLTaskHelper.instance().getFileName(url)

      if not fileName or tostring(fileName)=="nil" or #tostring(fileName)<1 then
        fileName=tostring(os.time())
      end
      activity.newActivity("pages/play/play", {{site, {["标题"]=fileName,["地址"]=url}}})
      return true
    end



  end,
  onPageStarted = function(view, url, favicon)
    -- 网页即将加载
    resDatas = {}
    res.setVisibility(View.GONE)
    resNum.setText(tostring(length(resDatas)))
    webTitle.setText(webView.getTitle()) -- 获取网页标题
  end,
  onPageFinished = function(view, url)
    -- 网页加载完成

    webTitle.setText(webView.getTitle()) -- 获取网页标题

    view.evaluateJavascript(
    "function getSource(){return \"<html>\"+document.getElementsByTagName('html')[0].innerHTML+\"</html>\";};getSource();", {
      onReceiveValue = function(result)
        html = result:gsub("%%", "%%;"):gsub("\\\\n", "%%n"):gsub("\\\\t", "%%t"):gsub("\\n", "\n"):gsub("\\t", "\t"):gsub(
        "%%n", "\\n"):gsub("%%t", "\\t"):gsub("%%;", "%%"):gsub("\\u003C", "<"):gsub("\\\"", "\""):gsub("^\"", ""):gsub(
        "\"$", "")
        -- print(result)


        icon=""
        local hisItem = {}
        hisItem.name = webView.getTitle()
        hisItem.url = webView.getUrl()
        hisItem.time = tostring(os.date("%Y-%m-%d %H:%M:%S", os.time()))


        local icon1=matchonce([[rel="icon" href="(.-)"]],html)
        local icon2=matchonce([[rel="shortcut icon" href="(.-)"]],html)
        if #tostring(icon1)>#tostring(icon2) then
          icon=icon1
         else
          icon=icon2
        end
        if icon and #icon>3 then
          if not startsWith(icon, "http") then
            local root = Uri.parse(webView.getUrl()).authority
            icon = "http://" .. root .. icon
          end
        end
        hisItem.icon = icon
        webUrlUtil.setHistory(hisItem)


        -- local magnets=matchall(">(magnet:.-)<",html)

        local magnets=matchall([["(magnet:[^"]-)">([^>]-)<]],html)


        if magnets then


          res.setVisibility(View.VISIBLE)
          for k,v in pairs(magnets)do
            if #v[1]>10 then
              local fileName =v[2]
              -- XLTaskHelper.instance().getFileName(v)


              if not fileName or tostring(fileName)=="nil" or #tostring(fileName)<1 then
                fileName=tostring(os.time())
              end
              table.insert(resDatas, {
                ["name"] = fileName,
                ["url"] = v[1]
              })

              resNum.setText(tostring(length(resDatas)))
            end
          end
        end

        magnets=matchall([["(magnet:[^"]+)"]],html)

        local function isHave(url)
          for k,v in pairs(resDatas) do
            if v.url==url then
              return false
            end
          end
          return true
        end

        if magnets then
          res.setVisibility(View.VISIBLE)
          for k,v in pairs(magnets)do
            if #v>10 and isHave(v)then

              local fileName =XLTaskHelper.instance().getFileName(v)
              if not fileName or tostring(fileName)=="nil" or #tostring(fileName)<1 then
                fileName=tostring(os.time())
              end
              table.insert(resDatas, {
                ["name"] = fileName,
                ["url"] = v
              })

              resNum.setText(tostring(length(resDatas)))
            end
          end
        end

        if length(resDatas)==0 then
          res.setVisibility(View.GONE)
        end


        local ftps=matchall([["(ftp:.-)"]],html)
        --  local ftps=matchall([[>(ftp://.-)<]],html)

        if ftps then
          res.setVisibility(View.VISIBLE)

          for k,v in pairs(ftps)do
            local fileName = XLTaskHelper.instance().getFileName(v)


            if not fileName or tostring(fileName)=="nil" or #tostring(fileName)<3 then
              fileName=tostring(os.time())
            end
            table.insert(resDatas, {
              ["name"] = fileName,
              ["url"] = v
            })

            resNum.setText(tostring(length(resDatas)))
          end
        end
        local thunders=matchall([["(thunder:.-)"]],html)
        if thunders then
          res.setVisibility(View.VISIBLE)

          for k,v in pairs(thunders)do
            local fileName = XLTaskHelper.instance().getFileName(v)


            if not fileName or tostring(fileName)=="nil" or #tostring(fileName)<3 then
              fileName=tostring(os.time())
            end
            table.insert(resDatas, {
              ["name"] = fileName,
              ["url"] = v
            })

            resNum.setText(tostring(length(resDatas)))
          end
        end
        local ed2ks=matchall([["(ed2k:.-)"]],html)
        if ed2ks then
          res.setVisibility(View.VISIBLE)
          for k,v in pairs(ed2ks)do
            local fileName = XLTaskHelper.instance().getFileName(v)


            if not fileName or tostring(fileName)=="nil" or #tostring(fileName)<3 then
              fileName=tostring(os.time())
            end
            table.insert(resDatas, {
              ["name"] = fileName,
              ["url"] = v
            })

            resNum.setText(tostring(length(resDatas)))

          end
        end

      end
    })


  end,
  onReceivedError = function(view, code, des, url)
    -- 网页加载失败
  end,
  onLoadResource = function(view, tarurl)

    -- 加载页面资源时
    if ((tarurl:find 'mp4') or (tarurl:find '/video/') or (tarurl:find 'm3u8') or (tarurl:find "flv")) and not endswith(tarurl, ".php") and
      not endswith(tarurl, ".js") and not tarurl:find "url=http"
      and not endswith(tarurl, ".css")
      and not endswith(tarurl, ".jpg")
      and not endswith(tarurl, ".png")
      and not endswith(tarurl, ".ico")
      and not endswith(tarurl, ".woff2")


      and not endswith(tarurl, ".jpeg")

      and not endswith(tarurl, ".gif")
      then
      -- print(tarurl)
      res.setVisibility(View.VISIBLE)
      local fileName = XLTaskHelper.instance().getFileName(tarurl)


      if not fileName or tostring(fileName)=="nil" or #tostring(fileName)<2 then
        fileName=tostring(os.time())
      end
      table.insert(resDatas, {
        ["name"] = fileName,
        ["url"] = tarurl
      })
      resNum.setText(tostring(length(resDatas)))
    end

  end,
  shouldInterceptRequest = function(view, url)
    -- 加载url制定的资源
  end,
  onReceivedSslError = function(view, handler, err)
    -- 加载SSL证书错误时
  end

}


xwebchromeclient=luajava.override(luajava.bindClass "android.webkit.WebChromeClient", {
  onReceivedTitle = function(super, view, title)
    -- 获取到网页标题
  end,
  onReceivedIcon = function(super, view, title)
    -- 获取到网页图标
  end,
  onProgressChanged = function(super,view, progress)
    -- 页面加载进度
  end,

  onShowCustomView=function(super,view,callback)

    -- 设置跟随传感方向
    local ActivityInfo = luajava.bindClass "android.content.pm.ActivityInfo"
    activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR)
    --保存view供之后退出全屏时移除
    customView = view
    --覆盖在根布局上面
    local FrameLayout = luajava.bindClass "android.widget.FrameLayout"
    local Gravity = luajava.bindClass "android.view.Gravity"
    local lp = FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT)
    activity.addContentView(view,lp)
    systemUtil.hideNavigationBar()
    function 判断有无导航栏()
      local hasMenuKey = ViewConfiguration.get(this).hasPermanentMenuKey();
      local hasBackKey = KeyCharacterMap.deviceHasKey(KeyEvent.KEYCODE_BACK);
      if (!hasMenuKey && !hasBackKey) then
        导航状态 = true;
       else
        导航状态 = false;
      end
      return 导航状态;
    end


    function 全屏()
      window = activity.getWindow();
      window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
      window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
      xpcall(function()
        lp = window.getAttributes();
        lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
        window.setAttributes(lp);
      end,
      function(e)
      end)
      activity.setTheme(android.R.style.Theme_Material_NoActionBar)
    end

    function 屏幕沉浸(color1, color2)

      import("android.view.WindowManager")
      activity.setTheme(android.R.style.Theme_Material_NoActionBar)
      if Build.VERSION.SDK_INT < 21 then
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xff000000)
       elseif 判断有无导航栏() then
        activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE)
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(color1).setNavigationBarColor(color2)
       else
        activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE)
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(color1).setNavigationBarColor(color2)
      end
    end

    function 消除虚拟按键()

      activity.overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
      this.getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
      if Build.VERSION.SDK_INT > 11 and Build.VERSION.SDK_INT < 19 then
        activity.getWindow().getDecorView().setSystemUiVisibility(View.GONE)
       elseif Build.VERSION.SDK_INT >= 19 then
        activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY | View.SYSTEM_UI_FLAG_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION)
      end
    end


    全屏()
    屏幕沉浸(0,0)
    消除虚拟按键()
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

    fullscreen=true
  end,
  onHideCustomView=function(super)
    if isMobile then
      activity.setRequestedOrientation(1) -- 0横屏，1竖屏
     else
      activity.setRequestedOrientation(0)
    end

    --移除view
    customView.getParent().removeView(customView)
    --变量置空
    customView = nil


    xpcall(function()
      lp = window.getAttributes();
      lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_NEVER;
      window.setAttributes(lp);
      end, function(e)
    end)
    --[=[  import "android.graphics.Color"  ]=]
    local window = activity.getWindow()
    window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_VISIBLE);

    --[=[  window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
    window.setStatusBarColor(Color.BLACK)  ]=]
    -- activity.getWindow().setStatusBarColor(0xffffffff);
    activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)


    local window = activity.getWindow()
    window.setStatusBarColor(0xffffffff)
    window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
    window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
    window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
    window.setNavigationBarColor(0xffffffff)

    fullscreen=false
  end,



})
webView.setWebChromeClient(xwebchromeclient)

webView.setDownloadListener {
  onDownloadStart = function(url, userAgent, contentDisposition, mimetype, contentLength)
    -- 即将下载文件时(链接,UA,处理,类型,大小)

  end

}


webView.onLongClick=function()
  local WebView = luajava.bindClass "android.webkit.WebView"
  --print(webView.getContentHeight())
  --print(webView.onCheckIsTextEditor())
  local htr=webView.getHitTestResult()
  --print(htr.getType(),htr.getExtra())
  --通过type获得点击的类型，这里以图片为例
  if htr.getType()==WebView.HitTestResult.IMAGE_TYPE then
    --  local imageName=htr.getExtra():match("^.+/(.-)$")
    --  print(htr.getExtra())
    --自己去下载就完事了，不会的话，参考我的WebView各种下载项目


   elseif htr.getType()==WebView.HitTestResult.EDIT_TEXT_TYPE then
    --  local imageName=htr.getExtra():match("^.+/(.-)$")
    --
   elseif htr.getType()==WebView.HitTestResult.SRC_ANCHOR_TYPE then
    --  local imageName=htr.getExtra():match("^.+/(.-)$")
    --
    -- print(htr.getExtra())
    local site={}
    site.name="temp"
    site.type="temp"
    local fileName =XLTaskHelper.instance().getFileName(htr.getExtra())

    if not fileName or tostring(fileName)=="nil" or #tostring(fileName)<1 then
      fileName=tostring(os.time())
    end
    activity.newActivity("pages/play/play", {{site, {["标题"]=fileName,["地址"]=htr.getExtra()}}})
    return true

   elseif htr.getType()==WebView.HitTestResult.UNKNOWN_TYPE then
    --  local imageName=htr.getExtra():match("^.+/(.-)$")
    --
    -- print(htr.getExtra())


  end


end






close.onClick = function()

  activity.finish()
end

-- 处理资源弹窗
import "pages.webview.dealResEvent"

-- 处理搜索事件
import "pages.webview.dealSearchEvent"

-- 处理返回事件
import "pages.webview.dealBackEvent"

-- 处理菜单工具栏事件
import "pages.webview.dealMenuEvent"


function onDestroy()
  local parent = webView.getParent();
  if parent then

    parent.removeView(webView)
  end

  webView.stopLoading();

  webView.getSettings().setJavaScriptEnabled(false);
  webView.clearHistory();
  webView.clearView();
  webView.removeAllViews();
  webView.destroy()

  import"com.sousou.utils.CacheUtils"

  CacheUtils().clearCache(this)



end
