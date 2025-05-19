function SystemUtil()
  local self = {}

  local function judgeIgnoreBattery()
    import "android.content.Context"

    isIgnoring = false
    powerManager = activity.getSystemService(Context.POWER_SERVICE);
    if powerManager ~= nil then
      isIgnoring = powerManager.isIgnoringBatteryOptimizations(activity.getPackageName());
    end
    return isIgnoring
  end

  local function ignoreBattery()
    if not judgeIgnoreBattery() then
      showToast("下载功能需要后台运行权限！")
      if pcall(function()
          import "android.net.Uri"
          import "android.content.Intent"
          import "android.provider.Settings"
          intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
          intent.setData(Uri.parse("package:" .. activity.getPackageName()));
          this.startActivity(intent);

        end) then
       else
        showToast("下载功能需要后台运行权限，跳转失败，请手动设置！")
      end
    end
  end

  local function parseColor(value)
    if type(value) == "string" then
      return Color.parseColor(value)
     else
      return value
    end
  end

  local function setStatusBarColor(bar_color)
    value = parseColor(bar_color)
    window = activity.getWindow()
    window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(value);
  end

  local function setStatusBarDark()

    if Build.VERSION.SDK_INT >= 23 then
      activity.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
      -- activity.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN)
    end
  end

  local function setNavigationBarLight()
    local decorView = activity.getWindow().getDecorView();
    decorView.setSystemUiVisibility(decorView.getSystemUiVisibility() & ~View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR)
  end

  local function setStatusBarLight()

    if Build.VERSION.SDK_INT >= 23 then
      local decorView = activity.getDecorView()
      -- activity.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN)
      decorView.setSystemUiVisibility(decorView.getSystemUiVisibility() & ~View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);

    end
  end

  local function setNavigationBarDark()
    activity.getWindow().decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR
  end
  local function judgeMobile(width,height)
    if width > height then
      return false
     else
      return true
    end
  end

  local function getCopyContent()
    local clipboard = activity.getSystemService(Context.CLIPBOARD_SERVICE)
    if Build.VERSION.SDK_INT >= 29 then
      -- 使用新的API
      local clipData = clipboard.getPrimaryClip()
      if clipData and clipData.getItemCount() > 0 then
        local item = clipData.getItemAt(0)
        -- 在这里处理剪贴板上的文本
        local content = item.getText()
        return content -- 调用请删除提示
      end
     else
      -- 使用旧的API
      return clipboard.getText() -- 调用请删除  提示
    end
  end

  local function backToSystemHome()
    import "android.content.Intent"
    local home = Intent(Intent.ACTION_MAIN);
    home.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
    home.addCategory(Intent.CATEGORY_HOME);
    activity.startActivity(home);
  end

  local function killApp()
    import "android.os.Process"
    Process.killProcess(Process.myPid())
  end

  local function setAppHide()
    -- 上一次按下返回键的时间戳
    local lastBackTime = 0
    -- 处理返回键按下事件
    function onKeyDown(code, event)
      -- 首先判断参数是否为空
      if code == nil or event == nil then
        return
      end
      -- 如果按下的是返回键
      if code == 4 and tostring(event):find("KEYCODE_BACK") then
        -- 获取当前时间戳
        local currentTime = tonumber(os.time())

        -- 如果距离上一次按下返回键的时间小于2秒
        if currentTime - lastBackTime > 2 then
          -- 提示再按一次返回键退出

          print("再按一次返回键退出")
          lastBackTime = currentTime
         else
          -- 如果距离上一次按下返回键的时间大于等于2秒，退出应用
          backToSystemHome()
        end
        return true
      end
    end

  end
  local function hideTitleBar()
    if activity.getSupportActionBar and activity.getSupportActionBar() then
      --print(activity.getSupportActionBar())
      activity.getSupportActionBar()
      .hide()
     elseif activity.getActionBar and activity.getActionBar() then
      activity.getActionBar().hide()
     else
      activity.setTheme(android.R.style.Theme_Material_NoActionBar)
      -- print("hide title bar error")

    end
  end

  function copyContent(tt, msg)

    import "android.content.Context"
    import "android.content.ClipData"

    if Build.VERSION.SDK_INT >= 29 then
      clipboard = this.getSystemService(Context.CLIPBOARD_SERVICE);
      clipboard.setPrimaryClip(ClipData.newPlainText("text", tostring(tt)));


     else
      this.getSystemService(Context.CLIPBOARD_SERVICE).setText(tostring(tt))

    end

    if msg and type(msg)=="string" then
      showToast(msg)
     else
      if type(msg)=="boolean" then
        if msg then
          showToast("复制成功！")
         else

        end
       else
        showToast("复制成功！")
      end
    end

  end
  local function keepScreenOn()
    activity.getWindow().setFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON,
    WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

  end
  local function hideStatusBar()
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
  end

  local function showStatusBar()
    activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
  end
  local function hideNavigationBar()
    -- activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION)
    activity.getWindow().getDecorView().setSystemUiVisibility(
    View.SYSTEM_UI_FLAG_HIDE_NAVIGATION | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)
    -- activity.getWindow().attributes.systemUiVisibility =
    -- View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY or View.SYSTEM_UI_FLAG_FULLSCREEN

  end
  local function getCurrentBattery()
    return activity.getApplicationContext().registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    .getIntExtra("level", 0)
  end

  -- 获取当前屏幕亮度值
  local function getScreenBrightness()
    local windowAttr = activity.getWindow().getAttributes()
    if windowAttr.screenBrightness < 0 then
      -- 小于0为系统默认亮度,返回预设值
      return 0.5 * 100
     else
      return windowAttr.screenBrightness * 100
    end
  end

  -- 设置屏幕亮度
  local function setScreenBrightness(brightness)
    local windowAttr = activity.getWindow().getAttributes()
    -- 设置新的亮度值
    windowAttr.screenBrightness = brightness / 100
    -- 应用新的窗口属性对象
    activity.getWindow().setAttributes(windowAttr)
  end
  local AudioManager = luajava.bindClass "android.media.AudioManager"
  function getVolume()
    return tointeger(100 *
    activity.getSystemService(Context.AUDIO_SERVICE).getStreamVolume(AudioManager.STREAM_MUSIC) /
    activity.getSystemService(Context.AUDIO_SERVICE)
    .getStreamMaxVolume(AudioManager.STREAM_MUSIC))
  end

  function setVolume(value)
    activity.getSystemService(Context.AUDIO_SERVICE).setStreamVolume(AudioManager.STREAM_MUSIC, tonumber(value) /
    100 * activity.getSystemService(Context.AUDIO_SERVICE).getStreamMaxVolume(AudioManager.STREAM_MUSIC), 0)
  end



  function shareFile(path,mimeType)
    import "android.os.Build$VERSION"
    import "android.net.Uri"
    import "android.content.Intent"
    import "android.webkit.MimeTypeMap"
    import "java.io.File"

    xpcall(function()--原谅我，我怕有人明明没 androidx 库就运行
      import "androidx.core.content.FileProvider"
      end,function()
      import "android.content.FileProvider"
    end)

    local FileName=tostring(File(path).Name)
    --获取文件名称
    local ExtensionName=FileName:match("%.(.+)")
    --获取文件名后缀
    local Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
    --获取文件的 mimetype
    if not Mime then
      Mime="text/plain"
    end
    if mimeType then
      Mime=mimeType
    end

    intent = Intent()--新建一个 Intent 用于调用其他应用
    intent.setAction(Intent.ACTION_SEND)

    file = File(path)--File 对象

    if VERSION.SDK_INT >= 24 then--判断 Android 版本 (若 Android 版本高于 7.0 或 等于 7.0
      uri = FileProvider.getUriForFile(this, this.getPackageName(),file)
     else
      uri = Uri.fromFile(file)
    end

    intent.setDataAndType(uri,Mime)
    --可查阅 http://t.csdn.cn/zO5GH 找到您要分享文件的 mimetype
    intent.putExtra(Intent.EXTRA_STREAM,uri)
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

    activity.startActivity(Intent.createChooser(intent, "分享到:"))
    --开始活动

  end



  return {
    getVolume = getVolume,
    setVolume = setVolume,
    getScreenBrightness = getScreenBrightness,
    setScreenBrightness = setScreenBrightness,
    hideTitleBar = hideTitleBar,
    hideNavigationBar = hideNavigationBar,
    parseColor = parseColor,
    setStatusBarColor = setStatusBarColor,
    setStatusBarDark = setStatusBarDark,
    setStatusBarLight = setStatusBarLight,
    setNavigationBarLight = setNavigationBarLight,
    setNavigationBarDark = setNavigationBarDark,
    judgeMobile = judgeMobile,
    getCopyContent = getCopyContent,
    backToSystemHome = backToSystemHome,
    killApp = killApp,
    setAppHide = setAppHide,
    copyContent = copyContent,
    keepScreenOn = keepScreenOn,
    hideStatusBar = hideStatusBar,
    showStatusBar = showStatusBar,
    getCurrentBattery = getCurrentBattery,
    judgeIgnoreBattery = judgeIgnoreBattery,
    ignoreBattery = ignoreBattery,
    shareFile=shareFile
  }
end