import "utils.SimpleDataStore"
import "cjson"
import "utils.util"
import "utils.FileUtil"

function HeartUtil()
    local heartFileUtil = FileUtil("hearts.json")
    local self = {
        hearts = heartFileUtil.getDatas()
    }

    local function getHeartNum(data)
        for k, v in pairs(self.hearts) do

            if #v > 1 and v[2]['地址'] == data[2]['地址'] then
                return k
            end
        end
        return -1
    end

    local function getHearts()
        self.hearts = heartFileUtil.getDatas()
        return self.hearts;
    end
    local function setHeart(data)
        data = luajava.astable(data)
        data[1] = luajava.astable(data[1])
        data[2] = luajava.astable(data[2])
        self.hearts = getHearts()
        local num = getHeartNum(data)
        if num < 0 then
            table.insert(self.hearts, data)
            heartFileUtil.setDatas(self.hearts)
            showToast("收藏成功！")
            return self.hearts
        else
            showToast("该剧集已收藏！")
            return self.hearts
        end
    end

    local function removeHeart(data)
        self.hearts = getHearts();
        local num = getHeartNum(data)
        if num == -1 then
            showToast("该剧集未收藏！")
            return self.hearts
        else
            table.remove(self.hearts, num)
            heartFileUtil.setDatas(self.hearts)
            showToast("已取消收藏！")
            return self.hearts
        end
    end

    local function setTopHeart(data)
        self.hearts = getHearts();
        local num = getHeartNum(data)
        if num == -1 then
            showToast("该剧集未收藏！")
            return self.hearts
        else
            table.insert(self.hearts, 1, table.remove(self.hearts, num))
            heartFileUtil.setDatas(self.hearts)
            showToast("置顶成功！")
            return self.hearts
        end
    end
    local function setBottomHeart(data)
        self.hearts = getHearts()
        local num = getHeartNum(data)
        if num == -1 then
            showToast("该剧集未收藏！")
            return self.hearts
        else
            table.insert(self.hearts, table.remove(self.hearts, num))
            heartFileUtil.setDatas(self.hearts)
            showToast("置底成功！")

            return self.hearts
        end
    end

    local function clearHearts()
        self.hearts = {};
        heartFileUtil.setDatas(self.hearts)
        showToast("清除成功！")
        return self.hearts

    end

    return {
        getHearts = getHearts,
        setHeart = setHeart,
        removeHeart = removeHeart,
        setTopHeart = setTopHeart,
        setBottomHeart = setBottomHeart,
        getHeartNum = getHeartNum,
        clearHearts = clearHearts

    }
end
