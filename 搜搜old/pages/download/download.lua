require("import");
import("common.BaseActivity");
import("pages.download.layout");
import "android.text.Html"

activity.setContentView(layout);
import "utils.DownloadUtil"
downloadUtil = DownloadUtil()

downout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
downloads = downloadUtil.getDownloads()
adapter = LuaCustRecyclerAdapter(AdapterCreator({

  getItemCount = function()
    return #downloads
  end,

  getItemViewType = function(position)
    return 0
  end,

  onCreateViewHolder = function(parent, viewType)
    local views = {}
    holder = LuaCustRecyclerHolder(loadlayout(itemout, views))
    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder = function(holder, position)
    -- print(data[position+1][1])
    view = holder.view.getTag()
    view.titleout.text = Html.fromHtml(downloads[position + 1]['标题'])
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
    view.progressout.onClick = function(...)
      -- body
      if downloads[position + 1].state == "等待中" or downloads[position + 1].state == "嗅探中" or
        downloads[position + 1].state == "下载中" then
        downloads[position + 1].state = "已暂停"
        downloadUtil.saveDownloads(downloads)
        adapter.notifyDataSetChanged()
       elseif downloads[position + 1].state == "已完成" then
        systemUtil.copyContent(downloads[position + 1].savePath, "下载路径已复制到剪贴板！")

       else
        downloads[position + 1].state = "等待中"
        downloadUtil.saveDownloads(downloads)
        adapter.notifyDataSetChanged()
      end

    end

    view.downSuccessout.onClick=function()


      local dialog = AlertDialog.Builder(this) -- .setTitle("提示")
      .setMessage("确定强制完成该条下载吗？").setPositiveButton("确定", {
        onClick = function(v)
          if downloads[position + 1].state == "等待中" or downloads[position + 1].state == "嗅探中" or downloads[position + 1].state == "已暂停" then
            showToast("您还没有下载该视频！")
           elseif downloads[position + 1].state == "已完成" then
            showToast("您已下载完成该视频！")
           else
            downloads[position + 1].state = "已完成"
            downloadUtil.saveDownloads(downloads)
            adapter.notifyDataSetChanged()
            showToast("操作成功！")
          end
        end
      }) --  .setNeutralButton("取消",nil)
      .setNegativeButton("取消", nil).show()
      dialog.create()

      -- 更改Button颜色
      import "android.graphics.Color"
      dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(ColorStyles().blue)
      dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(ColorStyles().blue)
      dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(ColorStyles().blue)



    end



    view.nameout.onLongClick = function(...)
      -- body
      if downloads[position + 1].trueUrl then
        systemUtil.copyContent(downloads[position + 1].trueUrl, "下载地址已复制到剪贴板!")
       else
        systemUtil.copyContent(downloads[position + 1].playHref, "下载地址已复制到剪贴板!")
      end
    end
    view.deleteout.onClick = function(...)
      -- body
      dialog = AlertDialog.Builder(this) -- .setTitle("提示")
      .setMessage("确定删除该条下载记录吗？").setPositiveButton("确定", {
        onClick = function(v)
          downloads = downloadUtil.removeDownload(position + 1)
          adapter.notifyDataSetChanged()
        end
      }) --  .setNeutralButton("取消",nil)
      .setNegativeButton("取消", nil).show()
      dialog.create()

      -- 更改Button颜色
      import "android.graphics.Color"
      dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(ColorStyles().blue)
      dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(ColorStyles().blue)
      dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(ColorStyles().blue)
    end
    view.playout.onClick = function(...)
      if endsWith(downloads[position + 1].savePath,"torrent") then

        showToast("种子文件不支持播放！")
        return
      end
      -- body
      if downloads[position + 1].state == "等待中" then
        showToast("该视频未下载！")
       elseif downloads[position + 1].state == "下载中" then
        showToast("边下边播中！")
        local playUrl = downloadUtil.getPlayUrl(downloads[position + 1].savePath)
        if not playUrl then playUrl=downloads[position + 1].savePath end
        activity.newActivity("pages/download/media",
        {playUrl, name, downloads[position + 1]['标题'], position + 1})
       elseif downloads[position + 1].state == "已完成" then
        local playUrl = downloadUtil.getPlayUrl(downloads[position + 1].savePath)
        if not playUrl then playUrl=downloads[position + 1].savePath end
        activity.newActivity("pages/download/media",
        {playUrl, name, downloads[position + 1]['标题'], position + 1})
      end

    end

    view.nameout.onClick = function(...)
      -- body
      if endsWith(downloads[position + 1].savePath,"torrent") then

        showToast("种子文件不支持播放！")
        return
      end



      if downloads[position + 1].state == "等待中" then
        showToast("该视频未下载！")
       elseif downloads[position + 1].state == "下载中" then
        showToast("边下边播中！")
        local playUrl = downloadUtil.getPlayUrl(downloads[position + 1].savePath)

        if not playUrl then playUrl=downloads[position + 1].savePath end
        activity.newActivity("pages/download/media",
        {playUrl, name, downloads[position + 1]['标题'], position + 1})
       elseif downloads[position + 1].state == "已完成" then
        local playUrl = downloadUtil.getPlayUrl(downloads[position + 1].savePath)
        if not playUrl then playUrl=downloads[position + 1].savePath end
        activity.newActivity("pages/download/media",
        {playUrl, name, downloads[position + 1]['标题'], position + 1})
      end

    end
    view.titleout.onClick = function(...)
      -- body
      if endsWith(downloads[position + 1].savePath,"torrent") then

        showToast("种子文件不支持播放！")
        return
      end

      if downloads[position + 1].state == "等待中" then
        showToast("该视频未下载！")
       elseif downloads[position + 1].state == "下载中" then
        showToast("边下边播中！")
        local playUrl = downloadUtil.getPlayUrl(downloads[position + 1].savePath)
        if not playUrl then playUrl=downloads[position + 1].savePath end
        activity.newActivity("pages/download/media",
        {playUrl, name, downloads[position + 1]['标题'], position + 1})
       elseif downloads[position + 1].state == "已完成" then
        local playUrl = downloadUtil.getPlayUrl(downloads[position + 1].savePath)
        if not playUrl then playUrl=downloads[position + 1].savePath end
        activity.newActivity("pages/download/media",
        {playUrl, name, downloads[position + 1]['标题'], position + 1})
      end

    end

  end
}))
-- RecyclerView绑定适配器
downout.setAdapter(adapter)
runFlag = true

