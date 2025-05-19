require("import");
import("common.BaseActivity");
import("pages.download.layout");
import "utils.HistoryUtil"
activity.setContentView(media_layout);
import "utils.DownloadUtil"
downloadUtil = DownloadUtil()
historyUtil = HistoryUtil()
downloads = downloadUtil.getDownloads()
seekbar.ProgressDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP))
seekbar.Thumb.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP))
function ProgressStyle()
  local self = {
    total = activity.width,
    numProgress1 = 0,
    numProgress2 = 0
  }
  local function setMax(num)
    self.total = num
  end

  local function setProgress(num)
    progress1.setTranslationX(num * (activity.width + 30) / self.total)
    if num > self.numProgress2 then
      progress2.setTranslationX(num * (activity.width + 30) / self.total)
      self.numProgress2 = num
    end
    self.numProgress1 = num
  end
  local function setVisibility(v)
    cardProgress1.setVisibility(v)
    cardProgress2.setVisibility(v)
  end
  local function setSecondaryProgress(num)
    -- progress2.setTranslationX(num*activity.width/self.total)
    -- self.numProgress2=num
    if num < self.numProgress1 then
      self.numProgress2 = self.numProgress1

     else
      self.numProgress2 = num
    end
    progress2.setTranslationX(self.numProgress2 * (activity.width + 30) / self.total)
  end

  return {
    setProgress = setProgress,
    setSecondaryProgress = setSecondaryProgress,
    setVisibility = setVisibility,
    setMax = setMax
  }
end
progress = ProgressStyle()
progress.setVisibility(View.GONE)

videos = {...}
trueUrl=videos[1]
bodyIndex = videos[4]
historys = historyUtil.getHistorys()
function getHisInit()

  local temp ={}
  temp[1]=downloads[bodyIndex].site
  temp[2]={['标题']=downloads[bodyIndex]["标题"],['图片']=downloads[bodyIndex]["图片"],['地址']=downloads[bodyIndex]["地址"],['状态']=downloads[bodyIndex]["状态"]}

  temp[3] = {
    ["标题"] = temp[2]["标题"]
  }
  hisNum = historyUtil.getHistoryNum(temp)
  if hisNum > 0 then

    historys = historyUtil.setHistory(historys[hisNum])
  end
end




adapter = LuaCustRecyclerAdapter(AdapterCreator({

  getItemCount = function()

    return #downloads
  end,

  getItemViewType = function(position)
    return 0
  end,

  onCreateViewHolder = function(parent, viewType)
    local views = {}
    holder = LuaCustRecyclerHolder(loadlayout(bodyitemout, views))
    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder = function(holder, position)
    -- print(hearts[position+1][1])
    view = holder.view.getTag()

    view.titleout.text = downloads[position + 1]['标题']
    local name = downloads[position + 1].playName
    -- if startsWith("/") then
    --     name = replace(name, "/", "")
    -- else
    --     name = replace(name, "/", "-")
    -- end
    name = replace(name, "/", " ")
    view.nameout.text = name
    local progress = downloads[position + 1].progress
    if not progress then
      progress = "0/0"
    end
    local state = downloads[position + 1].state
    if state ~= "下载中" then
      progress = state
    end

    view.progressout.text = progress
    if bodyIndex==position+1 then
      view.nameout.textColor=ColorStyles().blue
     else
      view.nameout.textColor=ColorStyles().white
    end
    view.bodyCard.onClick=function ()
      if downloads[position + 1].state == "等待中" then
        showToast("该视频未下载！")
       elseif downloads[position + 1].state == "下载中" then
        showToast("边下边播中！")
        trueUrl = downloadUtil.getPlayUrl(downloads[position + 1].savePath)
        bodyIndex=position+1
        initPlayer(trueUrl)
       elseif downloads[position + 1].state == "已完成" then
        trueUrl = downloadUtil.getPlayUrl(downloads[position + 1].savePath)
        bodyIndex=position+1
        initPlayer(trueUrl)

       else
        showToast("该视频错误！")
      end
      adapter.notifyDataSetChanged()
    end
  end
}))



function nextPlayVideo()

  if downloads[bodyIndex + 1] then
    bodyIndex = bodyIndex + 1

    
    if endsWith(downloads[bodyIndex].savePath,"torrent") then

      showToast("种子文件不支持播放，已自动跳过！")

      return nextPlayVideo()
    end



    adapter.notifyDataSetChanged()
    playLoading.setVisibility(View.VISIBLE)

    if downloads[bodyIndex].state == "等待中" then
      showToast("该视频未下载！")
     elseif downloads[bodyIndex].state == "下载中" then
      showToast("边下边播中！")
      trueUrl = downloadUtil.getPlayUrl(downloads[bodyIndex].savePath)

      initPlayer(trueUrl)
     elseif downloads[bodyIndex].state == "已完成" then
      trueUrl = downloadUtil.getPlayUrl(downloads[bodyIndex].savePath)

      initPlayer(trueUrl)

     else
      showToast("该视频错误！")
    end

   else
    showToast("已经是最后一集啦！")
    playPause.setVisibility(View.GONE)
    playStart.setVisibility(View.VISIBLE)
    --showToast("播放完毕！")
    activity.finish()
  end
end

