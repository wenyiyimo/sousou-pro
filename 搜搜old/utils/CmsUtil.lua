require "import"
import "utils.util"
import "utils.HttpUtil"

function CmsUtil()

  local function getTagDatas(data)
    local self = {
      site = data.site,
      cookie = data.cookie,
      callback = data.callback
    }
    if not self.cookie then
      self.cookie = self.site.cookie
    end

    if self.site.cms_url:find("provide/vod")then
      HttpUtil().request(self.site.cms_url .. "?ac=list", self.site.class_header, self.cookie,
      function(code, content, cookie, header)
        if code == 200 then
          local datas = {}
          local tt = {}
          local mm = {}
          for k, v in pairs(cjson.decode(content).class) do
            table.insert(tt, v.type_name)
            table.insert(mm, v.type_id)
          end
          table.insert(datas, tt)
          table.insert(datas, mm)

          return self.callback({
            flag = true,
            html = content,
            datas = datas
          })
         else
          self.callback({
            flag = false,
            html = content,
            code = code,
            msg = "分类标签获取失败！"
          })
        end
      end)
     elseif self.site.cms_url:find("v1%.vod")then

      HttpUtil().request(self.site.cms_url .. "/vodPhbAll", self.site.class_header, self.cookie,
      function(code, content, cookie, header)
        if code == 200 then
          local datas = {}
          local tt = {}
          local mm = {}
          for k, v in pairs(cjson.decode(content).data.list) do
            table.insert(tt, v.vod_type_name)
            table.insert(mm, v.vod_type_id)
          end
          table.insert(datas, tt)
          table.insert(datas, mm)

          return self.callback({
            flag = true,
            html = content,
            datas = datas
          })
         else
          self.callback({
            flag = false,
            html = content,
            code = code,
            msg = "分类标签获取失败！"
          })
        end
      end)

     elseif self.site.cms_url:find("/app") or endswith(self.site.cms_url,"/app") or endswith(self.site.cms_url,"/app/")then

      HttpUtil().request(self.site.cms_url .. "/nav", self.site.class_header, self.cookie,
      function(code, content, cookie, header)
        if code == 200 then
          local datas = {}
          local tt = {}
          local mm = {}
          for k, v in pairs(cjson.decode(content).list) do
            table.insert(tt, v.type_name)
            table.insert(mm, v.type_id)
          end
          table.insert(datas, tt)
          table.insert(datas, mm)

          return self.callback({
            flag = true,
            html = content,
            datas = datas
          })
         else
          self.callback({
            flag = false,
            html = content,
            code = code,
            msg = "分类标签获取失败！"
          })
        end
      end)


    end
  end



  local function getTagUrl(self)
    if self.site.cms_url:find("provide/vod")then
      return self.site.cms_url .. "?ac=videolist&t=" .. tostring(self.tagOrders[self.tag]) .. "&pg=" ..
      tostring(self.page)
     elseif self.site.cms_url:find("v1%.vod")then
      return self.site.cms_url .. "?type=" .. tostring(self.tagOrders[self.tag]) .. "&page=" ..
      tostring(self.page)
     elseif self.site.cms_url:find("/app") or endswith(self.site.cms_url,"/app") or endswith(self.site.cms_url,"/app/")then

      return self.site.cms_url .. "/video?tid=" .. tostring(self.tagOrders[self.tag]) .. "&pg=" ..
      tostring(self.page)
    end
  end

  local function getClassDatas(data)
    local self = {
      page = data.page,
      tag = data.tag,
      site = data.site,
      classOrders = nil,
      searchOrders = nil,
      cookie = data.cookie,
      tagNames = data.tagNames,
      tagOrders = data.tagOrders,
      callback = data.callback
    }
    local url = getTagUrl(self)
    if not self.cookie then
      self.cookie = self.site.cookie
    end
    HttpUtil().request(url, self.site.class_header, self.cookie, function(code, content, cookie, header)
      if code == 200 then

        if self.site.cms_url:find("provide/vod")then

          if #cjson.decode(content).list == 0 and self.tag == 1 and #self.tagNames > 1 then
            table.remove(self.tagNames, 1)
            table.remove(self.tagOrders, 1)
            getClassDatas(self)
           else
            local datas = {}
            for k, v in pairs(cjson.decode(content).list) do
              local temp = {}
              temp["标题"] = v.vod_name
              temp["图片"] = v.vod_pic
              temp["地址"] = self.site.cms_url .. "?ac=detail&ids=" .. tostring(tointeger(v.vod_id))
              temp["评分"] = v.vod_score
              temp["状态"] = v.vod_remarks
              table.insert(datas, temp)
            end
            if length(datas) > 0 then
              return self.callback({
                flag = true,
                html = content,
                range = content,
                code = code,
                tagNames = self.tagNames,
                tagOrders = self.tagOrders,
                datas = datas
              })
             else
              return self.callback({
                flag = false,
                html = content,
                range = content,
                code = code,
                msg = "请检查获取规则！\n"
              })
            end
          end
         elseif self.site.cms_url:find("v1%.vod")then
          if #cjson.decode(content).data.list == 0 and self.tag == 1 and #self.tagNames > 1 then
            table.remove(self.tagNames, 1)
            table.remove(self.tagOrders, 1)
            getClassDatas(self)
           else
            local datas = {}
            for k, v in pairs(cjson.decode(content).data.list) do
              local temp = {}
              temp["标题"] = v.vod_name
              if startswith(v.vod_pic,"http")then
                temp["图片"] = v.vod_pic
               elseif startswith(v.vod_pic,"//")then
                temp["图片"] = "https:"..v.vod_pic
               else
                temp["图片"] = v.vod_pic

              end
              temp["地址"] = self.site.cms_url .. "/detail?vod_id=" .. tostring(tointeger(v.vod_id))
              -- temp["评分"] = v.vod_score
              temp["状态"] = v.vod_remarks
              table.insert(datas, temp)
            end
            if length(datas) > 0 then
              return self.callback({
                flag = true,
                html = content,
                range = content,
                code = code,
                tagNames = self.tagNames,
                tagOrders = self.tagOrders,
                datas = datas
              })
             else
              return self.callback({
                flag = false,
                html = content,
                range = content,
                code = code,
                msg = "请检查获取规则！\n"
              })
            end

          end

         elseif self.site.cms_url:find("/app") or endswith(self.site.cms_url,"/app") or endswith(self.site.cms_url,"/app/")then


          if #cjson.decode(content).list == 0 and self.tag == 1 and #self.tagNames > 1 then
            table.remove(self.tagNames, 1)
            table.remove(self.tagOrders, 1)
            getClassDatas(self)
           else
            local datas = {}
            for k, v in pairs(cjson.decode(content).list) do
              local temp = {}
              temp["标题"] = v.vod_name
              if startswith(v.vod_pic,"http")then
                temp["图片"] = v.vod_pic
               elseif startswith(v.vod_pic,"//")then
                temp["图片"] = "https:"..v.vod_pic
               else
                temp["图片"] = v.vod_pic

              end
              temp["地址"] = self.site.cms_url .. "/video_detail?id=" .. tostring(tointeger(v.vod_id))
              -- temp["评分"] = v.vod_score
              temp["状态"] = v.vod_remarks
              table.insert(datas, temp)
            end
            if length(datas) > 0 then
              return self.callback({
                flag = true,
                html = content,
                range = content,
                code = code,
                tagNames = self.tagNames,
                tagOrders = self.tagOrders,
                datas = datas
              })
             else
              return self.callback({
                flag = false,
                html = content,
                range = content,
                code = code,
                msg = "请检查获取规则！\n"
              })
            end

          end




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


  local function getSearchDatas(data)
    local self = {

      searchKey = data.searchKey,
      site = data.site,

      cookie = data.cookie,

      callback = data.callback
    }
    local url
    if self.site.cms_url:find("provide/vod")then
      url = self.site.cms_url .. "?ac=videolist&wd=" .. self.searchKey
     elseif self.site.cms_url:find("v1%.vod")then
      url = self.site.cms_url .. "?wd=" .. self.searchKey
     elseif self.site.cms_url:find("/app") or endswith(self.site.cms_url,"/app") or endswith(self.site.cms_url,"/app/")then
      url = self.site.cms_url .. "/search?text=" .. self.searchKey


    end
    if not self.cookie then
      self.cookie = self.site.cookie
    end
    HttpUtil().request(url, self.site.search_header, self.cookie, function(code, content, cookie, header)
      if code == 200 then
        if self.site.cms_url:find("provide/vod")then
          local datas = {}
          for k, v in pairs(cjson.decode(content).list) do
            local temp = {}
            temp["标题"] = v.vod_name
            temp["图片"] = v.vod_pic
            temp["地址"] = self.site.cms_url .. "?ac=detail&ids=" .. tostring(tointeger(v.vod_id))
            temp["评分"] = v.vod_score
            temp["状态"] = v.vod_remarks
            table.insert(datas, temp)
          end
          if length(datas) > 0 then
            return self.callback({
              flag = true,
              html = content,
              range = content,
              code = code,
              datas = datas
            })
           else
            return self.callback({
              flag = false,
              html = content,
              range = content,
              code = code,
              msg = "请检查获取规则！\n"
            })

          end
         elseif self.site.cms_url:find("v1%.vod")then

          local datas = {}
          for k, v in pairs(cjson.decode(content).data.list) do
            local temp = {}
            temp["标题"] = v.vod_name
            temp["图片"] = v.vod_pic
            temp["地址"] = self.site.cms_url .. "/detail?vod_id=" .. tostring(tointeger(v.vod_id))
            temp["评分"] = v.vod_score
            temp["状态"] = v.vod_remarks
            table.insert(datas, temp)
          end
          if length(datas) > 0 then
            return self.callback({
              flag = true,
              html = content,
              range = content,
              code = code,
              datas = datas
            })
           else
            return self.callback({
              flag = false,
              html = content,
              range = content,
              code = code,
              msg = "请检查获取规则！\n"
            })

          end

         elseif self.site.cms_url:find("/app") or endswith(self.site.cms_url,"/app") or endswith(self.site.cms_url,"/app/")then
          local datas = {}
          for k, v in pairs(cjson.decode(content).list) do
            local temp = {}
            temp["标题"] = v.vod_name
            temp["图片"] = v.vod_pic
            temp["地址"] = self.site.cms_url .. "/video_detail?id=" .. tostring(tointeger(v.vod_id))
            temp["评分"] = v.vod_score
            temp["状态"] = v.vod_remarks
            table.insert(datas, temp)
          end
          if length(datas) > 0 then
            return self.callback({
              flag = true,
              html = content,
              range = content,
              code = code,
              datas = datas
            })
           else
            return self.callback({
              flag = false,
              html = content,
              range = content,
              code = code,
              msg = "请检查获取规则！\n"
            })

          end

         else
          self.callback({
            flag = false,
            html = content,
            code = code,
            msg = "搜索页源码获取失败！"
          })

        end
      end
    end)
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
    HttpUtil().request(self.url, ua, self.cookie, function(code, content, cookie, header)
      if code == 200 then
        datas = {}

        if self.site.cms_url:find("provide/vod")then
          play_list = split(cjson.decode(content).list[1].vod_play_url, "$$$")
          play_tag_name = split(cjson.decode(content).list[1].vod_play_from, "$$$")
          play_item = {}
          for key, value in pairs(play_list) do
            local temp = split(value, "#")
            local data = {}
            for k, v in pairs(temp) do
              table.insert(data, {
                ["标题"] = split(v, "$")[1],
                ["地址"] = split(v, "$")[2]
              })

            end
            table.insert(play_item, data)
          end
          for key, item in pairs(play_item) do

            if #item > 0 then
              if play_tag_name[key] then
                datas[play_tag_name[key]] = item
               else
                datas["线路" .. tostring(key)] = item
              end
            end
          end
          if length(datas) == 0 then
            return self.callback({
              flag = false,
              code = code,
              html = content,
              play_state = cjson.decode(content).list[1].vod_remarks,
              play_tag_range = cjson.decode(content).list[1].vod_play_from,
              play_tag_name = split(cjson.decode(content).list[1].vod_play_from, "$$$"),
              play_range = cjson.decode(content).list[1].vod_play_url,
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
              play_tag_range = cjson.decode(content).list[1].vod_play_from,
              play_tag_name = split(cjson.decode(content).list[1].vod_play_from, "$$$"),
              play_range = cjson.decode(content).list[1].vod_play_url,
              play_list = play_list,
              play_item = play_item,
              datas = datas
            })

          end
         elseif self.site.cms_url:find("v1%.vod")then
          jsondata=cjson.decode(content).data

          play_list = jsondata.vod_play_list

          play_tag_range=jsondata.vod_play_list
          play_tag_name={}
          play_item = {}
          local function get_parse(parse1,parse2)
            if parse1 and parse1:find("http")then

              return split(parse1,",")[1]
            end

            if parse2 and parse2:find("http")then

              return split(parse2,",")[1]
            end
            return ""
          end


          for key, value in pairs(play_list) do
            local temp = value.urls
            local data = {}
            table.insert(play_tag_name,value.from)
            local parse1=value.player_info.parse
            local parse2=value.player_info.parse2

            local parse=get_parse(parse1,parse2)


            for k, v in pairs(temp) do

              local playUrl=v.url
              if not playUrl:find"mp4" and not playUrl:find("m3u8") and not playUrl:find("flv") then

                playUrl=parse..playUrl
                table.insert(data, {
                  ["标题"] = v.name,
                  ["地址"] = playUrl
                })
               else
                table.insert(data, {
                  ["标题"] = v.name,
                  ["地址"] = playUrl
                })
              end
            end
            table.insert(play_item, data)
          end
          for key, item in pairs(play_item) do

            if #item > 0 then
              if play_tag_name[key] then
                datas[play_tag_name[key]] = item
               else
                datas["线路" .. tostring(key)] = item
              end
            end
          end
          --print(dump(play_item))
          if length(datas) == 0 then
            return self.callback({
              flag = false,
              code = code,
              html = content,
              play_state = jsondata.vod_remarks,
              play_tag_range = dump(play_tag_range),
              play_tag_name = play_tag_name,
              play_range = dump(jsondata),
              play_list = play_list,
              play_item = play_item,
              msg = "剧集每条和获取顺序不对应！\n"
            })
           else
            return self.callback({
              flag = true,
              code = code,
              html = content,
              play_state = jsondata.vod_remarks,
              play_tag_range = dump(jsondata),
              play_tag_name = play_tag_name,
              play_range = dump(jsondata),
              play_list = play_list,
              play_item = play_item,
              datas = datas
            })

          end

         elseif self.site.cms_url:find("/app") or endswith(self.site.cms_url,"/app") or endswith(self.site.cms_url,"/app/")then


          jsondata=cjson.decode(content).data

          play_list = jsondata.vod_url_with_player

          play_tag_range=jsondata.vod_url_with_player
          play_tag_name={}
          play_item = {}
          local function get_parse(parse1,parse2)
            if parse1 and type(parse1)~="userdata" and parse1:find("http") then

              return split(parse1,",")[1]
            end

            if parse2 and type(parse2)~="userdata" and parse2:find("http")then

              return split(parse2,",")[1]
            end
            return ""
          end


          for key, value in pairs(play_list) do
            local temp = split(value.url,"#")
            local data = {}
            table.insert(play_tag_name,value.code)
            local parse1=value.parse_api


            local parse=get_parse(parse1,false)


            for k, v in pairs(temp) do
              local spData=split(v,"$")
              local playUrl=spData[2]
              if not playUrl:find"mp4" and not playUrl:find("m3u8") and not playUrl:find("flv") then

                playUrl=parse..playUrl
                table.insert(data, {
                  ["标题"] = spData[1],
                  ["地址"] = playUrl
                })
               else
                table.insert(data, {
                  ["标题"] = spData[1],
                  ["地址"] = playUrl
                })
              end
            end
            table.insert(play_item, data)
          end
          for key, item in pairs(play_item) do

            if #item > 0 then
              if play_tag_name[key] then
                datas[play_tag_name[key]] = item
               else
                datas["线路" .. tostring(key)] = item
              end
            end
          end
          --print(dump(play_item))
          if length(datas) == 0 then
            return self.callback({
              flag = false,
              code = code,
              html = content,
              play_state = jsondata.vod_remarks,
              play_tag_range = dump(play_tag_range),
              play_tag_name = play_tag_name,
              play_range = dump(jsondata),
              play_list = play_list,
              play_item = play_item,
              msg = "剧集每条和获取顺序不对应！\n"
            })
           else
            return self.callback({
              flag = true,
              code = code,
              html = content,
              play_state = jsondata.vod_remarks,
              play_tag_range = dump(jsondata),
              play_tag_name = play_tag_name,
              play_range = dump(jsondata),
              play_list = play_list,
              play_item = play_item,
              datas = datas
            })

          end

         else


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
  end
  local function judgeUrl(tab, url)
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
  local function getTrueUrl(data)
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

    if endswith(self.url, "mp4") or endswith(self.url, "m3u8") or endswith(self.url, "flv") then
      return self.callback({
        flag = true,

        url = self.url,
        msg = "获取播放地址成功！"
      })
    end


    if startswith(self.url,"http")


      if not webView2 then
        webView2 = LuaWebView(activity)
       else

        webView2.stopLoading();
        webView2.clearHistory();
      end
      webView2.getSettings().setJavaScriptEnabled(true); --支持js脚本
      -- webView2.getSettings().setPluginsEnabled(true)--支持插件
      -- webView2.getSettings().setJavaScriptCanOpenWindowsAutomatically(true); --//支持通过JS打开新窗口
      webView2.addJavascriptInterface({},"JsInterface")
      exceptstring = split(self.site.except, "&&&")
      -- 设置禁止自动播放视频
      webView2.getSettings().setMediaPlaybackRequiresUserGesture(true);
      if ua then
        webView2.loadUrl(self.url, cjson.decode(ua))
       else
        webView2.loadUrl(self.url)
      end
      local urlflag=false
      webView2.setWebViewClient {
        onLoadResource = function(view, tarurl)
          if ((tarurl:find 'mp4') or (tarurl:find 'm3u8') or (tarurl:find "flv"))
            and not endswith(tarurl,".php") and judgeUrl(exceptstring, tarurl)
            and not endswith(tarurl,".js")
            and not tarurl:find "url=http"
            and not tarurl:find(self.url)
            and not endswith(tarurl, ".css")
            and not endswith(tarurl, ".jpg")
            and not endswith(tarurl, ".png")
            and not endswith(tarurl, ".ico")
            and not endswith(tarurl, ".woff2")
            and not endswith(tarurl, ".jpeg")
            then

            if not urlflag then
              urlflag=true
              webView2.stopLoading()
              -- webView2.getSettings().setJavaScriptEnabled(false);
              --webView2.clearHistory();
              --webView2.clearView();
              --webView2.removeAllViews();
              --webView2.destroy()
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

  return {
    getClassDatas = getClassDatas,
    getSearchDatas = getSearchDatas,
    getPlayDatas = getPlayDatas,
    getTagDatas = getTagDatas,
    getTrueUrl = getTrueUrl
  }
end