function setNetSpeed(id)
  local function getNetSpeed(id)
    require "import"
    import "android.net.TrafficStats"
    s = TrafficStats.getTotalRxBytes()

    task(250, function()

      local speed=(TrafficStats.getTotalRxBytes() - s) * 2 / 1000
      if speed>1024 then
        id.text = "下载("..tointeger(speed*100/ 1024)/100 .. "m/s)"
       else
        id.text = "下载("..tointeger(speed*100)/100 .. "k/s)"
      end
    end)
  end
  getNetSpeed(id)
  -- timer(getNetSpeed,0,1000,id)
end




function runTime()
  downloads = downloadUtil.getDownloads()
  adapter.notifyDataSetChanged()
  setNetSpeed(titleNet)


  if runFlag then
    task(2000, runTime)
  end
end

function onStart()
  systemUtil.ignoreBattery()
  runFlag = true
  runTime()
end

function onStop()
  runFlag = false
end

clearout.onClick = function()
  dialog = AlertDialog.Builder(this) -- .setTitle("提示")
  .setMessage("确定删除所有下载记录吗？").setPositiveButton("确定", {
    onClick = function(v)
      downloads = downloadUtil.clearDownloads()
      adapter.notifyDataSetChanged()
    end
  }) --  .setNeutralButton("取消",nil)
  .setNegativeButton("取消", nil).show()
  dialog.create()

  -- 更改Button颜色
  import "android.graphics.Color"
  dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(ColorStyles().blue)
  dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(ColorStyles().blue)
  dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(ColorStyles().blue)

end