function lastPlayVideo()
  if downloads[bodyIndex - 1] then

    bodyIndex = bodyIndex - 1
    if endsWith(downloads[bodyIndex].savePath,"torrent") then

      showToast("种子文件不支持播放，已自动跳过！")

      return lastPlayVideo()
    end


    if downloads[bodyIndex].state == "等待中" then
      showToast("该视频未下载！")
     elseif downloads[bodyIndex].state == "下载中" then
      showToast("边下边播中！")
      trueUrl = downloadUtil.getPlayUrl(downloads[bodyIndex].savePath)

      initPlayer(trueUrl)
     elseif downloads[bodyIndex].state == "已完成" then
      trueUrl = downloadUtil.getPlayUrl(downloads[bodyIndex].savePath)

      initPlayer(trueUrl)

     else
      showToast("该视频错误！")
    end
    adapter.notifyDataSetChanged()
   else
    showToast("已经是第一集啦！")
    playPause.setVisibility(View.GONE)
    playStart.setVisibility(View.VISIBLE)
  end
end


import "androidx.media3.exoplayer.SimpleExoPlayer"
import "androidx.media3.exoplayer.DefaultLoadControl"
import "androidx.media3.datasource.DefaultDataSourceFactory"
import "androidx.media3.common.util.Util"
import "androidx.media3.common.C"
import "androidx.media3.exoplayer.hls.HlsMediaSource"
import "androidx.media3.exoplayer.source.ProgressiveMediaSource"
import "androidx.media3.exoplayer.dash.DashMediaSource"
import "androidx.media3.exoplayer.smoothstreaming.SsMediaSource"
import "androidx.media3.common.MediaItem"
import "androidx.media3.common.Player"
import "androidx.media3.common.PlaybackParameters"
import "androidx.media3.exoplayer.SeekParameters"

import "androidx.media3.datasource.DefaultDataSource"
import "androidx.media3.datasource.cache.SimpleCache"
import "androidx.media3.datasource.cache.CacheDataSource"
import "androidx.media3.datasource.DefaultHttpDataSource"
import "androidx.media3.datasource.cache.LeastRecentlyUsedCacheEvictor"
import "java.io.File";


pauseFlag = false
fullScreenFlag = false
prepared = false
seekFlag = false
controlFlag = false
playRateFlag = false
selectPlayFlag = false
longClickFlag = false
brightFlag = false
progressFlag = false
volumeFlag = false
playRate = 1
videoMode = 0
videoDuration = 0
playCurrent = 0
skipStart = 0
skipEnd = 0
-- hisSkipFlag = true
Hfullflag=true


function getSeekNum(num)
  getHisInit()
  local hisSeekNum = 0
  if #historys > 0 and historys[1][3]['标题'] == downloads[bodyIndex]['标题'] and
    historys[1][3]['播放'] == downloads[bodyIndex].playName and videoDuration + 10000 > historys[1][3]['时长'] and videoDuration -
    10000 < historys[1][3]['时长'] and videoDuration-historys[1][3]['进度'] >3000 then

    hisSeekNum = historys[1][3]['进度']
    -- hisSkipFlag = false
    -- print(hisSeekNum)
    if historys[1][3]["速度"] then
      playRate=historys[1][3]["速度"]
    end

   else

  end
  return math.max(num, skipStart, hisSeekNum)
end

rate_datas = {{"x0.50", 0.5}, {"x1.00", 1}, {"x1.25", 1.25}, {"x1.50", 1.5}, {"x1.75", 1.75}, {"x2.00", 2},
  {"x2.50", 2.5}}

function setPlayRate(num)
  if prepared then
    local sparams = PlaybackParameters(tonumber(num));
    videoPlayer.setPlaybackParameters(sparams);

    if num ~= 1 then
      msgRateText.setText("x" .. tostring(num) .. "倍速")
      if setting.showPlayRate or longclickflag then
        msgRate.setVisibility(View.VISIBLE)
       else
        msgRate.setVisibility(View.GONE)
      end
     else
      msgRate.setVisibility(View.GONE)
    end
  end
end

videoPlayRateout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
rate_adapter = LuaCustRecyclerAdapter(AdapterCreator({
  getItemCount = function()
    return #rate_datas
  end,
  getItemViewType = function(position)
    return 0
  end,
  onCreateViewHolder = function(parent, viewType)
    local views = {}
    holder = LuaCustRecyclerHolder(loadlayout(rateItem, views))
    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder = function(holder, position)
    view = holder.view.getTag()
    view.rate.text = rate_datas[position + 1][1]
    if playRate == rate_datas[position + 1][2] then
      view.rate.textColor = ColorStyles().blue
     else
      view.rate.textColor = ColorStyles().white
    end

    view.rate.onClick = function()
      playRate = rate_datas[position + 1][2]
      rate_adapter.notifyDataSetChanged()
      setPlayRate(playRate)
    end
  end
}))
videoPlayRateout.setAdapter(rate_adapter)

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




function setPlayFullscreen()
  --activity.setTheme(android.R.style.Theme_Black_NoTitleBar_Fullscreen)

  --activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION)
  -- body_dialog.dismiss()
  local sparam = frame.getLayoutParams()
  sparam.width = -1
  sparam.height = -1
  frame.setLayoutParams(sparam)
  fullScreenFlag = true
  -- activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)
  -- activity.getWindow().getAttributes().layoutInDisplayCutoutMode = 1
  -- activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
  activity.setTheme(android.R.style.Theme_Black_NoTitleBar_Fullscreen)

  全屏()
  屏幕沉浸(0,0)
  消除虚拟按键()

  -- 防止手机休眠
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
  autoRotate(videoWidth, videoHeight)
  if controlFlag then
    showFullControl()
  end
end

