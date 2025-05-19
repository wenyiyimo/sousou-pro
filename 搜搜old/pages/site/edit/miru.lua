if sites[siteIndex]["SITE"][itemIndex] then

  luaEditortext =sites[siteIndex]["SITE"][itemIndex].code


 else
  sites[siteIndex]["SITE"][itemIndex] = cjson.decode([[{
  "isClass": true,
  "type":"miru",
  "name": "",
  "isSearch": true,
  "code":""
 }]])

  luaEditortext =[=[
-- 返回插件配置和功能接口
-- test.setText("1111111")可以在测试的时候将内容输出到控制台
-- 打印用print不显示则用showToast(),全局参数setting对应与/sdcard/搜搜/setting.json,可配置阿里token等，调用为setting.alitoken的形式。
local host='http://api2.rinhome.com'
local headers= {
  ['User-Agent']='jianpian-android/350',
  ['JPAUTH']='y261ow7kF2dtzlxh1GS9EB8nbTxNmaK/QQIAjctlKiEv'
}

return {
  init={
   playFactory="ijk",
   download=false
  },
  -- 获取分类信息，返回一个包含分类名称和数据的table

  getTagDatas= function(data)
    -- 通过回调函数返回分类信息
    return data.callback({
      flag = true,
      datas={{"追剧","电影","综艺","动漫"},{"2","1","4","3"}}
    })
  end,
  -- 获取列表数据，根据分类数据和页码
  -- 必须提供
  getClassDatas= function(data)
    local self = {
      page = data.page,--第几页
      tag = data.tag,--分类序号
      tagOrders=data.tagOrders,--分类关键词
      callback = data.callback--回调
    }

    local url=host.."/api/crumb/list?area=0&code=unknown66e77c26fa3b1b31&category_id="..self.tagOrders[self.tag].."&year=0&limit=24&channel=wandoujia&sort=new&type=0&page="..self.page

    Http.get(url,headers,function(a,b)
      local jsondata=cjson.decode(b).data
      -- print(dump(jsondata))
      local datas={}

      for k, v in pairs(jsondata) do
        local item={}
        item["图片"]=v.path
        item["状态"]=v.playlist.title
        item["地址"]="http://api2.rinhome.com/api/node/detail?channel=wandoujia&id="..v.id
        item["标题"]=v.title
        table.insert(datas,item)
      end
      return self.callback({
        flag = true,
        datas =datas
      })
    end)
    -- return self.callback({
    --  flag = true,
    -- datas = {{["标题"]="",["图片"]="",["地址"]="",["状态"]=""}}
    --})
  end,

  -- 搜索功能，根据关键词和页码
  -- 非必须提供
  getSearchDatas = function(data)
    local self = {
      searchKey = data.searchKey,
      callback = data.callback
    }
    -- self.searchKey="仙逆"
    local url=host.."/api/video/search?page=1&key="..self.searchKey
    Http.get(url,headers,function(a,b,c,d,e)
      local jsondata=cjson.decode(b).data
      -- print(dump(jsondata))
      local datas={}

      for k, v in pairs(jsondata) do
        local item={}
        item["图片"]=v.thumbnail
        item["状态"]=v.mask
        item["地址"]="http://api2.rinhome.com/api/node/detail?channel=wandoujia&id="..v.id
        item["标题"]=v.title
        table.insert(datas,item)
      end
      return self.callback({
        flag = true,
        datas = datas
      })

    end)

    -- return self.callback({
    --  flag = true,

    -- datas = {{["标题"]="",["图片"]="",["地址"]="",["状态"]=""}}
    --})
  end,

  -- 获取详情信息，根据视频唯一标识符
  -- 必须提供
  getPlayDatas = function(data)
    local self = {
      url = data.url,
      callback = data.callback
    }



    Http.get(self.url,headers,function(a,b)
      datas={}
      local jsondata=cjson.decode(b).data
      --print(dump(jsondata))
      local state=jsondata.mask
      --  print(state)
      play_title={"迅雷","ftp","bt"}
      --print(dump(play_title))
      play_list={jsondata.xunlei_downlist,jsondata.new_ftp_list,jsondata.btbo_downlist}
      local play_item = {}

      for key, item in pairs(play_list) do

        data = {}
        for k, v in pairs(item) do
          local temp = {}
          temp["地址"]=v.url
          temp["标题"]=v.title
          if length(temp) > 0 then
            table.insert(data, temp)
          end
        end
        -- print(dump(data))
        if #data > 0 then
          if play_title[key] then

            datas[play_title[key]] = data

           else
            datas["线路" .. tostring(key)] = data
          end
        end
      end
      return self.callback({
        flag = true,
        play_state = state,
        datas = datas
      })
    end)
    --return self.callback({
    --  flag = true,
    --play_state = "更新至10集",--剧集状态
    -- datas = {["线路1"]={{["地址"]="",["标题"]=""}}}
    --})
  end,


  -- 解析播放地址，返回播放信息
  -- 不写这个函数会默认使用自带的嗅探获取，如果不设置，必须删除下面代码
  getTrueUrl = function(data)
    self = {
      url = data.url,
      callback = data.callback
    }
    self.callback({
      flag = true,
      code = 200,
      url = "",--真实播放地址
      msg = "获取播放地址成功！"
    })
  end
}



--下面是一个完整示例

--[==[
-- 返回插件配置和功能接口
return {
  -- 获取分类信息，返回一个包含分类名称和数据的table
  getTagDatas= function (data)
  -- 通过回调函数返回分类信息
  return data.callback({
    flag = true,
    datas={{"动漫","追剧","电影"},{"arts","drama","action"}}
  })
end,
  -- 获取列表数据，根据分类数据和页码
  -- 必须提供
  getClassDatas= function(data)
    local self = {
      page = data.page,--第几页
      tag = data.tag,--分类序号
      tagOrders=data.tagOrders,
      callback = data.callback
    }
    --self.page=2
    if self.page==1 then
      Http.get("https://m.lolysz.com/"..self.tagOrders[self.tag],function(a,b)
        local datas={}
        local items=matchall([[src="([^>]-)" alt="([^>]-)"/></picture>.-<h3><a href="([^>]-)" rel="bookmark">([^>]-)</a></h3>]],b)
        for k, v in pairs(items) do
          local item={}
          item["图片"]=v[1]
          item["状态"]=v[2]
          item["地址"]= "https://m.lolysz.com" ..v[3]
          item["标题"]=v[4]
          table.insert(datas,item)
        end
        return self.callback({
          flag = true,
          datas =datas
        })
      end)
     else
      Http.get(replace("https://m.lolysz.com/"..self.tagOrders[self.tag].."/index_PAGE.html","PAGE",tostring(self.page)),function(a,b)
        -- print(b)
        local datas={}
        local items=matchall([[src="([^>]-)" alt="([^>]-)"/></picture>.-<h3><a href="([^>]-)" rel="bookmark">([^>]-)</a></h3>]],b)
        for k, v in pairs(items) do
          local item={}
          item["图片"]=v[1]
          item["状态"]=v[2]
          item["地址"]= "https://m.lolysz.com" ..v[3]
          item["标题"]=v[4]
          table.insert(datas,item)
        end
        return self.callback({
          flag = true,
          datas =datas
        })
      end)
    end
  end,

  -- 搜索功能，根据关键词和页码
  -- 非必须提供
  getSearchDatas = function(data)
    local self = {
      searchKey = data.searchKey,
      callback = data.callback
    }
    Http.post("https://m.lolysz.com/e/search/index.php",{["keyboard"]=self.searchKey,["show"]="title"},function(a,b,c,d,e)
      local datas={}
      local items=matchall([[src="([^>]-)" alt="([^>]-)"/></picture>.-<h3><a href="([^>]-)" rel="bookmark">([^>]-)</a></h3>]],b)
      -- print(dump(items))
      for k, v in pairs(items) do
        local item={}
        item["图片"]=v[1]
        item["状态"]=v[2]
        item["地址"]= "https://m.lolysz.com" ..v[3]
        item["标题"]=v[4]
        table.insert(datas,item)
      end
      return self.callback({
        flag = true,
        datas = datas
      })

    end)
  end,

  -- 获取详情信息，根据视频唯一标识符
  -- 必须提供
  getPlayDatas = function(data)
    local self = {
      url = data.url,
      callback = data.callback
    }

    Http.get(self.url,function(a,b)
      datas={}
      play_list=matchall([[vod%-play%-info main(.-)剧情]],b)
      local play_item = {}
      for key, value in pairs(play_list) do
        local temp = matchall([[href="([^>]-)".->([^<]-)</a]], value)
        if temp then
          table.insert(play_item, temp)
        end
      end
      for key, item in pairs(play_item) do
        data = {}
        for k, v in pairs(item) do
          local temp = {}
          temp["地址"]=v[1]
          temp["标题"]=v[2]
          if length(temp) > 0 then
            table.insert(data, temp)
          end
        end
        if #data > 0 then

          datas["线路" .. tostring(key)] = data

        end
      end
      return self.callback({
        flag = true,
        play_state = "",
        datas = datas
      })
    end)
  end,
  -- 解析播放地址，返回播放信息
  -- 如果不设置，必须删除下面代码
  

}

]==]

]=]




