require "import"
import "utils.util"
import "utils.HttpUtil"

function ReUtil()
  local function getTagUrl(self)
    local tagUrl = ""
    local page = self.page + tointeger(self.site.class_second) - 2
    if page < tointeger(self.site.class_second) then
      tagUrl = string.gsub(self.site.class_url, "PAGE", tostring(self.site.class_first))
     else
      tagUrl = string.gsub(self.site.class_url, "PAGE", tostring(page))
    end
    return string.gsub(tagUrl, "ORDER", self.tagOrders[self.tag])
  end

  local function getClassOrder(self)
    local orders = split(trim(self.site.class_order), "&&&")
    local temp = {}
    local flag, title = judgeValueInTable(orders, "标题")
    if flag then
      temp["标题"] = title
    end
    local flag, rate = judgeValueInTable(orders, "评分")
    if flag then
      temp["评分"] = rate
    end
    local flag, href = judgeValueInTable(orders, "地址")
    if flag then
      temp["地址"] = href
    end
    local flag, pic = judgeValueInTable(orders, "图片")
    if flag then
      temp["图片"] = pic
    end
    local flag, state = judgeValueInTable(orders, "状态")
    if flag then
      temp["状态"] = state
    end
    local flag, info = judgeValueInTable(orders, "介绍")
    if flag then
      temp["介绍"] = info
    end
    local flag, hot = judgeValueInTable(orders, "热度")
    if flag then
      temp["热度"] = hot
    end
    local flag, daoyan = judgeValueInTable(orders, "导演")
    if flag then
      temp["导演"] = daoyan
    end
    local flag, actor = judgeValueInTable(orders, "演员")
    if flag then
      temp["演员"] = actor
    end
    local flag, type = judgeValueInTable(orders, "类型")
    if flag then
      temp["类型"] = type
    end
    local flag, time = judgeValueInTable(orders, "时间")
    if flag then
      temp["时间"] = time
    end
    local flag, year = judgeValueInTable(orders, "年份")
    if flag then
      temp["年份"] = year
    end
    local flag, area = judgeValueInTable(orders, "地区")
    if flag then
      temp["地区"] = area
    end
    return temp
  end
  function getTagDatas(data)
    local self = {
      site = data.site,
      callback = data.callback
    }
    return self.callback({
      flag = true,
      datas = {split(data.site.class_name, "&&&"), split(data.site.class_order_key, "&&&")}
    })
  end

  local function getClassDatas(data)
    local self = {
      page = data.page,
      tag = data.tag,
      site = data.site,
      classOrders = nil,
      searchOrders = nil,
      cookie = data.cookie,
      tagNames = split(data.site.class_name, "&&&"),
      tagOrders = split(data.site.class_order_key, "&&&"),
      callback = data.callback
    }

    local tagUrl = getTagUrl(self)
    -- print(tagUrl)
    if not self.cookie then
      self.cookie = self.site.cookie
    end
    HttpUtil().request(tagUrl, self.site.class_header, self.cookie, function(code, content, cookie, header)
      if code == 200 then
        local html = content
        if self.site.class_range and #self.site.class_range > 3 then
          local res = matchonce(self.site.class_range, html)
          if not res then
            return self.callback({
              flag = false,
              html = content,
              code = code,
              msg = "数据范围匹配失败！\n"
            })
           else
            html = res
          end
        end

        if not self.site.class_item or #self.site.class_item < 4 then
          return self.callback({
            flag = false,
            code = code,
            html = content,
            range = html,
            msg = "请正确设置获取每条规则！\n"
          })

        end
        local items = matchall(self.site.class_item, html)
        if not items then
          return self.callback({
            flag = false,
            code = code,
            html = content,
            range = html,
            msg = "每条数据获取失败！\n"
          })
        end
        if not self.classOrders then
          self.classOrders = getClassOrder(self)
        end
        if not self.site.class_order:find("&&&") or length(self.classOrders) == 0 then
          return self.callback({
            flag = false,
            code = code,
            html = content,
            range = html,
            msg = "请正确设置获取顺序！\n"
          })
        end
        local datas = {}
        for k, v in pairs(items) do
          local temp = {}
          for m, n in pairs(self.classOrders) do
            temp[m] = decodestring(v[n])
            if m == "地址" and self.site.class_href and self.site.class_href:find("URL") then
              temp[m] = replace(self.site.class_href, "URL", temp[m])
            end
            if m == "图片" and self.site.class_picture and self.site.class_picture:find("URL") then
              temp[m] = replace(self.site.class_picture, "URL", temp[m])
            end
          end
          if length(temp) > 0 then
            table.insert(datas, temp)
          end
        end
        if length(datas) > 0 then
          return self.callback({
            flag = true,
            html = content,
            range = html,
            code = code,
            tagNames = self.tagNames,
            tagOrders = self.tagOrders,
            datas = datas
          })
         else
          return self.callback({
            flag = false,
            html = content,
            range = html,
            code = code,
            msg = "请检查获取规则！\n"
          })
        end
       else
        self.callback({
          flag = false,
          html = content,
          code = code,
          msg = "分类页源码获取失败！"
        })
      end
    end)
  end

  local function getSearchOrder(self)
    local orders = split(trim(self.site.search_order), "&&&")
    local temp = {}
    local flag, title = judgeValueInTable(orders, "标题")
    if flag then
      temp["标题"] = title
    end
    local flag, rate = judgeValueInTable(orders, "评分")
    if flag then
      temp["评分"] = rate
    end
    local flag, href = judgeValueInTable(orders, "地址")
    if flag then
      temp["地址"] = href
    end
    local flag, pic = judgeValueInTable(orders, "图片")
    if flag then
      temp["图片"] = pic
    end
    local flag, state = judgeValueInTable(orders, "状态")
    if flag then
      temp["状态"] = state
    end
    local flag, info = judgeValueInTable(orders, "介绍")
    if flag then
      temp["介绍"] = info
    end
    local flag, hot = judgeValueInTable(orders, "热度")
    if flag then
      temp["热度"] = hot
    end
    local flag, daoyan = judgeValueInTable(orders, "导演")
    if flag then
      temp["导演"] = daoyan
    end
    local flag, actor = judgeValueInTable(orders, "演员")
    if flag then
      temp["演员"] = actor
    end
    local flag, type = judgeValueInTable(orders, "类型")
    if flag then
      temp["类型"] = type
    end
    local flag, time = judgeValueInTable(orders, "时间")
    if flag then
      temp["时间"] = time
    end
    local flag, year = judgeValueInTable(orders, "年份")
    if flag then
      temp["年份"] = year
    end
    local flag, area = judgeValueInTable(orders, "地区")
    if flag then
      temp["地区"] = area
    end
    return temp
  end

  local function getSearchDatas(data)

    local self = {

      searchKey = data.searchKey,
      site = data.site,

      searchOrders = nil,
      cookie = data.cookie,

      callback = data.callback
    }

    local ua
    local postdata
    local url = replace(self.site.search_url, "searchKey", self.searchKey)
    if self.site.search_header and #self.site.search_header > 0 then
      ua = self.site.search_header
    end

    if self.site.search_post and #self.site.search_post > 0 then
      postdata = replace(self.site.search_post, "searchKey", self.searchKey)
    end
    if not self.cookie then
      self.cookie = self.site.cookie
    end
    HttpUtil().request(url, postdata, ua, self.cookie, function(code, content, cookie, header)
      if code == 200 then
        local html = content
        if self.site.search_range and #self.site.search_range > 3 then
          local res = matchonce(self.site.search_range, html)
          if not res then
            return self.callback({
              flag = false,
              code = code,
              html = content,
              msg = "数据范围匹配失败！\n"
            })

           else
            html = res
          end
        end
        if not self.site.search_item or #self.site.search_item < 4 then
          return self.callback({
            flag = false,
            code = code,
            html = content,
            range = html,
            msg = "请正确设置获取每条规则！\n"
          })

        end
        local items = matchall(self.site.search_item, html)
        if not items then
          return self.callback({
            flag = false,
            code = code,
            html = content,
            range = html,
            msg = "每条数据获取失败！\n"
          })

        end
        if not self.searchOrders then
          self.searchOrders = getSearchOrder(self)
        end
        if not self.site.search_order:find("&&&") or length(self.searchOrders) == 0 then
          return self.callback({
            flag = false,
            html = content,
            code = code,
            range = html,
            msg = "请正确设置获取顺序！\n"
          })

        end
        local datas = {}
        for k, v in pairs(items) do
          local temp = {}
          for m, n in pairs(self.searchOrders) do
            temp[m] = decodestring(v[n])
            if m == "地址" and self.site.search_href and self.site.search_href:find("URL") then
              temp[m] = replace(self.site.search_href, "URL", temp[m])
            end
            if m == "图片" and self.site.search_picture and self.site.search_picture:find("URL") then
              temp[m] = replace(self.site.search_picture, "URL", temp[m])
            end
          end
          if length(temp) > 0 then
            table.insert(datas, temp)
          end
        end
        if length(datas) > 0 then

          return self.callback({
            flag = true,
            html = content,
            code = code,
            range = html,
            datas = datas
          })
         else
          return self.callback({
            flag = false,
            code = code,
            html = content,
            range = html,
            msg = "请检查获取规则！\n"
          })
        end
       else
        self.callback({
          flag = false,
          code = code,
          html = content,
          msg = "搜索页源码获取失败！"
        })
      end
    end)
  end

  local function getPlayOrder(self)
    local orders = split(trim(self.site.play_order), "&&&")
    local temp = {}
    local flag, title = judgeValueInTable(orders, "标题")
    if flag then
      temp["标题"] = title
    end
    local flag, href = judgeValueInTable(orders, "地址")
    if flag then
      temp["地址"] = href
    end

    return temp
  end

  local function getPlayDatas(data)
    local self = {
      site = data.site,
      url = data.url,
      cookie = data.cookie,
      callback = data.callback
    }
    local ua
    if self.site.play_header and #self.site.play_header > 0 then
      ua = self.site.play_header
    end
    if not self.cookie then
      self.cookie = self.site.cookie
    end

    if startswith(self.url, "http") then
      HttpUtil().request(self.url, ua, self.cookie, function(code, content, cookie, header)
        local msg = ""
        local flag = true
        if code == 200 then
          local play_state = matchonce(self.site.play_state, content)
          if not play_state then
            msg = "播放页状态获取失败！\n"
          end
          local play_tag_range = content
          if self.site.play_tag_range and #self.site.play_tag_range > 1 then
            local tt = matchonce(self.site.play_tag_range, content)
            if tt then
              play_tag_range = tt
             else
              msg = '线路名称范围获取失败！\n' .. msg
            end
          end

          local play_tag_name = {}
          if self.site.play_tag_name and #self.site.play_tag_name > 1 then
            local tt = matchall(self.site.play_tag_name, play_tag_range)
            if tt then
              play_tag_name = tt
             else
              msg = '线路名称获取失败！\n' .. msg
            end
          end

          local play_range = content
          if self.site.play_range and #self.site.play_range > 1 then
            local tt = matchonce(self.site.play_range, content)
            if tt then
              play_range = tt
             else
              msg = '剧集范围获取失败！\n' .. msg
            end
          end
          local play_list = {}
          if self.site.play_list and #self.site.play_list > 1 then
            local tt = matchall(self.site.play_list, play_range)
            if tt then
              play_list = tt
            end
           else
            table.insert(play_list, play_range)
          end
          local playOrders = getPlayOrder(self)
          if not self.site.play_order:find("&&&") or length(playOrders) == 0 then
            return self.callback({
              code = code,
              flag = false,
              html = content,
              play_state = play_state,
              play_tag_range = play_tag_range,
              play_tag_name = play_tag_name,
              play_range = play_range,
              play_list = play_list,
              msg = "请正确设置获取顺序(标题&&&地址)！\n" .. msg
            })

          end
          local datas = {}
          local play_item = {}
          if self.site.play_item and #self.site.play_item > 1 then
            for key, value in pairs(play_list) do
              local temp = matchall(self.site.play_item, value)
              if temp then
                table.insert(play_item, temp)
              end
            end
          end
          if play_item == 0 then
            return self.callback({
              code = code,
              flag = false,
              html = content,
              play_state = play_state,
              play_tag_range = play_tag_range,
              play_tag_name = play_tag_name,
              play_range = play_range,
              play_list = play_list,
              msg = "请检查剧集每条获取规则！\n" .. msg
            })
          end

          for key, item in pairs(play_item) do
            data = {}
            for k, v in pairs(item) do
              local temp = {}
              for m, n in pairs(playOrders) do
                temp[m] = decodestring(v[n])
                if m == "地址" and self.site.play_href and self.site.play_href:find("URL") then
                  temp[m] = replace(self.site.play_href, "URL", temp[m])
                end
              end
              if length(temp) > 0 then
                table.insert(data, temp)
              end
            end
            if #data > 0 then
              if play_tag_name[key] then
                datas[play_tag_name[key]] = data
               else
                datas["线路" .. tostring(key)] = data
              end
            end
          end

          if length(datas) == 0 then
            return self.callback({
              flag = false,
              code = code,
              html = content,
              play_state = play_state,
              play_tag_range = play_tag_range,
              play_tag_name = play_tag_name,
              play_range = play_range,
              play_list = play_list,
              play_item = play_item,
              msg = "剧集每条和获取顺序不对应！\n" .. msg
            })
           else
            return self.callback({
              flag = true,
              code = code,
              html = content,
              play_state = play_state,
              play_tag_range = play_tag_range,
              play_tag_name = play_tag_name,
              play_range = play_range,
              play_list = play_list,
              play_item = play_item,
              datas = datas
            })

          end

         else
          self.callback({
            flag = false,
            code = code,
            html = content,
            msg = "播放页源码获取失败！"
          })
        end
      end)
     else

      content = self.url
      cookie = nil
      header = nil

      local play_state = matchonce(self.site.play_state, content)
      if not play_state then
        msg = "播放页状态获取失败！\n"
      end
      local play_tag_range = content
      if self.site.play_tag_range and #self.site.play_tag_range > 1 then
        local tt = matchonce(self.site.play_tag_range, content)
        if tt then
          play_tag_range = tt
         else
          msg = '线路名称范围获取失败！\n' .. msg
        end
      end

      local play_tag_name = {}
      if self.site.play_tag_name and #self.site.play_tag_name > 1 then
        local tt = matchall(self.site.play_tag_name, play_tag_range)
        if tt then
          play_tag_name = tt
         else
          msg = '线路名称获取失败！\n' .. msg
        end
      end

      local play_range = content
      if self.site.play_range and #self.site.play_range > 1 then
        local tt = matchonce(self.site.play_range, content)
        if tt then
          play_range = tt
         else
          msg = '剧集范围获取失败！\n' .. msg
        end
      end
      local play_list = {}
      if self.site.play_list and #self.site.play_list > 1 then
        local tt = matchall(self.site.play_list, play_range)
        if tt then
          play_list = tt
        end
       else
        table.insert(play_list, play_range)
      end
      local playOrders = getPlayOrder(self)
      if not self.site.play_order:find("&&&") or length(playOrders) == 0 then
        return self.callback({
          code = code,
          flag = false,
          html = content,
          play_state = play_state,
          play_tag_range = play_tag_range,
          play_tag_name = play_tag_name,
          play_range = play_range,
          play_list = play_list,
          msg = "请正确设置获取顺序(标题&&&地址)！\n" .. msg
        })

      end
      local datas = {}
      local play_item = {}
      for key, value in pairs(play_list) do
        local temp = matchall(self.site.play_item, value)
        if temp then
          table.insert(play_item, temp)
        end
      end
      if play_item == 0 then
        return self.callback({
          code = code,
          flag = false,
          html = content,
          play_state = play_state,
          play_tag_range = play_tag_range,
          play_tag_name = play_tag_name,
          play_range = play_range,
          play_list = play_list,
          msg = "请检查剧集每条获取规则！\n" .. msg
        })
      end

      for key, item in pairs(play_item) do
        data = {}
        for k, v in pairs(item) do
          local temp = {}
          for m, n in pairs(playOrders) do
            temp[m] = decodestring(v[n])
            if m == "地址" and self.site.play_href and self.site.play_href:find("URL") then
              temp[m] = replace(self.site.play_href, "URL", temp[m])
            end
          end
          if length(temp) > 0 then
            table.insert(data, temp)
          end
        end
        if #data > 0 then
          if play_tag_name[key] then
            datas[play_tag_name[key]] = data
           else
            datas["线路" .. tostring(key)] = data
          end
        end
      end

      if length(datas) == 0 then
        return self.callback({
          flag = false,
          code = code,
          html = content,
          play_state = play_state,
          play_tag_range = play_tag_range,
          play_tag_name = play_tag_name,
          play_range = play_range,
          play_list = play_list,
          play_item = play_item,
          msg = "剧集每条和获取顺序不对应！\n" .. msg
        })
       else
        return self.callback({
          flag = true,
          code = code,
          html = content,
          play_state = play_state,
          play_tag_range = play_tag_range,
          play_tag_name = play_tag_name,
          play_range = play_range,
          play_list = play_list,
          play_item = play_item,
          datas = datas
        })

      end

    end

  end
  function judgeUrl(tab, url)
    if #tab == 0 then
      return true
    end
    for index, content in pairs(tab) do
      if url:find(content) then
        return false
      end
    end
    return true
  end
  function getTrueUrl(data, parent)
    self = {
      site = data.site,
      url = data.url,
      cookie = data.cookie,
      callback = data.callback
    }
    local ua
    if self.site.play_header and #self.site.play_header > 0 then
      ua = self.site.play_header
    end

    if not self.cookie then
      self.cookie = self.site.cookie
    end
    if startswith(string.lower(self.url), "ftp") and self.url:find("a.gbl.") then

      import "com.sousou.utils.Jianpian"

      p2pUtil = Jianpian()

      newUrl = p2pUtil.JPUrlDec(self.url, this)
      -- if pcall(function()

      return self.callback({
        flag = true,
        p2pUtil = p2pUtil,

        url = newUrl,
        msg = "获取播放地址成功！"
      })

      --[[end)then

       else
        return self.callback({
          flag = false,
          url = "",
          msg = "获取播放地址失败！"
        })
      end]]

     elseif startswith(string.lower(self.url), "thunder") or startswith(string.lower(self.url), "magnet") or
      startswith(string.lower(self.url), "ed2k:") then

      import "com.xunlei.downloadlib.XLTaskHelper";
      import "com.xunlei.downloadlib.parameter.XLTaskInfo";
      import "java.io.File";
      import "android.os.Environment";

      XLTaskHelper.init(this);
      local saveLocation = File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).toString(),
      "/搜搜/download")
      if not saveLocation.exists() or not saveLocation.isDirectory() then
        saveLocation.mkdirs()
      end

      local fileName = ""
      local fileIndexName = ""

      local taskId = XLTaskHelper.instance().addMagentTask(self.url, saveLocation.toString(), null);
      fileName = XLTaskHelper.instance().getFileName(self.url)

      if endsWith(fileName, "torrent") then
        function getTorrentData()
          taskInfo = XLTaskHelper.instance().getTaskInfo(taskId);
          if taskInfo.mTaskStatus ~= 2 and not File(saveLocation.toString(), fileName).exists() then
            task(1000, getTorrentData)
           else

            torrentInfo = XLTaskHelper.instance().getTorrentInfo(saveLocation.toString() .. "/" .. fileName);
            mFileCount = torrentInfo.mFileCount
            thunder_datas = {}
            function convertFileSize(size)
              kb = 1024;
              mb = kb * 1024;
              gb = mb * 1024;

              if (size >= gb) then
                return tostring(tointeger(size * 100 / gb) / 100) .. "GB"
               elseif (size >= mb) then
                f = tointeger(size * 100 / mb) / 100;
                return tostring(f) .. "MB"
               elseif (size >= kb) then
                f = tointeger(size * 100 / kb) / 100;
                return tostring(f) .. "KB"
               else
                return tostring(size) .. "B"
              end

            end

            for k, v in pairs(luajava.astable(torrentInfo.mSubFileInfo)) do
              if #v.mSubPath > 0 then
                table.insert(thunder_datas, {
                  name = v.mSubPath .. "/" .. v.mFileName,
                  size = convertFileSize(v.mFileSize)
                })
               else
                table.insert(thunder_datas, {
                  name = v.mFileName,
                  size = convertFileSize(v.mFileSize)
                })

              end
            end
            if mFileCount < 2 then
              local temp = saveLocation.toString() .. "/" .. thunder_datas[1].name
              if endswith(temp, ".mp4") or endswith(temp, ".m3u8") or endswith(temp, ".flv") or endswith(temp, ".avi") or
                endswith(temp, ".mkv") or endswith(temp, ".vob") or endswith(temp, ".mov") or endswith(temp, ".3gp") or
                endswith(temp, ".mpg") or endswith(temp, ".rmvb") or endswith(temp, ".mpeg") then
                taskId = XLTaskHelper.instance().addTorrentTask(File(saveLocation.toString(), fileName).toString(),
                saveLocation.toString(), 0)

                function checkFileSize(filePath, sizeLimit)
                  local file = io.open(filePath, 'r')
                  if not file then
                    return false
                  end
                  local fileSize = file:seek("end")
                  file:close()
                  return fileSize >= sizeLimit * 1024
                end

                function getTUrl()
                  if File(temp).exists() and checkFileSize(temp, 10) then

                    return self.callback({
                      flag = true,
                      taskId = taskId,
                      url = XLTaskHelper.instance().getLoclUrl(temp),
                      msg = "获取播放地址成功！"
                    })
                   else
                    task(200, getTUrl)
                  end
                end
                return getTUrl()

               else
                return self.callback({
                  flag = false,
                  url = XLTaskHelper.instance().getLoclUrl(File(saveLocation.toString(), fileName).toString()),
                  msg = "获取播放地址失败！"
                })

              end
             else
              return self.callback({
                flag = true,
                url = "torrent",
                datas = thunder_datas,
                fileName = fileName,
                saveLocation = saveLocation,
                msg = "获取播放地址成功！"
              })

            end

          end

        end
        return getTorrentData()

       else
        local temp = fileName

        if endswith(temp, ".mp4") or endswith(temp, ".m3u8") or endswith(temp, ".flv") or endswith(temp, ".avi") or
          endswith(temp, ".mkv") or endswith(temp, ".vob") or endswith(temp, ".mov") or endswith(temp, ".3gp") or
          endswith(temp, ".mpg") or endswith(temp, ".rmvb") or endswith(temp, ".mpeg") then
          local temp_url = File(saveLocation.toString(), fileName)
          function getThunderData()
            if temp_url.exists() then

              return self.callback({
                flag = true,
                taskId = taskId,
                url = XLTaskHelper.instance().getLoclUrl(temp_url.toString()),
                msg = "获取播放地址成功！"
              })
             else
              task(200, getThunderData)

            end

          end
          return getThunderData()

         else
          return self.callback({
            flag = false,
            taskId = taskId,
            url = XLTaskHelper.instance().getLoclUrl(File(saveLocation.toString(), fileName).toString()),
            msg = "获取播放地址失败！"
          })

        end
      end

     else
      if endswith(self.url, ".mp4") or endswith(self.url, ".m3u8") or endswith(self.url, ".flv") or endswith(self.url, ".avi") or
        endswith(self.url, ".mkv") or endswith(self.url, ".vob") or endswith(self.url, ".mov") or endswith(self.url, ".3gp") or
        endswith(self.url, ".mpg") or endswith(self.url, ".mpeg") then
        return self.callback({
          flag = true,

          url = self.url,
          msg = "获取播放地址成功！"
        })
      end

      if self.site.play_next_href and #self.site.play_next_href > 2 then
        HttpUtil().request(self.url, ua, self.cookie, function(code, content, cookie, header)
          if code == 200 then
            local tt = matchonce(self.site.play_next_href, content)
            if tt then
              if self.site.play_next_href_url and self.site.play_next_href_url:find("URL") then
                tt = replace(self.site.play_next_href_url, "URL", tt)
              end
              self.callback({
                flag = true,
                code = code,
                html = content,
                url = tt,
                msg = "获取播放地址成功！"
              })
             else
              self.callback({
                flag = false,
                code = code,
                html = content,
                msg = "播放地址匹配失败！"
              })
            end
           else
            self.callback({
              flag = false,
              code = code,
              html = content,
              msg = "获取播放地址页源码获取失败！"
            })
          end
        end)
       else
        if startswith(self.url, "http") then
          if not webView2 then
            webView2 = LuaWebView(activity)
           else

            webView2.stopLoading();
            webView2.clearHistory();
          end

          webView2.getSettings().setJavaScriptEnabled(true); -- 支持js脚本
          -- webView2.getSettings().setPluginsEnabled(true)--支持插件
          -- webView2.getSettings().setJavaScriptCanOpenWindowsAutomatically(true); --//支持通过JS打开新窗口
          webView2.addJavascriptInterface({}, "JsInterface")
          exceptstring = split(self.site.except, "&&&")
          -- 设置禁止自动播放视频
          webView2.getSettings().setMediaPlaybackRequiresUserGesture(true);
          if ua then

            webView2.loadUrl(self.url, cjson.decode(ua))
           else
            -- showToast(self.url)
            webView2.loadUrl(self.url)
          end
          local urlflag = false
          webView2.setWebViewClient {
            onLoadResource = function(view, tarurl)

              if ((tarurl:find 'mp4') or (tarurl:find 'm3u8') or (tarurl:find "flv")) and not endswith(tarurl, ".php") and
                judgeUrl(exceptstring, tarurl) and not endswith(tarurl, ".js") and not tarurl:find "url=http" and
                not tarurl:find(self.url) and not endswith(tarurl, ".css") and not endswith(tarurl, ".jpg") and
                not endswith(tarurl, ".png") and not endswith(tarurl, ".ico") and not endswith(tarurl, ".woff2") and
                not endswith(tarurl, ".jpeg") and
                not endswith(tarurl, ".gif")
                then
                if not urlflag then
                  urlflag = true
                  webView2.stopLoading()
                  -- webView2.getSettings().setJavaScriptEnabled(false);
                  -- webView2.clearHistory();
                  -- webView2.clearView();
                  -- webView2.removeAllViews();
                  -- webView2.destroy()
                  self.callback({
                    flag = true,
                    code = 200,
                    url = tarurl,
                    msg = "获取播放地址成功！"
                  })
                 else
                  webView2.stopLoading()
                end
              end
            end
          }
         else

          showToast("播放地址不是http地址!")
          return self.callback({
            flag = false,

            url = self.url,
            msg = "获取播放地址失败！"
          })
        end
      end
    end
  end
  return {
    getClassDatas = getClassDatas,
    getSearchDatas = getSearchDatas,
    getPlayDatas = getPlayDatas,
    getTrueUrl = getTrueUrl,
    getTagDatas = getTagDatas
  }

end