function exitPlayFullscreen()
  fullScreenFlag = false
  --   playV.setVisibility(View.GONE)
  --   playH.setVisibility(View.VISIBLE)

  local sparam = frame.getLayoutParams()
  sparam.height = height * 0.25
  sparam.width = width
  frame.setLayoutParams(sparam)
  if isMobile then
    activity.setRequestedOrientation(1) -- 0横屏，1竖屏
   else
    activity.setRequestedOrientation(0)
  end
  -- body_dialog.showAtLocation(view, Gravity.BOTTOM, 0, 0)
  -- body_dialog.update(view, Gravity.BOTTOM, 0, 0)
  task(200, function()
    changeSurfaceSize(videoWidth, videoHeight)
    -- body_dialog = getPopupWindow(body_layout)
  end)
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
  activity.getWindow().setStatusBarColor(0xff000000);
  activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
  if controlFlag then
    showView()
  end
  systemUtil.hideNavigationBar()
end

loadControl = DefaultLoadControl.Builder()
loadControl.setBufferDurationsMs(60000, 100000, 100, 1000)
loadControl = loadControl.build()
videoPlayer = SimpleExoPlayer.Builder(this).setLoadControl(loadControl).build()
videoPlayer.setSeekParameters(SeekParameters(5 * 1000000, 5 * 1000000))

function setNetSpeed(id)
  local function getNetSpeed(id)
    require "import"
    import "android.net.TrafficStats"
    s = TrafficStats.getTotalRxBytes()

    task(250, function()
      id.text = (TrafficStats.getTotalRxBytes() - s) * 2 / 1000 .. "k/s"
    end)
  end
  getNetSpeed(id)
  -- timer(getNetSpeed,0,1000,id)
end

function dealPlayTime(time)
  if time < 0 then
    return "00:00"
  end

  local miao = tostring(tointeger(time * 0.001 % 60))
  local fen = tostring(tointeger(time * 0.001 / 60))
  if #miao == 1 then
    miao = "0" .. miao
  end
  if #fen == 1 then
    fen = "0" .. fen
  end
  return fen .. ":" .. miao
end

function changeSurfaceSize(videoWidth, videoHeight)
  -- 获取当前活动窗口的宽度
  AWidth = frame.getWidth()
  -- 获取当前活动窗口的高度
  AHeight = frame.getHeight()

  -- 计算缩放比例，以确保视频能在给定的宽度（AWidth）和高度（AHeight）内完全显示
  -- math.min是获取较小值的函数，意味着取宽度缩放比例和高度缩放比例中的最小值，确保视频不会超出范围
  if videoMode == 0 then
    scale = math.min(AWidth / videoWidth, AHeight / videoHeight)
    scale = {
      wScale = scale,
      hScale = scale
    }
   elseif videoMode == 1 then
    scale = math.max(AWidth / videoWidth, AHeight / videoHeight)
    scale = {
      wScale = scale,
      hScale = scale
    }
   elseif videoMode == 2 then
    scale = {
      wScale = AWidth / videoWidth,
      hScale = AHeight / videoHeight
    }
  end

  -- 获取 SurfaceView 的当前布局参数
  layoutParams = surfaceView.getLayoutParams()
  -- 根据计算出的缩放比例，设置新的宽度
  layoutParams.width = videoWidth * scale.wScale
  -- 根据计算出的缩放比例，设置新的高度
  layoutParams.height = videoHeight * scale.hScale
  -- 将新的布局参数应用到 SurfaceView
  surfaceView.setLayoutParams(layoutParams)
end


cache=false
cacheFactory=false

