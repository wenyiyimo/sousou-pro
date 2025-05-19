import "utils.SimpleDataStore"
import "cjson"
import "utils.util"
import "utils.FileUtil"

function HistoryUtil()
    local historyFileUtil = FileUtil("historys.json")
    local self = {
        historys = historyFileUtil.getDatas()
    }

    local function getHistoryNum(data)
        for k, v in pairs(self.historys) do
            if v[3]['标题'] == data[3]['标题'] then
                return k
            end
        end
        return -1
    end

    local function getHistorys()
        self.historys = historyFileUtil.getDatas()
        return self.historys;
    end
    local function setHistory(data)
        if type(data) ~= "table" then
            data = luajava.astable(data)
        end
        if type(data[1]) ~= "table" then
            data[1] = luajava.astable(data[1])
        end
        if type(data[2]) ~= "table" then
            data[2] = luajava.astable(data[2])
        end
        if type(data[3]) ~= "table" then
            data[3] = luajava.astable(data[3])
        end
        self.historys = getHistorys()
        local num = getHistoryNum(data)
        if num < 0 then
            table.insert(self.historys, 1, data)
            if #self.historys > 100 then
                table.remove(self.historys)
            end
        else
            table.remove(self.historys, num)
            table.insert(self.historys, 1, data)
        end
        historyFileUtil.setDatas(self.historys)
        return self.historys
    end

    local function removeHistory(data)
        self.historys = getHistorys();
        local num = getHistoryNum(data)
        if num == -1 then
            showToast("该剧集无历史！")
            return self.historys
        else
            table.remove(self.historys, num)
            historyFileUtil.setDatas(self.historys)
            showToast("删除成功！")
            return self.historys
        end
    end

    local function clearHistorys()
        self.historys = {};
        historyFileUtil.setDatas(self.historys)
        showToast("清除成功！")
        return self.historys

    end

    return {
        getHistorys = getHistorys,
        setHistory = setHistory,
        removeHistory = removeHistory,
        getHistoryNum = getHistoryNum,
        clearHistorys = clearHistorys

    }
end
