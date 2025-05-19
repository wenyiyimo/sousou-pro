import("cjson");
import "utils.FileUtil"

function WebHeartUtil()

    local webFileUtil = FileUtil("webHeartHistory.json")

    local hearts = webFileUtil.getDatas()

    local function getHeartNum(data)
        for k, v in pairs(hearts) do

            if v['name'] == data.name and v.url == data.url then
                return k
            end
        end
        return -1
    end
    local function getHearts()
        hearts = webFileUtil.getDatas()
        return hearts;
    end
    local function setTopHeart(value)
        if not hearts or tostring(hearts) == "nil" then
            hearts = getHearts()
        end

        table.insert(hearts, 1, table.remove(hearts, value));

        hearts = webFileUtil.setDatas(hearts)
        return hearts
    end

    local function setHeart(value)
        if not hearts or tostring(hearts) == "nil" then
            hearts = getHearts()
        end

        local num = getHeartNum(value);
        if num < 0 then
            table.insert(hearts, 1, value);
            hearts = webFileUtil.setDatas(hearts)
        end
        return hearts
    end

    local function setBottomHeart(value)
        if not hearts or tostring(hearts) == "nil" then
            hearts = getHearts()
        end

        table.insert(hearts, table.remove(hearts, value));

        hearts = webFileUtil.setDatas(hearts)
        return hearts
    end

    local function clearHearts()
        hearts = {};
        hearts = webFileUtil.setDatas(hearts)
        return {};
    end
    local function removeHeart(key)
        if not hearts or tostring(hearts) == "nil" then
            hearts = getHearts()
        end

        table.remove(hearts, key);
        hearts = webFileUtil.setDatas(hearts)
        return hearts;
    end
    return {

        getHearts = getHearts,
        setHeart = setHeart,
        clearHearts = clearHearts,
        removeHeart = removeHeart,
        setBottomHeart = setBottomHeart,
        setTopHeart = setTopHeart
    };
end