function initPlayer(url, seekNum)

  -- if not seekNum then
  seekNum = 0
  -- end
  videoPlayer.stop()
  prepared = false
  dataSourceFactory = DefaultDataSourceFactory(this, Util.getUserAgent(this,
  "Mozilla/5.0 (Linux; Android 7.1.2; Build/NJH47F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.109 Safari/537.36"));
  if (not url:find '127.0.0') and cacheFactory then
    dataSourceFactory=cacheFactory
  end


  local uri = Uri.parse(url);
  local type = Util.inferContentType(uri, this.getIntent().getStringExtra("extension"));

  if C.TYPE_OTHER == type then
    if (url:find 'm3u8') then
      mediaSource = HlsMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(uri))

     else
      mediaSource = ProgressiveMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(uri))

    end
   elseif C.TYPE_HLS == type then
    mediaSource = HlsMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(uri))
   elseif C.TYPE_DASH == type then
    mediaSource = DashMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(uri))
   elseif C.TYPE_SS == type then
    mediaSource = SsMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(uri))
   else
    if (url:find 'm3u8') then
      mediaSource = HlsMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(uri))
     else
      mediaSource = ProgressiveMediaSource.Factory(dataSourceFactory).createMediaSource(MediaItem.fromUri(uri))

    end
  end
  videoPlayer.prepare(mediaSource);
  videoPlayer.setPlayWhenReady(true)

  videoPlayer.setVideoSurfaceView(surfaceView)

  videoPlayer.addListener(Player.Listener {
    onTimelineChanged = function(timeline, manifest)
    end,
    onTracksChanged = function(trackGroups, trackSelections)
    end,
    onLoadingChanged = function(isLoading)
      if isLoading then
        -- playLoading.setVisibility(View.VISIBLE)
       else
        -- playLoading.setVisibility(View.GONE)
      end
    end,
    onPlayerStateChanged = function(playWhenReady, playbackState)
      if playbackState == Player.STATE_ENDED then

        -- 播放完了所有的资源后处于改状态
        videoPlayer.pause()
        if prepared then
          prepared = false
          nextPlayVideo()
          --showToast("播放完毕！")
          --activity.finish()

        end
       elseif playbackState == Player.STATE_READY then

        playLoading.setVisibility(View.GONE)
        if not pauseFlag then
          playStart.setVisibility(View.GONE)
          playPause.setVisibility(View.VISIBLE)
        end

        if prepared then

         else
          videoPlayer.play()
          prepared = true
          videoWidth = videoPlayer.getVideoSize().toBundle().getInt("0")
          videoHeight = videoPlayer.getVideoSize().toBundle().getInt("1")
          --   picture.text = "picture：" .. tostring(videoWidth) .. "x" .. tostring(videoHeight)
          netWork.text=tostring(videoWidth) .. "x" .. tostring(videoHeight)
          playTitle.text=downloads[bodyIndex]['playName'].."-"..downloads[bodyIndex]['标题']
          changeSurfaceSize(videoWidth, videoHeight)
          videoDuration = videoPlayer.getDuration()
          playDurationout.text = dealPlayTime(videoDuration)
          seekbar.setMax(videoDuration)
          progress.setMax(videoDuration)

          --   if setting.autoFullScreen then
          setPlayFullscreen()
          if not controlFlag then
            if setting.showPlayProgress then
              progress.setVisibility(View.VISIBLE)
            end
          end
          --   end

          pauseFlag = false
          playStart.setVisibility(View.GONE)
          playPause.setVisibility(View.VISIBLE)
          task(200, function()
            seekNum = 0
            seekNum = getSeekNum(seekNum)

            if seekNum > 0 then
              videoPlayer.seekTo(seekNum)
            end
            setPlayRate(playRate)
          end)

        end

        --------播放器可以立即播放，是否播放取决于playWhenReady的值，该值表达了使用者的意愿，为true，将会开始播放，否则不播。
       elseif playbackState == Player.STATE_BUFFERING then
        playLoading.setVisibility(View.VISIBLE)

        --------没有足够的数据可以加载播放，此时无法立即播放
       elseif playbackState == Player.STATE_IDLE then
        --------初始状态，此时播放器没有可以播放的资源，播放器停止播放或者播放失败后也会处于该状态
      end

    end,

    onPlayerError = function(error)
      -- 播放出错 error.getMessage();
      showToast("暂不支持的视频格式:" .. tostring(error))
      videoPlayer.stop()
    end,
    onPositionDiscontinuity = function()
      -- 改变播放位置时触发
      -- print(2)
    end,
    onPlaybackParametersChanged = function(playbackParameters)
      -- 播放参数更改时触发
    end
  });

end

-- 配置网络状态刷新函数
function setNetworkState()
  import "android.net.ConnectivityManager"
  import "android.content.Context"
  -- 判断WiFi网络连接
  mWifi = activity.getSystemService(Context.CONNECTIVITY_SERVICE).getNetworkInfo(ConnectivityManager.TYPE_WIFI);
  if tostring(mWifi):find("none)") then
    WiFi = 0
   else
    WiFi = 1
  end
  -- 判断数据网络连接
  gprs = activity.getSystemService(Context.CONNECTIVITY_SERVICE).getNetworkInfo(ConnectivityManager.TYPE_MOBILE)
  .getState();
  if tostring(gprs) == "CONNECTED" then
    GPRS = 1
   else
    GPRS = 0
  end
  -- 判断网络连接状态
  if (WiFi == 0 and GPRS == 1) then
    netWork.setText('数据')
   elseif (WiFi == 1 and GPRS == 0) then
    netWork.setText('WiFi')
   else
    netWork.setText('异常')
  end
end
-- 配置播放函数
function Play()
  if prepared then
    videoPlayer.play()
    pauseFlag = false
    playStart.setVisibility(View.GONE)
    playPause.setVisibility(View.VISIBLE)
  end
end

-- 配置暂停函数
function Pause()
  -- 暂停视频
  pauseFlag = true
  videoPlayer.pause()
  playPause.setVisibility(View.GONE)
  playStart.setVisibility(View.VISIBLE)

end

-- 获取SurfaceView的Holder
holder = surfaceView.getHolder()
-- 为Holder添加回调函数
holder.addCallback(SurfaceHolder_Callback {
  -- SurfaceView创建时调用
  surfaceCreated = function(holder)
    -- 设置mediaPlayer的显示输出为holder
    videoPlayer.setVideoSurfaceHolder(holder)
    if isPlayingWhenDestroyed then
      Play()
    end
  end,
  -- SurfaceView销毁时调用
  surfaceDestroyed = function(holder)
    isPlayingWhenDestroyed = videoPlayer.isPlaying()
    if isPlayingWhenDestroyed then
      Pause()
    end
  end
})

-- 自动旋转视频
function autoRotate(videoWidth, videoHeight)

  if not videoWidth then
    showToast("视频未初始化完成！")
    return
  end
  -- 如果视频的宽度大于高度
  if videoWidth > videoHeight then
    Hfullflag=true
    playH.setVisibility(View.GONE)
    playV.setVisibility(View.VISIBLE)

    -- 将屏幕方向设置为横屏模式
    if pcall(function()



        activity.setRequestedOrientation(6)

      end) then
     else

      activity.setRequestedOrientation(0)

    end
   else
    Hfullflag=false
    skipPlayTime.setVisibility(View.GONE)
    -- 将屏幕方向设置为竖屏模式
    -- print(222222)
    playH.setVisibility(View.VISIBLE)
    playV.setVisibility(View.GONE)
    activity.setRequestedOrientation(1)

  end
  task(200, function()
    changeSurfaceSize(videoWidth, videoHeight)
  end)
