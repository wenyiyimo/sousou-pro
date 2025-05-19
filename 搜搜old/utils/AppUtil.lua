require "import"
import "utils.util"
import "utils.HttpUtil"

function AppUtil()
    local function getTagUrl(self)

        return self.site.cms_url .. "?ac=videolist&t=" .. tostring(self.tagOrders[self.tag]) .. "&pg=" ..
                   tostring(self.page)
    end

    function getClassDatas(data)
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
    function getTagDatas(data)
        local self = {
            site = data.site,
            cookie = data.cookie,
            callback = data.callback
        }
        if not self.cookie then
            self.cookie = self.site.cookie
        end
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
    end

    function getSearchDatas(data)
        local self = {

            searchKey = data.searchKey,
            site = data.site,

            cookie = data.cookie,

            callback = data.callback
        }

        local url = self.site.cms_url .. "?ac=videolist&wd=" .. self.searchKey

        if not self.cookie then
            self.cookie = self.site.cookie
        end
        HttpUtil().request(url, self.site.search_header, self.cookie, function(code, content, cookie, header)
            if code == 200 then

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
            else
                self.callback({
                    flag = false,
                    html = content,
                    code = code,
                    msg = "搜索页源码获取失败！"
                })
            end
        end)
    end
    function getPlayDatas(data)

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
    function getTrueUrl(data)
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

        webView2 = LuaWebView(activity)

        exceptstring = split(self.site.except, "&&&")
        -- 设置禁止自动播放视频
        webView2.getSettings().setMediaPlaybackRequiresUserGesture(true);
        if ua then
            webView2.loadUrl(self.url, cjson.decode(ua))
        else
            webView2.loadUrl(self.url)
        end

        webView2.setWebViewClient {
            onLoadResource = function(view, tarurl)
                if ((tarurl:find 'mp4') or (tarurl:find 'm3u8') or (tarurl:find "flv")) and
                    judgeUrl(exceptstring, tarurl) then

                    webView2.stopLoading()
                    self.callback({
                        flag = true,
                        code = 200,

                        url = tarurl,
                        msg = "获取播放地址成功！"
                    })

                end
            end
        }
    end

    return {
        getClassDatas = getClassDatas,
        getSearchDatas = getSearchDatas,
        getPlayDatas = getPlayDatas,
        getTagDatas = getTagDatas,
        getTrueUrl = getTrueUrl
    }
end
