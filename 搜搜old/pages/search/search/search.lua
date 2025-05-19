require("import");
import("common.BaseActivity");
import("pages.search.SearchUtil");
import "pages.search.search.searchout"

import "android.text.Html"
activity.setContentView(searchout);
local searchUtil = SearchUtil(setting,settingUtil);
local searchhistory = searchUtil.searchHistory;

local sites = siteUtil.getActiveSearchSites()
local count = 1
local total = 0

if #sites==0 then
  showToast("站源为空，请添加或打开订阅!")
  activity.newActivity("pages/site/remote/remote")
end
local siteNameDatas = {}
siteNameAdp = LuaAdapter(activity, siteNameDatas, siteNameItem)
sitenameout.setAdapter(siteNameAdp)

local bodydata = {}
searchtext.text = ...
searchMode = setting.searchMode

searchUtil.setSearchHistory(searchtext.text)

searchdelete.onClick = function()
  searchtext.text = ""
  searchtip.setVisibility(View.GONE)
end

searchTipDatas = {}

searchTipAdp = LuaAdapter(activity, searchTipDatas, searchTipItem)

searchtipout.setAdapter(searchTipAdp)

searchtipout.onItemClick = function(l, v, p, i)
  searchtext.text = v.Tag.title.text
end
function popmenu()
  Http.get("https://suggest.video.iqiyi.com/?if=mobile&key=" .. searchtext.text, nil, nil, function(a, b)
    if a == 200 then
      searchTipAdp.clear()
      searchtip.setVisibility(View.VISIBLE)
      for k, v in pairs(cjson.decode(b).data) do
        table.insert(searchTipDatas, {
          title = {
            Text = v.name
          }
        })
      end
    end
  end)
end

searchtext.addTextChangedListener {
  onTextChanged = function(s)
    if #s > 0 then
      searchdelete.setVisibility(View.VISIBLE)
      popmenu()
     else
      searchtip.setVisibility(View.GONE)
      searchdelete.setVisibility(View.GONE)
    end
    -- 事件
  end
}




local data = {}

function getSameTitle(name, href)
  local temp = {}
  for k, v in pairs(bodydata) do
    for kk, vv in pairs(v[2]) do

      if vv[2]["标题"] == name and vv[2]["地址"] ~= href then
        table.insert(temp, vv)
      end
    end
  end
  return temp
end

bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
adapter = LuaCustRecyclerAdapter(AdapterCreator({

  getItemCount = function()
    return #data
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
    -- print(data[position+1][1])
    view = holder.view.getTag()
    view.nameout.text = data[position + 1][1].name
    view.titleout.text = Html.fromHtml(data[position + 1][2]['标题'])

    view.stateout.text = data[position + 1][2]['状态']
    local url = data[position + 1][2]['图片']
    --if url then
    glideImg(view.picout, url)
    -- else
    -- view.picout.setVisibility(View.GONE)
    -- end
    -- 子项目点击事件

    -- 为Item设置点击事件
    view.singleItem.onClick = function()
      -- setting.saveString("search", cjson.encode(bodydata))
      -- getSameTitle(data[position + 1]["标题"],data[position + 1]["地址"])
      activity.newActivity("pages/play/play", {data[position + 1],
        getSameTitle(data[position + 1][2]["标题"],
        data[position + 1][2]["地址"])})
    end;
    --[=[  view.singleItem.onLongClick = function()
         activity.newActivity("pages/play/detail",{item})
      end;
  ]=]
  end
}))

-- RecyclerView绑定适配器
bodyout.setAdapter(adapter)



function getSiteItem(site)
  if search_line > 0 then
    search_line = search_line - 1
    dataUtil.getSearchDatas({
      searchKey = searchtext.text,
      site = site,
      callback = function(res)
        -- print(dump(datas))
        search_line = search_line + 1
        if res.flag and res.datas and length(res.datas)>0 then

          local temp = {}
          for kk, vv in pairs(res.datas) do
            if not vv["状态"] then
              vv["状态"] = "未知"
            end
            if searchMode then
              if vv["标题"]:find(searchtext.text) then
                if count == 1 then
                  table.insert(data, {site, vv})
                end
                table.insert(temp, {site, vv})
              end
             else
              if count == 1 then
                table.insert(data, {site, vv})
              end
              table.insert(temp, {site, vv})
            end
          end
          if length(temp) > 0 then
            table.insert(bodydata, {site, temp})
            table.insert(siteNameDatas, {
              title = {
                TextColor = 0xff666666,
                BackgroundColor = 0xffffffff,
                Text = site.name
              }
            })
          end
          siteNameDatas[1].title.Text = tostring(#bodydata) .. "/" .. tostring(total)
          siteNameAdp.notifyDataSetChanged()
          adapter.notifyDataSetChanged()
        end
      end

    })
   else
    task(1000, function()

      getSiteItem(site)
    end)
  end
end
search_line = 8
function getsite()

  total = 0
  search_line = 8
  siteNameAdp.clear()
  count = 1
  table.insert(siteNameDatas, {
    title = {
      Text = "0/0",
      BackgroundColor = 0xff227CEA,
      TextColor = 0xffffffff
    }
  })

  for k, v in pairs(sites) do
    total = total + 1
    getSiteItem(v)
  end

end

getsite()

searchtip.setVisibility(View.GONE)
searchtext.setOnEditorActionListener {
  onEditorAction = function(a, b)
    if b == 3 then
      if a.text == "" then
        searchtip.setVisibility(View.GONE)
        return
       else
        searchtip.setVisibility(View.GONE)
        searchUtil.setSearchHistory(searchtext.text)
        bodydata = {}
        data = {}
        adapter.notifyDataSetChanged()
        getsite()
      end
    end
  end
}

searchevent.onClick = function()
  if searchtext.text == "" then
    return
  end
  searchUtil.setSearchHistory(searchtext.text)
  searchtip.setVisibility(View.GONE)

  bodydata = {}
  data = {}
  adapter.notifyDataSetChanged()

  getsite()
end

function onStart()
  searchtip.setVisibility(View.GONE)
  sites = siteUtil.getActiveSearchSites()
end

goback.onClick = function()
  activity.finish()
end

function updatedata()
  data = {}
  if count == 1 then
    for m, n in pairs(bodydata) do
      for k, v in pairs(n[2]) do
        table.insert(data, v)
      end
    end
   else
    for k, v in pairs(bodydata[count - 1][2]) do
      table.insert(data, v)
    end
  end
  adapter.notifyDataSetChanged()
end

sitenameout.onItemClick = function(l, v, p, i)
  siteNameDatas[count].title.TextColor = 0xff666666
  siteNameDatas[count].title.BackgroundColor = 0xffffffff
  siteNameDatas[i].title.TextColor = 0xffffffff
  siteNameDatas[i].title.BackgroundColor = 0xff227CEA
  count = i
  siteNameAdp.notifyDataSetChanged()
  updatedata()
end