end

-- -- 当设备的屏幕配置改变时会调用此函数
-- function onConfigurationChanged(config)
--   changeSurfaceSize(videoWidth, videoHeight)
-- end

-- 定义设置电量显示的函数
function setBattery()
  -- 导入所需库
  local Intent = luajava.bindClass "android.content.Intent"
  local IntentFilter = luajava.bindClass "android.content.IntentFilter"
  local BatteryManager = luajava.bindClass "android.os.BatteryManager"

  -- 创建一个IntentFilter对象，指定过滤条件为ACTION_BATTERY_CHANGED
  local filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
  -- 注册广播接收器，并获取包含电量信息的Intent对象
  local intent = this.registerReceiver(nil, filter)
  -- 获取电量信息
  local Battery = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)

  -- 定义电量百分比对应的图片和电量范围
  local batteryTable = {0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110}
  local img = {"static/img/play/dl10.png", "static/img/play/dl20.png", "static/img/play/dl30.png",
    "static/img/play/dl40.png", "static/img/play/dl50.png", "static/img/play/dl60.png",
    "static/img/play/dl70.png", "static/img/play/dl80.png", "static/img/play/dl90.png",
    "static/img/play/dl100.png","static/img/play/dl100.png"}

  -- 获取电池状态
  local chargeState = intent.getIntExtra(BatteryManager.EXTRA_STATUS, BatteryManager.BATTERY_STATUS_UNKNOWN)
  -- 判断是否在充电
  if chargeState == 2 then
    batteryText.setText("⚡")
    -- batteryout.background = loadbitmap(img[10])
    batteryout.setImageBitmap(loadbitmap(img[10]))
    -- 使用glide加载
    -- Glide.with(activity).load(imgTable.battery.charging).into(battery)
   else
    -- 根据电量百分比设置相应的图片
    for i, v in ipairs(batteryTable) do
      if batteryTable[i + 1] ~= nil then

        if Battery and Battery >= v and Battery < batteryTable[i + 1] then
          batteryout.setImageBitmap(loadbitmap(img[i]))
          batteryText.setText(tostring(Battery))
          -- batteryout.background = loadbitmap(img[i])
         else
          batteryout.setImageBitmap(loadbitmap(img[10]))
          batteryText.setText(tostring("--"))
        end
      end
    end
  end
end



import "android.content.BroadcastReceiver"
import "android.content.Context"
import "android.content.Intent"
import "android.content.IntentFilter"
import "android.graphics.Canvas"
import "android.graphics.Color"
import "android.graphics.Paint"
import "android.graphics.Rect"
import "android.graphics.RectF"
import "android.os.BatteryManager"
import "android.util.AttributeSet"
import "android.util.Log"
import "android.view.View"

function BatteryView()

  myLuaDrawable=LuaDrawable(function(canvas,mPaint,mDrawable)
    --计算半径
    local mMargin = 5; -- //电池内芯与边框的距离
    local mBoder = 4; --//电池外框的宽带
    local mWidth = 70; -- //主体外框总长
    local mHeight = 40; --//主体总高
    local mHeadWidth = 5; --//头部宽度
    local mHeadHeight = 10; --//头部高度

    local mMainRect=RectF(10,10,mWidth,mHeight) -- //主体区域方位
    local mHeadRect=Rect(mWidth,(mHeight-mHeadHeight),mWidth+mHeadWidth,mHeight-mHeadHeight*2) --//头部区域方位
    local mRadius = 5 --圆角
    local mPower;

    local mIsCharging; --//是否在充电


    local filter =IntentFilter(Intent.ACTION_BATTERY_CHANGED)
    local intent =this.registerReceiver(nil,filter)
    local mPower = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
    local 当前电量状态 = intent.getIntExtra(BatteryManager.EXTRA_STATUS, BatteryManager.BATTERY_STATUS_UNKNOWN)
    local mIsCharging=(当前电量状态==2)
    return function(canvas)
      local paint1 = Paint();
      --画外框
      paint1.setStyle(Paint.Style.STROKE); --设置空心矩形
      paint1.setStrokeWidth(mBoder); --设置边框宽度
      paint1.setColor(Color.WHITE);
      canvas.drawRoundRect(mMainRect, mRadius, mRadius, paint1);

      --画电池头
      paint1.setStyle(Paint.Style.FILL); --实心
      paint1.setColor(Color.WHITE);
      canvas.drawRect(mHeadRect, paint1);

      --  canvas.drawCircle(mHeight+math.cos(math.rad(jd))*mHeight,mWidth-math.sin(math.rad(jd))*mWidth,mWidth,mPaint)




      --画电池芯
      local paint = Paint();
      if (mIsCharging)
        paint.setColor(Color.GREEN);
       else
        if (mPower < 20)
          paint.setColor(Color.RED);
         else
          paint.setColor(Color.WHITE);
        end
      end

      local width = (mPower /100* (mMainRect.width() - mMargin*2));
      local left = (mMainRect.left + mMargin );
      local right = (mMainRect.left + mMargin + width);
      local top = (mMainRect.top + mMargin);
      local bottom = (mMainRect.bottom - mMargin);
      local rect = Rect(left,top,right, bottom);
      canvas.drawRect(rect, paint);


      --画数字
      local mPaint2=Paint()
      mPaint2.setColor(0xff227CEA)
      --mPaint2.setColor(0xffffffff)
      mPaint2.setAntiAlias(true)
      mPaint2.setStrokeWidth(mWidth/2)
      mPaint2.setStyle(Paint.Style.FILL)
      mPaint2.setTextAlign(Paint.Align.CENTER)
      mPaint2.setTextSize(mHeight/1.8)

      canvas.drawText(tostring(mPower),mHeight,mWidth/2,mPaint2);

    end
  end)
  batteryText.background=myLuaDrawable
