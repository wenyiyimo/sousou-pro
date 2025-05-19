require "import"

import("common.BaseActivity");
import "pages.sougou.layout"

-- activity.getActionBar().hide()
activity.setContentView(loadlayout(layout))

local flag = true
page = 1
bodyDatas = {}
tagnum = 1
stylenum = 1
zonenum = 1
yearnum = 1
ordernum = 1

-- 设置列数开始
function setcolumn()
  if isMobile then
    -- tv_grid.setNumColumns(4)

    bodyout.setLayoutManager(StaggeredGridLayoutManager(3, StaggeredGridLayoutManager.VERTICAL))
   else

    bodyout.setLayoutManager(StaggeredGridLayoutManager(8, StaggeredGridLayoutManager.VERTICAL))
  end
end
bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))

bodyadp = LuaCustRecyclerAdapter(AdapterCreator({
  getItemCount = function()
    return #bodyDatas
  end,
  getItemViewType = function(position)
    return 0
  end,
  onCreateViewHolder = function(parent, viewType)
    local views = {}
    if flag then
      holder = LuaCustRecyclerHolder(loadlayout(itemout, views))
     else
      holder = LuaCustRecyclerHolder(loadlayout(itemlist, views))
    end
    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder = function(holder, position)
    -- print(data[position+1][1])
    local view = holder.view.getTag()
    local data = bodyDatas[position + 1]
    view.titleout.text = data.titleout
    glideImg(view.picout, data.picout)
    view.score.text = data.score

    if flag then
      view.director.text = data.director

      view.starring.text = data.starring
     else
      if not data.score or #data.score == 0 or data.score == "暂无" then
        view.score.setVisibility(View.GONE)
       else
        view.score.setVisibility(View.VISIBLE)
      end
      if not data.stateout or #data.stateout == 0 or data.stateout == "暂无" then
        view.stateout.setVisibility(View.GONE)
       else
        view.stateout.setVisibility(View.VISIBLE)
        view.stateout.text = data.stateout
      end

    end
    view.single.onClick = function()
      activity.newActivity("pages/search/search/search", {view.titleout.text})
    end;
    if #bodyDatas == position + 1 and #bodyDatas ~= 0 then
      -- print(11)
      -- lunboout.setCurrentItem(0,true)
      page = page + 1
      getbodyout(tags[tagnum], styles[stylenum], zones[zonenum], years[yearnum], orders[ordernum], page)

    end
  end
}))

bodyout.Adapter = bodyadp

-- 设置列数结束

-- 获取列表开始
function getbodyout(tag, style, zone, year, order, page)
  local url =
  "https://wapv.sogou.com/napi/video/classlist?&listTab=" .. tag .. "&start=" .. tostring((page - 1) * 15) .. "&len=15&style=" .. style ..
  "&zone=" .. zone .. "&year=" .. year .. "&order=" .. order
  -- print(url)
  Http.get(url, nil, nil, function(a, b)
    if a == 200 then
      local datas = cjson.decode(b).listData.results
      for k, v in pairs(datas) do

        if #v.score == 0 then
          v.score = "暂无"
        end
        if #v.director == 0 then
          v.director = "未知"
        end
        if #v.starring == 0 then
          v.starring = "未知"
        end
        local state = nil
        if v["play_for_list"] then
          state = "更新至" .. v["play_for_list"]["episode"] .. "集"
         elseif v["ipad_play_for_list"] and v["ipad_play_for_list"].episode then
          state = "更新至" .. v["ipad_play_for_list"]["episode"] .. "集"
         else
          state = "暂无"
        end
        -- print(flag)
        if flag then
          table.insert(bodyDatas, {
            picout = v.v_picurl,
            titleout = v.name,
            director = "导演：" .. v.director,
            starring = "演员：" .. v.starring,
            score = "评分：" .. v.score
          })
         else
          table.insert(bodyDatas, {
            picout = v.v_picurl,
            titleout = v.name,
            stateout = state,
            score = v.score
          })

        end
      end
      bodyadp.notifyDataSetChanged()
    end
  end)

end
-- 获取列表结束

-- 获取分类标签开始
tags = {"teleplay", "film", "cartoon", "tvshow", "documentary"}
tagnames = {"剧集", "电影", "动漫", "综艺", "记录片"}

orders = {"", "time", "score"}
ordernames = {"全部", "最新", "评分"}

tagadp = LuaAdapter(activity, itemc)
styleadp = LuaAdapter(activity, itemc)
zoneadp = LuaAdapter(activity, itemc)
yearadp = LuaAdapter(activity, itemc)
orderadp = LuaAdapter(activity, itemc)
taglist.Adapter = tagadp
stylelist.Adapter = styleadp
zonelist.Adapter = zoneadp
yearlist.Adapter = yearadp
orderlist.Adapter = orderadp

