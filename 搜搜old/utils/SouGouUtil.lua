require "import"
import "utils.util"
import "utils.HttpUtil"

function SouGouUtil(data)

    local function getTagUrl(self)
        local tagUrl = ""
        return string.gsub(self.url, "PAGE", tostring(self.len * self.page))
    end

    local function getClassDatas(data)
        local self = {
            page = data.page - 1,
            searchKey = data.searchKey,
            url = data.url,
            len = data.len,
            callback = data.callback
        }
        local tagUrl = getTagUrl(self)

        HttpUtil().request(tagUrl, function(code, content, cookie, header)
            if code == 200 then
                local json_data = cjson.decode(content).listData.results
                local datas = {}
                for k, v in pairs(json_data) do
                    local temp = {}
                    temp["年份"] = v.year
                    temp["标题"] = v.name
                    temp["图片"] = v.picurl
                    temp["地址"] = "https://wapv.sogou.com" .. v.url
                    temp["评分"] = v.score
                    if v.ipad_play_for_list then
                        temp["状态"] = v.ipad_play_for_list.episode
                        if v.ipad_play_for_list.episode then
                            temp["状态"] = "更新至" .. v.ipad_play_for_list.episode .. "集"
                        elseif v.date then
                            temp["状态"] = v.ipad_play_for_list.last_update
                        else
                            temp["状态"] = v.year
                        end
                    else
                        temp["状态"] = v.year
                    end
                    table.insert(datas, temp)
                end
                self.callback(true, content, nil, datas)
            end
        end)
    end
    local function getSearchDatas()

    end
    local function getPlayDatas()

    end
    return {
        getClassDatas = getClassDatas,
        getSearchDatas = getSearchDatas,
        getPlayDatas = getPlayDatas
    }

end
