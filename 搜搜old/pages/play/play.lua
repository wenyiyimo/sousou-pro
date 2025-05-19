require("import");
import("common.BaseActivity");
import "android.content.DialogInterface"

-- import "xyz.doikki.videoplayer.player.VideoView"

import "pages.play.layout"
import "utils.HeartUtil"
import "utils.HistoryUtil"
import "com.xunlei.downloadlib.XLTaskHelper";
import "com.xunlei.downloadlib.parameter.XLTaskInfo";
import "java.io.File";

import "android.os.Environment";

XLTaskHelper.init(this);

siteIndex = 1
listIndex = 1
bodyIndex = 1
body_datas = {}
play_name = ""
trueUrl = ""
localUrl = ""
taskId = 0
heartUtil = HeartUtil()
historyUtil = HistoryUtil()
historys = historyUtil.getHistorys()
p2pUtil = false

function stopFtp()

    if p2pUtil then
        pcall(function()
            p2pUtil.pause()

        end)
        p2pUtil = false
    else

    end
end

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

-- end

search_data, search_datas = ...
if search_datas then
    table.insert(search_datas, 1, search_data)
else
    search_datas = {search_data}
end

function getHeartNum(data)
    if not data then
        return
    end
    heartNum = heartUtil.getHeartNum(data)
    if heartNum > 0 then
        heartout.setText("已收藏")
    else
        heartout.setText("收藏")
    end
    return heartNum
end

function setHeart(data)
    heartUtil.setHeart(data)
    heartout.setText("已收藏")
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
function getHisInit()
    local temp = search_data
    temp[3] = {
        ["标题"] = temp[2]["标题"]
    }
    hisNum = historyUtil.getHistoryNum(temp)
    if hisNum > 0 then
        historys = historyUtil.setHistory(historys[hisNum])

        if historys[1][3]["播放"] and tostring(historys[1][3]["播放"]) ~= "nil" then
        else
            historys[1][3]["播放"] = "未知"
        end

        play_name = historys[1][3]["播放"]
        hisout.setText("历史：" .. play_name .. " " .. dealPlayTime(historys[1][3]["进度"]))
    else
        hisout.setText("历史：暂无")
    end
end
getHisInit()

function removeHeart(data)
    heartUtil.removeHeart(data)
    heartout.setText("收藏")
end

function getInfoDialog(item)

    local pop = PopupWindow(activity)
    pop.setContentView(loadlayout(item))

    pop.setWidth(activity.width) -- 设置宽度
    pop.setHeight(activity.height) -- 设置高度

    pop.setFocusable(true) -- 设置可获得焦点
    pop.setTouchable(true) -- .setClippingEnabled(false) -- 设置启用剪辑
    .setBackgroundDrawable(nil)
    -- 设置可触摸
    -- 设置点击外部区域是否可以消失
    pop.setOutsideTouchable(false)
    --[[activity.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
  View.SYSTEM_UI_FLAG_IMMERSIVE
]]
    -- 显示
    -- pop.showAsDropDown(frame)

    pop.showAtLocation(playView, Gravity.BOTTOM, 0, 0)

    return pop

    --[[local dialog = Dialog(activity)

  -- 设置弹窗布局
  dialog.setContentView(loadlayout(item))
  -- 设置弹窗位置
  dialog.getWindow().setGravity(Gravity.BOTTOM)
  dialog.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
  -- 设置触摸弹窗外部隐藏弹窗

  -- dialog.setCanceledOnTouchOutside(false);
  -- else
  dialog.setCanceledOnTouchOutside(true);
  -- end
  local p = dialog.getWindow().getAttributes()
  p.dimAmount = 0
  p.width = activity.width

  p.height = activity.Height * 0.75;
  dialog.getWindow().setAttributes(p);
  -- dialog.getWindow().getDecorView().setPadding(0,0,0,0)
  dialog.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
  View.SYSTEM_UI_FLAG_IMMERSIVE

  dialog.show()
  return dialog
  ]]

