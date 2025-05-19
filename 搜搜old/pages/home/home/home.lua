-- 获取推荐影片结束

home_history_out.onClick = function()
  import "utils.HistoryUtil"
  historyUtil = HistoryUtil()
  historys = historyUtil.getHistorys()
  if #historys == 0 then

    activity.newActivity("pages/history/history").overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
   else
    activity.newActivity("pages/play/play", {historys[1]}).overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
  end
end

import "pages.home.home.menu"

siteNum = 1
classNum = 1
page = 1
class_datas = {}
body_datas = {}

classout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.HORIZONTAL))
siteout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.HORIZONTAL))

sites = siteUtil.getActiveClassSites()
bodyout.setLayoutManager(StaggeredGridLayoutManager(3, StaggeredGridLayoutManager.VERTICAL))

local itemc
if isMobile then
  -- tv_grid.setNumColumns(4)
  itemc = getVMcomponent()
  bodyout.setLayoutManager(StaggeredGridLayoutManager(3, StaggeredGridLayoutManager.VERTICAL))
 else
  -- tv_grid.setNumColumns(8)
  itemc = getHMcomponent()
  bodyout.setLayoutManager(StaggeredGridLayoutManager(8, StaggeredGridLayoutManager.VERTICAL))
end

if #sites == 0 then
  showToast("没有可用的站点!")
  if moreLoading then
    moreLoading.setVisibility(View.GONE)
  end
end


function getBodyDatas()

  dataUtil.getClassDatas({
    page = page,
    tag = classNum,
    site = sites[siteNum],
    tagOrders = class_datas[2],
    tagNames = class_datas[1],
    callback = function(res)
      if res.flag then
        for k, v in pairs(res.datas) do
          table.insert(body_datas, v)
        end
        body_adapter.notifyDataSetChanged()
        -- if #class_datas[1] ~= #res.tagNames then
        if res.tagNames and res.tagOrders then
          class_datas = {res.tagNames, res.tagOrders}
          class_adapter.notifyDataSetChanged()
        end
      end
    end
  })
end

body_adapter = LuaCustRecyclerAdapter(AdapterCreator({

  getItemCount = function()
    return #body_datas
  end,
  getItemViewType = function(position)
    return 0
  end,
  onCreateViewHolder = function(parent, viewType)
    local views = {}
    holder = LuaCustRecyclerHolder(loadlayout(itemc, views))
    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder = function(holder, position)
    view = holder.view.getTag()
    view.title.text = body_datas[position + 1]['标题']
    if body_datas[position + 1]['状态'] and #body_datas[position + 1]['状态'] > 0 then
      view.state.text = body_datas[position + 1]['状态']
     else
      view.state.setVisibility(View.GONE)
    end
    if body_datas[position + 1]['评分'] and #body_datas[position + 1]['评分'] > 0 then
      view.rate.text = body_datas[position + 1]['评分']
     else
      view.rate.setVisibility(View.GONE)
    end
    view.href.text = body_datas[position + 1]['地址']

    local url = body_datas[position + 1]['图片']
    glideImg(view.img, url)
    view.img.onClick = function()

      -- setting.saveString("search", cjson.encode(bodydata))
      -- getSameTitle(data[position + 1]["标题"],data[position + 1]["地址"])
      activity.newActivity("pages/play/play", {{sites[siteNum], body_datas[position + 1]}})

      -- activity.newActivity("pages/search/search/search", {view.title.text})
    end;
    if #body_datas == position + 1 and #body_datas ~= 0 then
      -- setTvDatas(tointeger((position + 1) / 10) + 1, getUrl())
      page = page + 1
      getBodyDatas()
    end

    --[[ if position<=20 then

      home_history_card_out.setVisibility(View.VISIBLE)
      --
     else

      home_history_card_out.setVisibility(View.GONE)
    end]]
  end
}))
bodyout.setAdapter(body_adapter)
bodyY=0
bodyScollState=0
bodyout.addOnScrollListener(RecyclerView.OnScrollListener{
  onScrollStateChanged=function(v,state)
    bodyScollState=state
    --停止滚动
    -- public static final int SCROLL_STATE_IDLE = 0;

    --正在被外部拖拽,一般为用户正在用手指滚动
    -- public static final int SCROLL_STATE_DRAGGING = 1;

    --自动滚动开始
    -- public static final int SCROLL_STATE_SETTLING = 2;
    --print(state)
    --if state==0 then
    if(v.canScrollVertically(1) and bodyY==0) then
      --  Toast.show("滑动到顶部");
      home_history_card_out.setVisibility(View.VISIBLE)
     else
      home_history_card_out.setVisibility(View.GONE)
    end
    --[[   if(v.canScrollVertically(-1))then
        -- Toast.show("滑动到底部");
        home_history_card_out.setVisibility(View.GONE)
       else
        home_history_card_out.setVisibility(View.VISIBLE)
      end]]

    -- end
    if bodyY>0 then
      home_history_card_out.setVisibility(View.GONE)
     else
      home_history_card_out.setVisibility(View.VISIBLE)
    end
  end,
  onScrolled=function(v,x,y)
    bodyY=bodyY+y

  end
})