end

setBodyItem("name", "站源名称", sites[siteIndex]["SITE"][itemIndex].name)

bodyout2.setVisibility(View.VISIBLE)

luaEditor.text = luaEditortext



function onStop()
  sites[siteIndex]["SITE"][itemIndex]["code"] = luaEditor.text
  if #sites[siteIndex]["SITE"][itemIndex].name >= 2 then
    local flag = true
    for k, v in pairs(sites[siteIndex].SITE) do
      if v.name == sites[siteIndex]["SITE"][itemIndex].name and k ~= itemIndex then
        flag = false
        break
      end
    end
    if flag then

      siteUtil.setSites(sites)
     else
      showToast("站源名称已存在!")
    end
   else
    showToast("站源名称至少2个字符!")
  end

end
--[[function onKeyDown(code, event) -- 返回键监听
  if string.find(tostring(event), "KEYCODE_BACK") ~= nil then

    sites[siteIndex]["SITE"][itemIndex]["code"] = luaEditor.text
    if #sites[siteIndex]["SITE"][itemIndex].name >= 2 then
      local flag = true
      for k, v in pairs(sites[siteIndex].SITE) do
        if v.name == sites[siteIndex]["SITE"][itemIndex].name and k ~= itemIndex then
          flag = false
          break
        end
      end
      if flag then

        siteUtil.setSites(sites)
       else
        showToast("站源名称已存在!")
      end
     else
      showToast("站源名称至少2个字符!")
    end
    activity.finish()

    return true
  end

end
function save()

  sites[siteIndex]["SITE"][itemIndex]["code"] = luaEditor.text
  if #sites[siteIndex]["SITE"][itemIndex].name >= 2 then
    local flag = true
    for k, v in pairs(sites[siteIndex].SITE) do
      if v.name == sites[siteIndex]["SITE"][itemIndex].name and k ~= itemIndex then
        flag = false
        break
      end
    end
    if flag then

      siteUtil.setSites(sites)
     else
      showToast("站源名称已存在!")
    end
   else
    showToast("站源名称至少2个字符!")
  end
  task(1000,save)
end
]]
--save()

editSiteout.onClick=function()
  luaEditor.format()
end
editSiteout.setVisibility(View.VISIBLE)
editundo.setVisibility(View.VISIBLE)

editredo.setVisibility(View.VISIBLE)

editundo.onClick=function()
  luaEditor.undo()
end

editredo.onClick=function()
  luaEditor.redo()
end


--import "android.graphics.drawable.ColorDrawable"

--activity.getActionBar().setBackgroundDrawable(ColorDrawable(0xffffffff))
--activity.setTheme(android.R.style.Theme_Material_Light)
--activity.getSupportActionBar().setBackgroundDrawable(ColorDrawable(0xffffffff))