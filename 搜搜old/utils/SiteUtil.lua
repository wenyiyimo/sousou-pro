function SiteUtil()
  local function getActiveClassSites()
    local sites = {}
    local temp = cjson.decode(io.open("sdcard/搜搜/sites.json"):read("*a"))
    for k, v in pairs(temp) do
      if v.isActive then
        for m, n in pairs(v.SITE) do
          if n.isClass then
            table.insert(sites, n)
          end
        end
      end
    end
    return sites
  end
  local function getHomeActiveClassSites()
    local sites = {}
    local temp = cjson.decode(io.open("sdcard/搜搜/sites.json"):read("*a"))
    for k, v in pairs(temp) do

      for m, n in pairs(v.SITE) do
        if n.isClass then
          table.insert(sites, {v.URL,n.name,n,v.NAME})
        end
      end
    end
    return sites
  end




  local function getActiveSearchSites()
    local sites = {}
    local temp = cjson.decode(io.open("sdcard/搜搜/sites.json"):read("*a"))
    for k, v in pairs(temp) do
      if v.isActive then
        for m, n in pairs(v.SITE) do
          if n.isSearch then
            table.insert(sites, n)
          end
        end
      end
    end
    return sites
  end
  local function getSites()
    local temp = io.open("sdcard/搜搜/sites.json"):read("*a")
    return cjson.decode(temp)
  end
  local function setSites(tab)
    if type(tab) == "string" then
      io.open("sdcard/搜搜/sites.json", "w"):write(tab):close()
     elseif type(tab) == "table" then

      io.open("sdcard/搜搜/sites.json", "w"):write(cjson.encode(tab)):close()
    end
  end

  local function initSites()
    --[=[local creatsite = [[
[{"isTV":true,"isSite":true,"URL":"自定义数据","isActive":true,"TV":[],"SITE":[],"NAME":"自定义数据","CONTACT":"无","AUTHOR":"无"},{"isActive":true,"SITE":[],"isSite":true,"URL":"https://gitee.com/wenyiyimo/sousou/raw/master/site.json","AUTHOR":"文墨","TV":[],"isTV":true,"CONTACT":"公众号文一一墨","NAME":"文墨订阅"}]
]]]=]
    local creatsite = [[
[{"isTV":true,"isSite":true,"URL":"自定义数据","isActive":true,"TV":[],"SITE":[],"NAME":"自定义数据","CONTACT":"无","AUTHOR":"无"}]
]]

    if File("sdcard/搜搜/sites.json").exists() then
      local sites = getSites()
      for k, v in pairs(sites) do
        if v.URL ~= "自定义数据" and v.isActive then
          Http.get(v.URL, nil, "utf8", nil, function(a, b)
            if a == 200 then
              local jsondata = cjson.decode(b)
              if judgeKeyInTable(jsondata, "NAME") and judgeKeyInTable(jsondata, "URL") and
                judgeKeyInTable(jsondata, "SITE") then
                if not judgeKeyInTable(jsondata, "CONTACT") then
                  jsondata.CONTACT = v.CONTACT
                end
                if not judgeKeyInTable(jsondata, "AUTHOR") then
                  jsondata.AUTHOR = v.AUTHOR
                end
                -- if not judgekeyintable(jsondata,"isActive") then
                jsondata.isActive = v.isActive
                -- end
                --  jsondata.isTV=true
                -- jsondata.isSite=true
                sites[k] = jsondata
                io.open("sdcard/搜搜/sites.json", "w"):write(cjson.encode(sites)):close()
                -- setting.saveString("sites",cjson.encode(sites))
               else
                showToast("数据格式错误！")
              end
             else
              showToast(v.NAME .. "更新失败！")
            end
          end)
        end
      end

     else
      File("/sdcard/搜搜").mkdir()
      local sites = cjson.decode(creatsite)
      -- showToast(dump(sites))
      for k, v in pairs(sites) do
        if v.URL ~= "自定义数据" and v.isActive then
          Http.get(v.URL, nil, "utf8", nil, function(a, b)
            if a == 200 then
              local jsondata = cjson.decode(b)
              if judgeKeyInTable(jsondata, "NAME") and judgeKeyInTable(jsondata, "URL") and
                judgeKeyInTable(jsondata, "SITE") then
                if not judgeKeyInTable(jsondata, "CONTACT") then
                  jsondata.CONTACT = v.CONTACT
                end
                if not judgeKeyInTable(jsondata, "AUTHOR") then
                  jsondata.AUTHOR = v.AUTHOR
                end
                -- if not judgekeyintable(jsondata,"isActive") then
                jsondata.isActive = v.isActive
                -- end
                --  jsondata.isTV=true
                -- jsondata.isSite=true
                sites[k] = jsondata
                io.open("sdcard/搜搜/sites.json", "w"):write(cjson.encode(sites)):close()
                -- setting.saveString("sites",cjson.encode(sites))
               else
                showToast("数据格式错误！")
              end
             else
              showToast(v.NAME .. "更新失败！")
            end
          end)
         else
          io.open("sdcard/搜搜/sites.json", "w"):write(cjson.encode(sites)):close()

        end
      end


    end
  end

  function setSiteTop(index)
    local sites = getSites()
    if (index == 1) then
      return sites
     else
      table.insert(sites, 1, table.remove(sites, index))
      setSites(sites)
      return sites
    end
  end
  function setSiteBottom(index)
    local sites = getSites()
    if (index == #sites) then
      return sites
     else
      table.insert(sites, table.remove(sites, index))
      setSites(sites)
      return sites
    end
  end
  function resetMySite(index)
    local sites = getSites()
    if sites[index].URL == "自定义数据" then
      sites[index].SITE = {}
      setSites(sites)
    end
    return sites
  end

  function deleteSite(index)
    local sites = getSites()
    if sites[index].URL ~= "自定义数据" then
      table.remove(sites, index)
      setSites(sites)
    end
    return sites
  end

  function checkSiteUrlExist(url)
    local sites = getSites()
    -- print(startswith(url,"http"))
    if not startswith(url, "http") then
      return false
    end
    for i = 1, #sites do
      if sites[i].URL == url then
        return false
      end
    end
    return true
  end

  function getMySiteIndex()
    local sites = getSites()
    for k, v in pairs(sites) do
      if (v.URL == "自定义数据") then
        return k
      end
    end
    local temp = {
      isTV = true,
      isSite = true,
      URL = "自定义数据",
      isActive = true,
      TV = {},
      SITE = {},
      NAME = "自定义数据",
      CONTACT = "无",
      AUTHOR = "无"
    }
    table.insert(sites, temp)
    setSites(sites)
    return #sites
  end

  return {
    getMySiteIndex = getMySiteIndex,
    checkSiteUrlExist = checkSiteUrlExist,
    getSites = getSites,
    setSites = setSites,
    initSites = initSites,
    setSiteTop = setSiteTop,
    setSiteBottom = setSiteBottom,
    resetMySite = resetMySite,
    deleteSite = deleteSite,
    getActiveClassSites = getActiveClassSites,
    getActiveSearchSites = getActiveSearchSites,
    getHomeActiveClassSites=getHomeActiveClassSites
  }
end
