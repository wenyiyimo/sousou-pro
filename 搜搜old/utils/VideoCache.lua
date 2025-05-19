import "com.jeffmony.videocache.VideoProxyCacheManager"
import "com.jeffmony.videocache.utils.StorageUtils"

import "com.jeffmony.videocache.utils.LogUtils"
import "com.jeffmony.videocache.utils.ProxyCacheUtils"
import "com.jeffmony.videocache.utils.TimeUtils"
import "android.net.Uri"



function VideoCache()


  local function init()

    local saveFile = StorageUtils.getVideoFileDir(this);
    if (not saveFile.exists()) then
      saveFile.mkdir()
    end
    builder = VideoProxyCacheManager.Builder().
    setFilePath(saveFile.getAbsolutePath()). --缓存存储位置
    setConnTimeOut(60 * 1000). --网络连接超时
    setReadTimeOut(60 * 1000). --网络读超时
    setExpireTime(10 * 24 * 60 * 60 * 1000). --2天的过期时间
    setMaxCacheSize(2 * 1024 * 1024 * 1024); --2G的存储上限
    VideoProxyCacheManager.getInstance().initProxyConfig(builder.build());

  end

  local function getUrl(videoUrl)


    VideoProxyCacheManager.getInstance().startRequestVideoInfo(Uri.parse(videoUrl).toString());

    -- VideoProxyCacheManager.getInstance().setPlayingUrlMd5(ProxyCacheUtils.computeMD5(videoUrl));
    local localUrl=ProxyCacheUtils.getProxyUrl(videoUrl, null, null);
    VideoProxyCacheManager.getInstance().setPlayingUrlMd5(ProxyCacheUtils.computeMD5(videoUrl));
    VideoProxyCacheManager.getInstance().startRequestVideoInfo(videoUrl, null, null);
    return localUrl
  end
  local function stopUrl(videoUrl)
    VideoProxyCacheManager.getInstance().stopCacheTask(videoUrl);
    VideoProxyCacheManager.getInstance().releaseProxyReleases(videoUrl)
  end

  return{
    init=init,
    getUrl=getUrl,
    stopUrl=stopUrl
  }

end