function setsortclass(adp, datas, name)
  adp.clear()
  for k, v in pairs(datas) do

    if v:find(name) then

      adp.add({
        card = {
          CardBackgroundColor = 0xff227CEA
        },
        text = {
          Text = v,
          TextColor = 0xffffffff
        }
      })
     else
      adp.add({
        card = {
          CardBackgroundColor = 0xffffffff
        },
        text = {
          Text = v,
          TextColor = 0x99000000
        }
      })
    end
  end

  adp.notifyDataSetChanged()
end

function getsortlist(data)
  styles = {""}
  stylenames = {"全部"}
  zones = {""}
  zonenames = {"全部"}
  years = {""}
  yearnames = {"全部"}
  for k, v in pairs(data) do
    if v.option_name == "style" then
      for m, n in pairs(v.option_list) do
        table.insert(styles, n)
        table.insert(stylenames, n)
      end
     elseif v.option_name == "zone" then
      for m, n in pairs(v.option_list) do
        table.insert(zones, n)
        table.insert(zonenames, n)
      end
     elseif v.option_name == "year" then
      for m, n in pairs(v.option_list) do
        table.insert(years, n)
        table.insert(yearnames, n)
      end
     elseif v.option_name == "emcee" then
      for m, n in pairs(v.option_list) do
        table.insert(years, n)
        table.insert(yearnames, n)
      end
    end

  end
  setsortclass(styleadp, stylenames, "全部")
  setsortclass(zoneadp, zonenames, "全部")
  setsortclass(yearadp, yearnames, "全部")
  setsortclass(orderadp, ordernames, "全部")
  bodyDatas = {}
  bodyadp.notifyDataSetChanged()

  getbodyout(tags[tagnum], styles[stylenum], zones[zonenum], years[yearnum], orders[ordernum], page)
end

function gettaghtml(tag, style, zone, year, order, page)
  local url =
  "https://wapv.sogou.com/napi/video/classlist?&listTab=" .. tag .. "&start=" .. tostring((page - 1) * 20) .. "&len=20&style=" .. style ..
  "&zone=" .. zone .. "&year=" .. year .. "&order=" .. order
  Http.get(url, nil, nil, function(a, b)
    --print(b)
    if a == 200 then
      local data = cjson.decode(b).listData.list.filter_list
      getsortlist(data)
    end
  end)
end
gettaghtml("teleplay", "", "", "", "", page)

setsortclass(tagadp, tagnames, "剧集")
taglist.onItemClick = function(parent, v, pos, p)
  tagnum = p
  page = 1
  bodyDatas = {}
  bodyadp.notifyDataSetChanged()
  gettaghtml(tags[p], "", "", "", "", page)
  setsortclass(tagadp, tagnames, tagnames[p])
end
stylelist.onItemClick = function(parent, v, pos, p)
  -- print(p)
  stylenum = p
  page = 1
  setsortclass(styleadp, stylenames, stylenames[p])
  bodyDatas = {}
  bodyadp.notifyDataSetChanged()

  getbodyout(tags[tagnum], styles[stylenum], zones[zonenum], years[yearnum], orders[ordernum], page)

end
zonelist.onItemClick = function(parent, v, pos, p)
  page = 1
  setsortclass(zoneadp, zonenames, zonenames[p])
  bodyDatas = {}
  bodyadp.notifyDataSetChanged()
  zonenum = p
  getbodyout(tags[tagnum], styles[stylenum], zones[zonenum], years[yearnum], orders[ordernum], page)
end
yearlist.onItemClick = function(parent, v, pos, p)
  yearnum = p
  page = 1
  setsortclass(yearadp, yearnames, yearnames[p])
  bodyDatas = {}
  bodyadp.notifyDataSetChanged()

  getbodyout(tags[tagnum], styles[stylenum], zones[zonenum], years[yearnum], orders[ordernum], page)
end
orderlist.onItemClick = function(parent, v, pos, p)
  page = 1
  ordernum = p
  setsortclass(orderadp, ordernames, ordernames[p])
  bodyDatas = {}
  bodyadp.notifyDataSetChanged()

  getbodyout(tags[tagnum], styles[stylenum], zones[zonenum], years[yearnum], orders[ordernum], page)
end
-- 获取分类标签结束

-- 切换分类展示开始

control.onClick = function()
  if flag then
    control.setImageBitmap(loadbitmap("static/img/class/apps.png"))
    flag = false
    page = 1
    bodyDatas = {}
    bodyout.Adapter = bodyadp
    setcolumn()
    getbodyout(tags[tagnum], styles[stylenum], zones[zonenum], years[yearnum], orders[ordernum], page)

   else
    control.setImageBitmap(loadbitmap("static/img/class/menu.png"))
    flag = true
    bodyDatas = {}
    page = 1
    bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
    bodyout.Adapter = bodyadp
    getbodyout(tags[tagnum], styles[stylenum], zones[zonenum], years[yearnum], orders[ordernum], page)
  end
end
-- 切换分类展示结束