end



function updateVideoProgress()
  setNetSpeed(netWorkText)
  --pcall(function()

  --setNetworkState()
  --  end)
  if prepared then
    seekbar.setSecondaryProgress(videoPlayer.getBufferedPosition())
    progress.setSecondaryProgress(videoPlayer.getBufferedPosition())
    if controlFlag then
      --setNetworkState()
      nowTimeout.text = os.date("%H:%M")
      task(100,BatteryView)
    end
    if videoPlayer.isPlaying() then
      playCurrent = videoPlayer.getCurrentPosition()
      playCurrentout.text = dealPlayTime(playCurrent)
      seekbar.setProgress(playCurrent)
      progress.setProgress(playCurrent)

      if prepared and playCurrent > skipEnd and skipEnd > 0 then
        videoPlayer.stop()
        prepared = false
        showToast("跳过片尾...")
        nextPlayVideo()
      end

      if playCurrent % 10 == 0 and playCurrent>3000 then
        local temp ={}
        temp[1]=downloads[bodyIndex].site
        temp[2]={['标题']=downloads[bodyIndex]["标题"],['图片']=downloads[bodyIndex]["图片"],['地址']=downloads[bodyIndex]["地址"],['状态']=downloads[bodyIndex]["状态"]}

        temp[3] = {
          ["标题"] = temp[2]["标题"]
        }
        temp[3] = {
          ["标题"] = temp[2]["标题"],
          ["播放"] = downloads[bodyIndex]["playName"],
          ['进度'] = playCurrent,
          ['时长'] = videoDuration,
          ["速度"]=playRate
        }
        task(100,function()
          historys = historyUtil.setHistory(temp)
        end)
      end
    end
   else
  end
  task(500, function()
    updateVideoProgress()
  end)
end

updateVideoProgress()

function showFullControl()
  controlFlag = true
  videoHead.setVisibility(View.VISIBLE)
  videoFoot.setVisibility(View.VISIBLE)
  progress.setVisibility(View.GONE)
  -- batteryout.setVisibility(View.VISIBLE)
  batteryText.setVisibility(View.VISIBLE)
  nowTimeout.setVisibility(View.VISIBLE)
  selectPlayMode.setVisibility(View.VISIBLE)
  --   selectPlayout.setVisibility(View.VISIBLE)
  selectPlayrateout.setVisibility(View.VISIBLE)
  --   playH.setVisibility(View.GONE)
  --   playV.setVisibility(View.VISIBLE)
  if Hfullflag then
    skipPlayTime.setVisibility(View.VISIBLE)
   else
    skipPlayTime.setVisibility(View.GONE)
  end
end
function hideFullControl()
  controlFlag = false
  -- controlFlag = false
  videoHead.setVisibility(View.GONE)
  videoFoot.setVisibility(View.GONE)
  if setting.showPlayProgress then
    progress.setVisibility(View.VISIBLE)
  end
end

function showView()
  controlFlag = true
  videoHead.setVisibility(View.VISIBLE)
  videoFoot.setVisibility(View.VISIBLE)
  progress.setVisibility(View.GONE)
  skipPlayTime.setVisibility(View.GONE)
  -- batteryout.setVisibility(View.GONE)
  batteryText.setVisibility(View.GONE)
  nowTimeout.setVisibility(View.GONE)
  selectPlayMode.setVisibility(View.GONE)
  --   selectPlayout.setVisibility(View.GONE)
  selectPlayrateout.setVisibility(View.GONE)
  --   playV.setVisibility(View.GONE)
  --   playH.setVisibility(View.VISIBLE)

end

function hideView()
  controlFlag = false
  videoHead.setVisibility(View.GONE)
  videoFoot.setVisibility(View.GONE)
  progress.setVisibility(View.GONE)
end
showView()
hideView()
msgRate.setVisibility(View.GONE)
msgBox.setVisibility(View.GONE)

function dealNumber(num)

  if num < 0 then
    return "0%"
   elseif num > 100 then
    return "100%"
   else
    return tostring(tointeger(num)) .. "%"
  end
end
function setLight()
  msgBoxText.setText("亮度：" .. tostring(dealNumber(controlNum)))
  msgBox.setVisibility(View.VISIBLE)
  if controlNum < 0 then
    systemUtil.setScreenBrightness(0)
   elseif controlNum > 100 then
    systemUtil.setScreenBrightness(100)
   else
    systemUtil.setScreenBrightness(controlNum)
  end
end

function setVolume(num)
  msgBoxText.setText("音量：" .. dealNumber(num))
  msgBox.setVisibility(View.VISIBLE)
  if num < 0 then
    systemUtil.setVolume(0)
   elseif num > 100 then
    systemUtil.setVolume(100)
   else
    systemUtil.setVolume(num)
  end
end