end
info.onClick = function()

    info_dialog = getInfoDialog(webinfo)

    -- info_dialog.show()
    luaweb.loadUrl("https://baike.sogou.com/m/fullLemma?key=" .. search_data[2]['标题'])
    luaweb.getSettings().setDefaultTextEncodingName("utf-8")
    luaweb.getSettings().setJavaScriptEnabled(true)
    luaweb.setHorizontalScrollBarEnabled(false);
    luaweb.setVerticalScrollBarEnabled(false);
    luaweb.addJavascriptInterface({}, "JsInterface")

    info_dialog.onDismiss = function()

        local parent = luaweb.getParent();
        if parent then

            parent.removeView(luaweb)
        end

        luaweb.stopLoading();

        luaweb.getSettings().setJavaScriptEnabled(false);
        luaweb.clearHistory();
        luaweb.clearView();
        luaweb.removeAllViews();
        luaweb.destroy()

    end

end

-- activity.getWindow().getDecorView().setOnSystemUiVisibilityChangeListener(
-- View.OnSystemUiVisibilityChangeListener {
-- onSystemUiVisibilityChange = function(visibility)

-- systemUtil.hideNavigationBar()

-- end
-- })

navWebout.onClick = function()

    if startsWith(body_datas[listIndex][2][bodyIndex]['地址'], "http") then
        activity.newActivity("pages/webview/webview", {body_datas[listIndex][2][bodyIndex]['地址']})
    else

        if startsWith(search_datas[siteIndex][2]["地址"], "http") then
            activity.newActivity("pages/webview/webview", {search_datas[siteIndex][2]["地址"]})
        else
            showToast("非http地址！")
        end
    end

end

function getPopupWindow(item, flag)
    local pop = PopupWindow(activity)
    pop.setContentView(item)
    if flag then
        pop.setWidth(activity.width * 0.5) -- 设置宽度
        pop.setHeight(activity.height)
        search_item.setVisibility(View.GONE)
        body.setBackgroundColor(0x00ffffff)
    else
        pop.setWidth(activity.width) -- 设置宽度
        pop.setHeight(activity.height * 0.73) -- 设置高度

        search_item.setVisibility(View.VISIBLE)
    end
    pop.setFocusable(false) -- 设置可获得焦点
    pop.setTouchable(true).setClippingEnabled(false) -- 设置启用剪辑
    .setBackgroundDrawable(nil)
    -- 设置可触摸
    -- 设置点击外部区域是否可以消失
    pop.setOutsideTouchable(false)
    activity.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or View.SYSTEM_UI_FLAG_IMMERSIVE

    -- 显示
    -- pop.showAsDropDown(frame)
    task(200, function() -- 延迟执行400ms，等待动画完成
        if flag then
            pop.showAtLocation(playView, Gravity.RIGHT, 0, 0)
        else
            -- pop.showAtLocation(playView, Gravity.BOTTOM, 0, 0)
            pop.showAsDropDown(frame)
        end
    end)
    return pop
end

body_dialog = getPopupWindow(body_layout)
pcall(getHeartNum, search_data)
import "android.text.Html"
title.setText(Html.fromHtml(search_data[2]['标题']))
state.setText(search_data[2]['状态'])
glideImg(picout, search_data[2]['图片'])
siteName.setText(search_data[1].name)

title.onLongClick = function()
    activity.newActivity("pages/search/search/search", {search_data[2]['标题']});

end

systemUtil.setStatusBarColor(ColorStyles().black)
systemUtil.setStatusBarLight()
systemUtil.keepScreenOn()

siteout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.HORIZONTAL))
listout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.HORIZONTAL))
bodyout.setLayoutManager(StaggeredGridLayoutManager(3, StaggeredGridLayoutManager.VERTICAL))

function getPlayNameIndex()
    local playName = play_name
    if #historys > 0 then
        if historys[1][3]["标题"] == search_data[2]["标题"] then
            playName = historys[1][3]["播放"]
        end
    end
    for k, v in pairs(body_datas[listIndex][2]) do
        if v["标题"] == playName then
            return k
        end
    end
    return 1

end