class_adapter = LuaCustRecyclerAdapter(AdapterCreator({

  getItemCount = function()
    if class_datas and class_datas[1] then
      return #class_datas[1]
     else
      return 0
    end
  end,
  getItemViewType = function(position)
    return 0
  end,
  onCreateViewHolder = function(parent, viewType)
    local views = {}
    holder = LuaCustRecyclerHolder(loadlayout(getTMcomponent(), views))
    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder = function(holder, position)
    view = holder.view.getTag()
    view.text.text = class_datas[1][position + 1]
    if position + 1 == classNum then
      view.card.backgroundColor = ColorStyles().blue
      view.text.textColor = ColorStyles().white
     else
      view.card.backgroundColor = ColorStyles().white
      view.text.textColor = ColorStyles().black
    end
    view.card.onClick = function()
      page = 1
      classNum = position + 1
      class_adapter.notifyDataSetChanged()
      body_datas = {}
      body_adapter.notifyDataSetChanged()
      getBodyDatas()
    end
  end
}))

function setPictureVH()

  bodySetting= dataUtil.init({
    site = sites[siteNum]
  })
  if bodySetting.picture and type(bodySetting.picture)=="string" and string.lower(bodySetting.picture)=="horizontal" then
    if isMobile then
      -- tv_grid.setNumColumns(4)
      itemc = getVHMcomponent()
      bodyout.setLayoutManager(StaggeredGridLayoutManager(2, StaggeredGridLayoutManager.VERTICAL))
     else
      -- tv_grid.setNumColumns(8)
      itemc = getHHMcomponent()
      bodyout.setLayoutManager(StaggeredGridLayoutManager(6, StaggeredGridLayoutManager.VERTICAL))
    end

   else

    if isMobile then
      -- tv_grid.setNumColumns(4)
      itemc = getVMcomponent()
      bodyout.setLayoutManager(StaggeredGridLayoutManager(3, StaggeredGridLayoutManager.VERTICAL))
     else
      -- tv_grid.setNumColumns(8)
      itemc = getHMcomponent()
      bodyout.setLayoutManager(StaggeredGridLayoutManager(8, StaggeredGridLayoutManager.VERTICAL))
    end
  end


end


classout.setAdapter(class_adapter)
if #sites > 0 then

  setPictureVH()
  dataUtil.getTagDatas({
    site = sites[siteNum],
    callback = function(res)
      if res.flag then
        class_datas = res.datas
        class_adapter.notifyDataSetChanged()
        getBodyDatas()
      end
    end
  })
end

site_adapter = LuaCustRecyclerAdapter(AdapterCreator({

  getItemCount = function()
    return #sites
  end,
  getItemViewType = function(position)
    return 0
  end,
  onCreateViewHolder = function(parent, viewType)
    local views = {}
    holder = LuaCustRecyclerHolder(loadlayout(getTcomponent(), views))
    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder = function(holder, position)
    view = holder.view.getTag()
    view.text.text = sites[position + 1].name
    if position + 1 == siteNum then
      view.card.backgroundColor = ColorStyles().blue
      view.text.textColor = ColorStyles().white
     else
      view.card.backgroundColor = ColorStyles().white
      view.text.textColor = ColorStyles().black
    end
    view.card.onClick = function()
      siteNum = position + 1
      site_adapter.notifyDataSetChanged()
      page = 1
      classNum = 1
      class_datas = {}
      body_datas = {}
      class_adapter.notifyDataSetChanged()
      body_adapter.notifyDataSetChanged()
      setPictureVH()
      dataUtil.getTagDatas({
        site = sites[siteNum],
        callback = function(res)
          if res.flag then
            class_datas = res.datas
            class_adapter.notifyDataSetChanged()
            -- print(dump(class_datas))

            getBodyDatas()
          end
        end
      })
    end
  end
}))
siteout.setAdapter(site_adapter)