mOnGestureListener = GestureDetector.OnGestureListener({
  onDown = function(v)
    positionX = v.getX()
    positionY = v.getY()
    controlNum = 0
    return true
  end,
  onFling = function(a, b, c, d)

  end,
  onLongPress = function(v)
    if videoPlayer.isPlaying() then
      task(100, function()
        longClickFlag = true
        setPlayRate(2)
      end)
    end
  end,
  onScroll = function(a, b, c, d)
    if #trueUrl > 0 and not longClickFlag then
      tarX = b.getX()
      tarY = b.getY()
      diffX = tarX - positionX
      diffY = tarY - positionY
      if positionX < 0.5 * activity.width then
        if brightFlag then
          controlNum = controlNum + d / 30
          setLight(controlNum)
         elseif progressFlag then
          msgBoxText.setText("跳转至" .. dealPlayTime(playCurrent + (b.getX() - positionX) * 100))
          msgBox.setVisibility(View.VISIBLE)
         else
          if math.abs(diffX) > math.abs(diffY) then
            progressFlag = true
            msgBoxText.setText("跳转至" .. dealPlayTime(playCurrent + (b.getX() - positionX) * 100))
            msgBox.setVisibility(View.VISIBLE)
           else
            brightFlag = true
            controlNum = systemUtil.getScreenBrightness() + d / 30
            setLight(controlNum)
          end
        end
       elseif positionX > 0.5 * activity.width then
        if volumeFlag then
          controlNum = controlNum + d / 30
          setVolume(controlNum)
         elseif progressFlag then
          msgBoxText.setText("跳转至" .. dealPlayTime(playCurrent + (b.getX() - positionX) * 100))
          msgBox.setVisibility(View.VISIBLE)
         else
          if math.abs(diffX) > math.abs(diffY) then
            progressFlag = true
            msgBoxText.setText("跳转至" .. dealPlayTime(playCurrent + (b.getX() - positionX) * 100))
            msgBox.setVisibility(View.VISIBLE)
           else
            volumeFlag = true
            -- showToast(systemUtil.getVolume())
            controlNum = systemUtil.getVolume() + d / 30
            setVolume(controlNum)
          end
        end
      end
    end
    return true
  end,
  onShowPress = function(v)

    return true
  end,
  onSingleTapUp = function(v)

    return true
  end
})

mOnDoubleTapListener = GestureDetector.OnDoubleTapListener({
  onSingleTapConfirmed = function(v)
    if fullScreenFlag then
      if playRateFlag then
        playRateFlag = false
        videoPlayRateout.setVisibility(View.GONE)
       elseif selectPlayFlag then
        selectPlayFlag = false
        body_dialog.dismiss()
       elseif controlFlag then
        hideFullControl()
       else
        showFullControl()
      end
     else
      if playRateFlag then
        playRateFlag = false
        videoPlayRateout.setVisibility(View.GONE)
       elseif selectPlayFlag then
        selectPlayFlag = false
        body_dialog.dismiss()
       elseif controlFlag then
        hideView()
       else
        if trueUrl and #trueUrl > 0 then
          showView()
         else
          showToast("没有正在播放的视频或视频嗅探未完成！")
        end

      end
    end
    return true
  end,
  onDoubleTap = function(v)
    if prepared then
      if not pauseFlag then
        Pause()
       else
        Play()
      end
    end
    return true
  end,
  onDoubleTapEvent = function(v)
    return true
  end
})

videoControl.setLongClickable(true) -- 设置可触摸
videoControl.setClickable(true) -- 设置可触摸

mytouch = GestureDetector(activity, mOnGestureListener).setOnDoubleTapListener(mOnDoubleTapListener)
videoControl.onTouch = function(view, event)
  mytouch.onTouchEvent(event)
  local ACTION = event.getAction()
  if ACTION == MotionEvent.ACTION_DOWN then
   elseif ACTION == MotionEvent.ACTION_MOVE then
    if longClickFlag and fullScreenFlag then
      local rawy = event.getRawY()
      local height = activity.height / 5
      if rawy < height then
        setPlayRate(1.5)
       elseif height < rawy and rawy < height * 2 then
        setPlayRate(2)
       elseif 2 * height < rawy and rawy < height * 3 then
        setPlayRate(3)
       elseif 3*height<rawy and rawy<height*4 then
        setPlayRate(4)
       elseif 4*height<rawy and rawy<height*5 then
        setPlayRate(5)
      end
    end
   elseif ACTION == MotionEvent.ACTION_UP then

    if (longClickFlag) then
      longClickFlag = false
      setPlayRate(playRate)
    end
    if progressFlag then
      progressFlag = false
      if playCurrent + diffX * 100 < 0 then
        videoPlayer.seekTo(0)
       elseif playCurrent + diffX * 100 > videoPlayer.getDuration() then
        playCurrentout.text = dealPlayTime(videoDuration)
        videoPlayer.seekTo(videoDuration)
       else
        playCurrentout.text = dealPlayTime(playCurrent + diffX * 100)
        videoPlayer.seekTo(playCurrent + diffX * 100)
      end
    end
    if brightFlag then
      brightFlag = false
    end
    if volumeFlag then
      volumeFlag = false
    end
    msgBox.setVisibility(View.GONE)
  end
end

selectPlayrateout.onClick = function()
  videoPlayRateout.setVisibility(View.VISIBLE)

  hideFullControl()
  playRateFlag = true
end


playPause.onClick = function()

  Pause()

end

playStart.onClick = function()
  Play()
end