list_adapter = LuaCustRecyclerAdapter(AdapterCreator({

    getItemCount = function()
        return #body_datas
    end,
    getItemViewType = function(position)
        return 0
    end,
    onCreateViewHolder = function(parent, viewType)
        local views = {}
        holder = LuaCustRecyclerHolder(loadlayout(item, views))
        holder.view.setTag(views)
        return holder
    end,
    onBindViewHolder = function(holder, position)
        view = holder.view.getTag()
        view.nameout.text = body_datas[position + 1][1]
        if position + 1 == listIndex then
            view.cardout.cardBackgroundColor = ColorStyles().blue
            view.nameout.textColor = ColorStyles().white
        else
            view.cardout.cardBackgroundColor = ColorStyles().white
            view.nameout.textColor = ColorStyles().black
        end
        view.cardout.onClick = function()
            listIndex = position + 1
            list_adapter.notifyDataSetChanged()
            bodyIndex = getPlayNameIndex()
            -- print(bodyIndex)
            bodyout.setLayoutManager(StaggeredGridLayoutManager(math.max(tointeger(width /
                                                                                       math.max(
                    dp2px(14 * (2 + utf8.len(body_datas[listIndex][2][1]['标题']))),

                    dp2px(14 * (2 + utf8.len(body_datas[listIndex][2][#body_datas[listIndex][2]]['标题']))), 160)), 1),
                StaggeredGridLayoutManager.VERTICAL))
            body_adapter.notifyDataSetChanged()
        end
    end
}))
listout.setAdapter(list_adapter)

local function popView(parent, thunder_data, fileName, saveLocation)
    local pop = PopupWindow(activity)
    pop.setContentView(loadlayout({
        LinearLayout, -- 线性布局
        orientation = 'vertical', -- 方向
        layout_width = 'fill', -- 宽度
        layout_height = 'fill', -- 高度
        id = "popout",
        background = '#ffFFFFFF', -- 背景颜色或图片路径
        {
            ListView, -- 列表视图
            layout_width = 'fill', -- 布局宽度
            layout_height = 'fill', -- 布局高度
            DividerHeight = '1', -- 设置分隔线宽度,0表示无分隔线
            -- background='';--布局背景颜色(或图片路径)
            id = "thunder_list"
        }

    }))
    pop.setWidth(activity.width) -- 设置宽度
    pop.setHeight(activity.height * 0.8)
    pop.setFocusable(false) -- 设置可获得焦点
    pop.setTouchable(true).setClippingEnabled(false) -- 设置启用剪辑
    .setBackgroundDrawable(nil)
    -- 设置可触摸
    -- 设置点击外部区域是否可以消失
    pop.setOutsideTouchable(true)
    activity.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or View.SYSTEM_UI_FLAG_IMMERSIVE

    thunder_adp = LuaAdapter(activity, thunder_data, {
        LinearLayout,
        orientation = "vertical",
        layout_width = "fill",
        {
            TextView,
            id = "name",
            layout_margin = "16dp",
            layout_width = "fill",
            textColor = 0xff000000
        },
        {
            TextView,
            id = "size",
            layout_margin = "12dp",
            layout_width = "fill",
            textColor = 0xff000000
        }
    })

    thunder_list.setAdapter(thunder_adp)

    thunder_list.setOnScrollListener {
        onScroll = function(view, a, b, c)
            if a + b == #thunder_list.adapter.getData() then
                -- 加载更多

            end
        end
    }

    pop.showAtLocation(parent, Gravity.BOTTOM, 0, 0)

    thunder_list.onItemClick = function(parent, view, index, position)
        -- 列表项目被单击
        --  print(id)
        taskId = XLTaskHelper.instance().addTorrentTask(File(saveLocation.toString(), fileName).toString(), saveLocation.toString(), index)

        fileIndexName = view.Tag.name.text

        pop.dismiss()

        local temp = saveLocation.toString() .. "/" .. fileIndexName
        local count = 1

        function checkFileSize(filePath, sizeLimit)
            local file = io.open(filePath, 'r')
            if not file then
                return false
            end
            local fileSize = file:seek("end")
            file:close()
            return fileSize >= sizeLimit * 1024
        end
        function getTURL()
            if File(temp).exists() and checkFileSize(temp, 500) then
                trueUrl = XLTaskHelper.instance().getLoclUrl(temp)
                initPlayer(trueUrl)
            else

                if count < 10 then
                    count = count + 1
                    task(1000, getTURL)
                else
                    showToast("播放失败，请检查播放地址！")

                end
            end

        end
        getTURL()

    end
end

body_adapter = LuaCustRecyclerAdapter(AdapterCreator({
    getItemCount = function()
        if #body_datas > 0 then
            return #body_datas[listIndex][2]
        else
            return 0
        end
    end,

    getItemViewType = function(position)
        return 0
    end,

    onCreateViewHolder = function(parent, viewType)
        local views = {}
        holder = LuaCustRecyclerHolder(loadlayout(body_item, views))
        holder.view.setTag(views)
        return holder
    end,
    onBindViewHolder = function(holder, position)
        -- print(data[position+1][1])
        view = holder.view.getTag()
        view.nameout.text = body_datas[listIndex][2][position + 1]['标题']
        if position + 1 == bodyIndex then
            view.cardout.cardBackgroundColor = ColorStyles().blue
            view.nameout.textColor = ColorStyles().white
        else
            view.cardout.cardBackgroundColor = ColorStyles().white
            view.nameout.textColor = ColorStyles().black
        end
        view.cardout.onClick = function()
            --[[if localUrl and #localUrl>0 and trueUrl and #trueUrl>0 then
    videoCache.stopUrl(trueUrl)
  end]]
            stopFtp()
            trueUrl = ""
            XLTaskHelper.instance().stopTask(taskId)
            if videoPlayer then
                videoPlayer.pause()
            end
            bodyIndex = position + 1
            play_name = body_datas[listIndex][2][position + 1]['标题']
            body_adapter.notifyDataSetChanged()
            playLoading.setVisibility(View.VISIBLE)
            playTitle.setText(Html.fromHtml(play_name .. "-" .. search_data[2]['标题']))
            -- hisout.setText("历史：" .. play_name .. ' 00:00')
            dataUtil.getTrueUrl({
                site = search_datas[siteIndex][1],
                url = body_datas[listIndex][2][bodyIndex]['地址'],
                callback = function(res)
                    if res.flag then

                        if res.p2pUtil then

                            p2pUtil = res.p2pUtil
                        end
                        if res.taskId or res.url == "torrent" then
                            if res.taskId then
                                taskId = res.taskId
                            end

                            if res.url == "torrent" then
                                popView(playView, res.datas, res.fileName, res.saveLocation)
                            else
                                trueUrl = res.url

                                initPlayer(trueUrl)
                            end
                        else

                            trueUrl = res.url
                            -- localUrl=videoCache.getUrl(trueUrl)
                            initPlayer(trueUrl)
                        end
                    end
                end
            })
        end
        view.cardout.onLongClick = function()
            systemUtil.copyContent(body_datas[listIndex][2][position + 1]['地址'])
        end
    end
}))

bodyout.setAdapter(body_adapter)

function setBodydatas(url, site)
    drama.setVisibility(View.GONE)
    loading.setVisibility(View.VISIBLE)
    dataUtil.getPlayDatas({
        site = site,
        url = url,
        callback = function(res)
            loading.setVisibility(View.GONE)
            drama.setVisibility(View.VISIBLE)
            if res.flag then
                -- body_adapter.clear()
                body_datas = {}
                if res.play_state then
                    state.setText(res.play_state)
                end
                for k, v in pairs(res.datas) do
                    table.insert(body_datas, {k, v})
                end
                if not play_name or #play_name == 0 then
                    play_name = body_datas[listIndex][2][bodyIndex]["标题"]
                else
                    bodyIndex = getPlayNameIndex()
                end
                bodyout.setLayoutManager(StaggeredGridLayoutManager(math.max(tointeger(width /
                                                                                           math.max(
                        dp2px(14 * (2 + utf8.len(body_datas[listIndex][2][1]['标题']))),
                        dp2px(14 * (2 + utf8.len(body_datas[listIndex][2][#body_datas[listIndex][2]]['标题']))), 160)), 1),
                    StaggeredGridLayoutManager.VERTICAL))
                body_adapter.notifyDataSetChanged()
                list_adapter.notifyDataSetChanged()
            else
                -- showToast("视频列表获取失败，已自动跳转浏览器！")

                if startsWith(url, "http") then
                    activity.newActivity("pages/webview/webview", {url})
                    showToast("视频列表获取失败，已自动跳转浏览器！")

                else
                    showToast("视频获取失败，请切换站源！")
                end

            end
        end
    })
end

setBodydatas(search_data[2]['地址'], search_data[1])

orderout.onClick = function()
    temp = {}
    local num = #body_datas[listIndex][2]
    local flag = true
    for k, v in pairs(body_datas[listIndex][2]) do
        temp[num - k + 1] = v
        if k == bodyIndex and flag then
            bodyIndex = num - k + 1
            flag = false
        end
    end
    body_datas[listIndex][2] = temp
    body_adapter.notifyDataSetChanged()
    list_adapter.notifyDataSetChanged()
end

site_adapter = LuaCustRecyclerAdapter(AdapterCreator({

    getItemCount = function()
        return #search_datas
    end,
    getItemViewType = function(position)
        return 0
    end,
    onCreateViewHolder = function(parent, viewType)
        local views = {}
        holder = LuaCustRecyclerHolder(loadlayout(item, views))
        holder.view.setTag(views)
        return holder
    end,
    onBindViewHolder = function(holder, position)
        view = holder.view.getTag()
        view.nameout.text = search_datas[position + 1][1].name
        if position + 1 == siteIndex then
            view.cardout.cardBackgroundColor = ColorStyles().blue
            view.nameout.textColor = ColorStyles().white
        else
            view.cardout.cardBackgroundColor = ColorStyles().white
            view.nameout.textColor = ColorStyles().black
        end
        view.cardout.onClick = function()
            siteIndex = position + 1
            site_adapter.notifyDataSetChanged()
            title.setText(search_datas[position + 1][2]['标题'])
            state.setText(search_datas[position + 1][2]['状态'])
            glideImg(picout, search_datas[position + 1][2]['图片'])
            siteName.setText(search_datas[position + 1][1].name)
            listIndex = 1
            bodyIndex = 1
            body_datas = {}

            setBodydatas(search_datas[position + 1][2]['地址'], search_datas[position + 1][1])
            pcall(getHeartNum, search_datas[position + 1])
        end
    end
}))
siteout.setAdapter(site_adapter)

picture.onClick = function()
    if trueUrl == "" then
        showToast("没有正在播放的视频或嗅探未完成！")
    else
        systemUtil.copyContent(trueUrl)
    end
end

function nextPlayVideo()

    --[[if localUrl and #localUrl>0 and trueUrl and #trueUrl>0 then
    videoCache.stopUrl(trueUrl)
  end

]]
    if body_datas[listIndex][2][bodyIndex + 1] then
        -- historys[1][3]['进度']=0
        bodyIndex = bodyIndex + 1
        play_name = body_datas[listIndex][2][bodyIndex]["标题"]
        XLTaskHelper.instance().stopTask(taskId)
        stopFtp()
        body_adapter.notifyDataSetChanged()
        playLoading.setVisibility(View.VISIBLE)
        playTitle.setText(Html.fromHtml(play_name .. "-" .. search_data[2]['标题']))
        dataUtil.getTrueUrl({
            site = search_datas[siteIndex][1],
            url = body_datas[listIndex][2][bodyIndex]['地址'],
            callback = function(res)
                if res.flag then
                    --[[if res.taskId then
            taskId=res.taskId
          end
          if res.url=="torrent" then
            popView(playView,res.datas,res.fileName,res.saveLocation)
           else
            trueUrl = res.url
            initPlayer(trueUrl)
          end]]
                    if res.taskId or res.url == "torrent" then
                        if res.taskId then
                            taskId = res.taskId
                        end
                        if res.url == "torrent" then
                            popView(playView, res.datas, res.fileName, res.saveLocation)
                        else
                            trueUrl = res.url

                            initPlayer(trueUrl)
                        end
                    else
                        if res.p2pUtil then

                            p2pUtil = res.p2pUtil
                        end
                        trueUrl = res.url
                        -- localUrl=videoCache.getUrl(trueUrl)
                        initPlayer(trueUrl)
                    end

                end
            end
        })
    else
        showToast("已经是最后一集啦！")
        playPause.setVisibility(View.GONE)
        playStart.setVisibility(View.VISIBLE)
    end
end

function lastPlayVideo()

    --[[if localUrl and #localUrl>0 and trueUrl and #trueUrl>0 then
    videoCache.stopUrl(trueUrl)
  end
]]

    if body_datas[listIndex][2][bodyIndex - 1] then
        -- historys[1][3]['进度']=0
        bodyIndex = bodyIndex - 1
        play_name = body_datas[listIndex][2][bodyIndex]["标题"]
        XLTaskHelper.instance().stopTask(taskId)
        stopFtp()
        body_adapter.notifyDataSetChanged()
        playLoading.setVisibility(View.VISIBLE)
        playTitle.setText(Html.fromHtml(play_name .. "-" .. search_data[2]['标题']))
        dataUtil.getTrueUrl({
            site = search_datas[siteIndex][1],
            url = body_datas[listIndex][2][bodyIndex]['地址'],
            callback = function(res)
                if res.flag then
                    --[[if res.taskId then
            taskId=res.taskId
          end
          if res.url=="torrent" then
            popView(playView,res.datas,res.fileName,res.saveLocation)
           else
            trueUrl = res.url
            initPlayer(trueUrl)
          end]]

                    if res.taskId or res.url == "torrent" then
                        if res.taskId then
                            taskId = res.taskId
                        end
                        if res.url == "torrent" then
                            popView(playView, res.datas, res.fileName, res.saveLocation)
                        else
                            trueUrl = res.url

                            initPlayer(trueUrl)
                        end
                    else
                        if res.p2pUtil then

                            p2pUtil = res.p2pUtil
                        end
                        trueUrl = res.url
                        -- localUrl=videoCache.getUrl(trueUrl)
                        initPlayer(trueUrl)
                    end

                end
            end
        })
    else
        showToast("已经是第一集啦！")
        playPause.setVisibility(View.GONE)
        playStart.setVisibility(View.VISIBLE)
    end
end

import "pages.play.media"
import "pages.play.calendar"

playLast.onClick = function()
    videoPlayer.release()
    lastPlayVideo()
end

playNext.onClick = function()
    videoPlayer.release()
    nextPlayVideo()
end

heartout.onClick = function()
    if heartout.text == "收藏" then
        setHeart(search_datas[siteIndex])
    else
        removeHeart(search_datas[siteIndex])
    end
end

hisout.onClick = function()

    --[[if localUrl and #localUrl>0 and trueUrl and #trueUrl>0 then
    videoCache.stopUrl(trueUrl)
  end
]]

    if #body_datas > 0 then
        stopFtp()
        trueUrl = ""
        play_name = body_datas[listIndex][2][bodyIndex]['标题']
        body_adapter.notifyDataSetChanged()
        playLoading.setVisibility(View.VISIBLE)
        playTitle.setText(Html.fromHtml(play_name .. "-" .. search_data[2]['标题']))
        -- hisout.setText("历史：" .. play_name .. ' 00:00')
        XLTaskHelper.instance().stopTask(taskId)
        dataUtil.getTrueUrl({
            site = search_datas[siteIndex][1],
            url = body_datas[listIndex][2][bodyIndex]['地址'],
            callback = function(res)
                if res.flag then
                    --[[if res.taskId then
            taskId=res.taskId
          end
          hisSkipFlag = true
          if res.url=="torrent" then
            popView(playView,res.datas,res.fileName,res.saveLocation)
           else
            trueUrl = res.url
            initPlayer(trueUrl)
          end]]

                    if res.taskId or res.url == "torrent" then
                        if res.taskId then
                            taskId = res.taskId
                        end
                        if res.url == "torrent" then
                            popView(playView, res.datas, res.fileName, res.saveLocation)
                        else
                            trueUrl = res.url

                            initPlayer(trueUrl)
                        end
                    else
                        if res.p2pUtil then

                            p2pUtil = res.p2pUtil
                        end

                        trueUrl = res.url
                        -- localUrl=videoCache.getUrl(trueUrl)
                        initPlayer(trueUrl)
                    end

                end
            end
        })
    else
        showToast("视频列表为空或未加载完成！")
    end
end

function onResume()

    systemUtil.hideNavigationBar()
end

import "pages.play.download"
