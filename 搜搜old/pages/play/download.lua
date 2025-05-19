import "utils.DownloadUtil"
downloadUtil = DownloadUtil()
downloads = downloadUtil.getDownloads()
downloadout.onClick = function()


  playSetting= dataUtil.init({
    site = search_datas[siteIndex][1]})

  if tostring(playSetting.download)=="nil" then
   elseif not playSetting.download then
    showToast("该站源暂不支持下载！")
    return
  end
  local selectDownloads = {}
  local pop = PopupWindow(activity)
  pop.setContentView(loadlayout(downloadLayout))

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

  downList.setLayoutManager(StaggeredGridLayoutManager(math.max(tointeger(width /
  math.max(
  dp2px(14 * (2 + utf8.len(body_datas[listIndex][2][1]['标题']))),
  dp2px(14 * (2 + utf8.len(body_datas[listIndex][2][#body_datas[listIndex][2]]['标题']))), 160)), 1),
  StaggeredGridLayoutManager.VERTICAL))
  body_adapter.notifyDataSetChanged()

  down_adapter = LuaCustRecyclerAdapter(AdapterCreator({
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
      local item = {}
      item['标题'] = search_datas[siteIndex][2]['标题']
      item['图片'] = search_datas[siteIndex][2]['图片']
      item['地址'] = search_datas[siteIndex][2]["地址"]
      item.playHref = body_datas[listIndex][2][position + 1]['地址']
      item.playName = body_datas[listIndex][2][position + 1]['标题']
      item['状态'] = search_datas[siteIndex][2]["状态"]
      item.progress = "0/0"
      if downloadUtil.getDataNum(item, selectDownloads) < 0 then
        view.cardout.cardBackgroundColor = ColorStyles().white
        view.nameout.textColor = ColorStyles().black
       else

        view.cardout.cardBackgroundColor = ColorStyles().blue
        view.nameout.textColor = ColorStyles().white

      end

      view.cardout.onClick = function()
        local item = {}
        item['标题'] = search_datas[siteIndex][2]['标题']
        item['图片'] = search_datas[siteIndex][2]['图片']
        item['地址'] = search_datas[siteIndex][2]["地址"]
        item['状态'] = search_datas[siteIndex][2]["状态"]
        item.state = "等待中"
        item.playHref = body_datas[listIndex][2][position + 1]['地址']
        item.playName = body_datas[listIndex][2][position + 1]['标题']
        item.site = search_datas[siteIndex][1]
        item.progress = "0/0"
        local downIndex = downloadUtil.getDataNum(item, selectDownloads)
        if downIndex < 0 then
          view.cardout.cardBackgroundColor = ColorStyles().blue
          view.nameout.textColor = ColorStyles().white
          table.insert(selectDownloads, item)
         else
          view.cardout.cardBackgroundColor = ColorStyles().blue
          view.nameout.textColor = ColorStyles().white
          table.remove(selectDownloads, downIndex)
        end
        down_adapter.notifyDataSetChanged()
      end
    end
  }))

  downList.setAdapter(down_adapter)
  selectAll.onClick = function()
    selectDownloads = {}
    for k, v in pairs(body_datas[listIndex][2]) do
      local item = {}
      item['标题'] = search_datas[siteIndex][2]['标题']
      item['图片'] = search_datas[siteIndex][2]['图片']
      item['地址'] = search_datas[siteIndex][2]["地址"]
      item.state = "等待中"
      item.playHref = body_datas[listIndex][2][k]['地址']
      item.playName = body_datas[listIndex][2][k]['标题']
      item['状态'] = search_datas[siteIndex][2]["状态"]
      item.site = search_datas[siteIndex][1]
      item.progress = "0/0"

      table.insert(selectDownloads, item)
    end
    down_adapter.notifyDataSetChanged()
  end
  selectAllReverse.onClick = function()
    local newSelectDownloads = {}
    for k, v in pairs(body_datas[listIndex][2]) do
      local item = {}
      item['标题'] = search_datas[siteIndex][2]['标题']
      item['图片'] = search_datas[siteIndex][2]['图片']
      item['地址'] = search_datas[siteIndex][2]["地址"]
      item.state = "等待中"
      item.playHref = body_datas[listIndex][2][k]['地址']
      item.playName = body_datas[listIndex][2][k]['标题']
      item['状态'] = search_datas[siteIndex][2]["状态"]
      item.site = search_datas[siteIndex][1]
      item.progress = "0/0"
      local downIndex = downloadUtil.getDataNum(item, selectDownloads)
      if downIndex < 0 then
        table.insert(newSelectDownloads, item)
      end

    end
    selectDownloads = newSelectDownloads
    down_adapter.notifyDataSetChanged()
  end
  selectCancel.onClick = function()
    selectDownloads = {}
    down_adapter.notifyDataSetChanged()
    pop.dismiss()

  end

  selectSure.onClick = function()
    -- for k, v in pairs(selectDownloads) do
    downloadUtil.setDownloadMany(selectDownloads)

    -- activity.newActivity("pages/download/download")--跳转页面

    -- end
    pop.dismiss()
    -- showToast("添加完成!")

  end
  pop.onDismiss=function()
    body_adapter.notifyDataSetChanged()
  end
end

navdownloadout.onClick = function()
  activity.newActivity("pages/download/download")--跳转页面

end