seekbar.setOnSeekBarChangeListener {
  onStartTrackingTouch = function()
    seekFlag = true
  end,
  onProgressChanged = function(a, i)
    if seekFlag then

      msgBoxText.setText("跳转至" .. dealPlayTime(i))
      msgBox.setVisibility(View.VISIBLE)
    end
    -- ti.stop()
    -- Toast.makeText(activity, tostring(i),Toast.LENGTH_SHORT).show()
  end,

  -- mediaPlayer.seekTo(math.floor(i))
  -- end
  onStopTrackingTouch = function(m)
    seekFlag = false
    playCurrentout.text = dealPlayTime(math.floor(m.getProgress()))
    msgBox.setVisibility(View.GONE)
    videoPlayer.seekTo(math.floor(m.getProgress()))
  end
}

function onDestroy()
  --   XLTaskHelper.instance().stopTask(taskId)
  videoPlayer.release()
  --cache.release()

end

selectPlayMode.onClick = function()
  if videoMode == 0 then
    videoMode = 1

   elseif videoMode == 1 then

    videoMode = 2

   elseif videoMode == 2 then
    videoMode = 0
  end

  changeSurfaceSize(videoWidth, videoHeight)
end

msgRate.onClick = function()
  playRate = 1
  rate_adapter.notifyDataSetChanged()
  setPlayRate(playRate)
end

function formatTime(num)
  local miao = tostring(tointeger(num * 0.001 % 60))
  if #miao == 1 then
    miao = "0" .. miao
  end
  local fen = tostring(tointeger(num * 0.001 / 60))
  if #fen == 1 then
    fen = "0" .. fen
  end
  return fen .. ":" .. miao
end

playStartout.onClick = function()
  if playCurrent < 600000 then
    skipStart = playCurrent
    playStartout.setText("片头：" .. formatTime(skipStart))
    showToast("已设置片头" .. formatTime(skipStart))
   else
    showToast("片头不能大于10分钟！")
  end

end

playEndout.onClick = function()
  if videoDuration - playCurrent < 600000 then
    skipEnd = playCurrent
    playEndout.setText("片尾：" .. formatTime(skipEnd))
    showToast("已设置片尾" .. formatTime(skipEnd))
   else
    showToast("片尾不能大于10分钟！")
  end

end

playStartout.onLongClick = function()
  skipStart = 0
  playStartout.setText("片头：00:00")
  showToast("已重置片头时间！")
end

playEndout.onLongClick = function()
  skipEnd = 0
  playEndout.setText("片尾：00:00")
  showToast("已重置片尾时间！")

end

function onStart()
  if fullScreenFlag then

    task(50, function()

      activity.setTheme(android.R.style.Theme_Black_NoTitleBar_Fullscreen)

      全屏()
      屏幕沉浸(0,0)
      消除虚拟按键()

      -- changeSurfaceSize(videoWidth, videoHeight)

    end)
  end
end

goBack.onClick = function()
  activity.finish()
  --   if fullScreenFlag then
  --     exitPlayFullscreen()
  --    else
  --     XLTaskHelper.instance().stopTask(taskId)

  --     activity.finish()
  --   end
end


function getPopupWindow(item, flag)
  local pop = PopupWindow(activity)
  pop.setContentView(item)
  if flag then
    pop.setWidth(activity.width * 0.3) -- 设置宽度
    pop.setHeight(activity.height)
    -- search_item.setVisibility(View.GONE)
    -- body.setBackgroundColor(0x00ffffff)

   else
    pop.setWidth(activity.width) -- 设置宽度
    pop.setHeight(activity.height) -- 设置高度

    -- search_item.setVisibility(View.VISIBLE)
  end
  pop.setFocusable(false) -- 设置可获得焦点
  pop.setTouchable(true).setClippingEnabled(false) -- 设置启用剪辑
  .setBackgroundDrawable(nil)
  -- 设置可触摸
  -- 设置点击外部区域是否可以消失
  pop.setOutsideTouchable(false)
  activity.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
  View.SYSTEM_UI_FLAG_IMMERSIVE

  -- 显示
  -- pop.showAsDropDown(frame)
  task(200, function() -- 延迟执行400ms，等待动画完成
    if flag then
      pop.showAtLocation(playView, Gravity.RIGHT, 0, 0)
     else
      pop.showAtLocation(playView, Gravity.BOTTOM, 0, 0)

    end
  end)
  return pop
end

function runTime()
  downloads = downloadUtil.getDownloads()
  adapter.notifyDataSetChanged()
  if selectPlayFlag then
    task(2000, runTime)
  end
end

selectPlayout.onClick = function()

  selectPlayFlag = true
  hideView()
  hideFullControl()
  body_dialog = getPopupWindow(body_layout, true)
  bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))





  bodyout.setAdapter(adapter)
  runTime()
end



playLast.onClick = function()
  videoPlayer.stop()
  lastPlayVideo()
end

playNext.onClick = function()
  videoPlayer.stop()
  nextPlayVideo()
end

task(200,function ( ... )
  initPlayer(videos[1])
end)





playH.onClick=function()
  Hfullflag=true
  playH.setVisibility(View.GONE)
  playV.setVisibility(View.VISIBLE)
  skipPlayTime.setVisibility(View.VISIBLE)

  if pcall(function()



      activity.setRequestedOrientation(6)

    end) then
   else

    activity.setRequestedOrientation(0)

  end

  task(200,function()
    -- print(2222)
    changeSurfaceSize(videoWidth,videoHeight)end)

end
playV.onClick=function()
  Hfullflag=false
  activity.setRequestedOrientation(1)
  playH.setVisibility(View.VISIBLE)
  playV.setVisibility(View.GONE)
  task(200,function()
    -- print(1111)
    skipPlayTime.setVisibility(View.GONE)
    changeSurfaceSize(videoWidth,videoHeight)end)

end