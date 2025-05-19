require("import");
import("common.BaseActivity");
import "android.content.DialogInterface"
import "pages.video.playout"

import "utils.VideoUtil"

videoUtil = VideoUtil()
historys = videoUtil.getDatas()

bodyIndex = 1
play_name = ""
trueUrl = ""
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

activity.setContentView(layout);
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

videos = ...

function getHisInit()
    hisNum = videoUtil.getHisNum({File(videos[1]).getParent(), File(videos[1]).getName()})
    if hisNum > 0 then
        historys = videoUtil.setData(historys[hisNum])
        play_name = historys[hisNum][2]
    end
end
getHisInit()

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

function getPopupWindow(item, flag)
    local pop = PopupWindow(activity)
    pop.setContentView(item)
    if flag then
        pop.setWidth(activity.width * 0.5) -- 设置宽度
        pop.setHeight(activity.height)
        search_item.setVisibility(View.GONE)
        -- body.setBackgroundColor(0x00ffffff)

    else
        pop.setWidth(activity.width) -- 设置宽度
        pop.setHeight(activity.height) -- 设置高度

        search_item.setVisibility(View.VISIBLE)
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

body_dialog = getPopupWindow(body_layout)
-- systemUtil.setStatusBarColor(ColorStyles().black)
-- systemUtil.setStatusBarLight()
systemUtil.keepScreenOn()
bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))

videoTable = {}
adapter = LuaCustRecyclerAdapter(AdapterCreator({

    getItemCount = function()

        return #videoTable
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
        -- print(hearts[position+1][1])
        view = holder.view.getTag()

        glideImg(view.picout, videoTable[position + 1][3])
        view.titleout.text = videoTable[position + 1][2]
        if play_name == videoTable[position + 1][2] then
            view.titleout.setTextColor(ColorStyles().blue)
        else
            view.titleout.setTextColor(ColorStyles().black)
        end

        -- view.stateout.text = videoTable[position + 1][4]
        view.stateout.text = "时长：" .. dealPlayTime(videoTable[position + 1][4])
        view.singleItem.onClick = function()
            play_name = videoTable[position + 1][2]
            adapter.notifyDataSetChanged()
            playTitle.setText(play_name)
            bodyIndex = position + 1
            
            trueUrl = videoTable[bodyIndex][1]
            -- view.titleout.setTextColor(ColorStyles().blue)
            initPlayer(trueUrl)

        end;
        view.singleItem.onLongClick = function()

            dialog = AlertDialog.Builder(this) -- .setTitle("提示")
            .setMessage("你想删除此条视频？").setPositiveButton("确定", {
                onClick = function(v)
                    local flag = pcall(function()
                        File(videoTable[position + 1][1]).delete()

                    end)
                    if flag then
                        table.remove(videoTable, position + 1)
                        -- bodyout.setAdapter(adapter)
                        adapter.notifyDataSetChanged()
                        showToast("删除成功！")
                    else
                        showToast("删除失败！")
                    end
                end
            }).setNegativeButton("取消", nil).show()
            dialog.create()

            -- 更改Button颜色
            import "android.graphics.Color"
            dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(ColorStyles().blue)
            dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(ColorStyles().blue)
            dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(ColorStyles().blue)
        end

        -- table.remove(videos, position + 1)
        -- adapter.notifyDataSetChanged()

    end
}))

function addVideo(data)

    table.insert(videoTable, data)

    adapter.notifyDataSetChanged()

end
function getVideoTable(video)
    require "import"

    import "utils.VideoUtil"
    import "utils.util"
    import "android.media.MediaPlayer"

    mediaPlayer = MediaPlayer()
    videoUtil = VideoUtil()
    function GetFilelastTime(path)
        f = File(path)
        cal = Calendar.getInstance()
        time = f.lastModified()
        cal.setTimeInMillis(time)
        return cal.getTime().toLocaleString()
    end
    local v = video
    local flag, url = pcall(videoUtil.getVideoFrame, v)
    if flag then
        local names = split(v, "/")
        -- mediaPlayer.reset()
        mediaPlayer.setDataSource(v)
        mediaPlayer.prepare();
        duration = mediaPlayer.getDuration();
        -- duration= GetFilelastTime(v)

        call("addVideo", {v, names[#names], url, duration})
    end

    mediaPlayer.release()
    Thread.currentThread().interrupt()
end

-- RecyclerView绑定适配器
bodyout.setAdapter(adapter)

threading = Threading(6, 500, getVideoTable, videos)

threading.run()
function onDestroy()
    threading.interrupt()
end


function nextPlayVideo()

    if videoTable[bodyIndex + 1] then
        bodyIndex = bodyIndex + 1

        -- view.nameout.text = "来源：" .. hearts[position + 1][1].name

        play_name = videoTable[bodyIndex][2]
        playTitle.setText(play_name)
        adapter.notifyDataSetChanged()
        playLoading.setVisibility(View.VISIBLE)

        trueUrl = videoTable[bodyIndex][1]
        initPlayer(trueUrl)

    else
        showToast("已经是最后一集啦！")
        playPause.setVisibility(View.GONE)
        playStart.setVisibility(View.VISIBLE)
    end
end

function lastPlayVideo()
    if videoTable[bodyIndex - 1] then

        bodyIndex = bodyIndex - 1
        play_name = videoTable[bodyIndex][2]
        playTitle.setText(play_name)
        adapter.notifyDataSetChanged()
        playLoading.setVisibility(View.VISIBLE)

        trueUrl = videoTable[bodyIndex][1]
        initPlayer(trueUrl)

    else
        showToast("已经是第一集啦！")
        playPause.setVisibility(View.GONE)
        playStart.setVisibility(View.VISIBLE)
    end
end
import "pages.video.media"

playLast.onClick = function()
    videoPlayer.stop()
    lastPlayVideo()
end

playNext.onClick = function()
    videoPlayer.stop()
    nextPlayVideo()
end

function onResume()

    systemUtil.hideNavigationBar()
end
