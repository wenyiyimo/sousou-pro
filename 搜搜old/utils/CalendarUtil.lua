import "utils.FileUtil"
function CalendarUtil()
    local calendarFileUtil = FileUtil("calendar.json")
    local self = {
        datas = calendarFileUtil.getDatas()
    }

    local function getWeek()

        local y = tonumber(os.date("%Y"))
        local m = tonumber(os.date("%m"))
        local d = tonumber(os.date("%d"))

        if m == 1 or m == 2 then
            m = m + 12
            y = y - 1
        end
        local m1, _ = math.modf(3 * (m + 1) / 5)
        local m2, _ = math.modf(y / 4)
        local m3, _ = math.modf(y / 100)
        local m4, _ = math.modf(y / 400)

        local iWeek = (d + 2 * m + m1 + y + m2 - m3 + m4) % 7

        local weekTab = {
            ["0"] = "周一",
            ["1"] = "周二", -- "星期二",
            ["2"] = "周三", -- "星期三",,
            ["3"] = "周四", -- "星期四",,
            ["4"] = "周五", -- "星期五",,
            ["5"] = "周六", -- "星期六",,
            ["6"] = "周日" -- "星期日",,
        }
        return weekTab[tostring(iWeek)]
    end

    local function getDataNum(data)
        for k, v in pairs(self.datas) do
            if v[1] == data[1] then
                return k
            end
        end
        return -1
    end
    local function getDatas()
        self.datas = calendarFileUtil.getDatas()
        return self.datas;
    end

    local function getWeekDatas()
        self.datas = calendarFileUtil.getDatas()
        local weekDatas = {{}, {}, {}, {}, {}, {}, {}}

        for k, v in pairs(self.datas) do
            if judgeValueInTable(v[3], "周一") then
                table.insert(weekDatas[1], {v[1], v[2], "周一"})
            end
            if judgeValueInTable(v[3], "周二") then
                table.insert(weekDatas[2], {v[1], v[2], "周二"})
            end
            if judgeValueInTable(v[3], "周三") then
                table.insert(weekDatas[3], {v[1], v[2], "周三"})
            end
            if judgeValueInTable(v[3], "周四") then
                table.insert(weekDatas[4], {v[1], v[2], "周四"})
            end
            if judgeValueInTable(v[3], "周五") then
                table.insert(weekDatas[5], {v[1], v[2], "周五"})
            end
            if judgeValueInTable(v[3], "周六") then
                table.insert(weekDatas[6], {v[1], v[2], "周六"})
            end
            if judgeValueInTable(v[3], "周日") then
                table.insert(weekDatas[7], {v[1], v[2], "周日"})
            end
        end
        local weekTab = {
            ["周一"] = 0,
            ["周二"] = 1, -- "星期二",
            ["周三"] = 2, -- "星期三",,
            ["周四"] = 3, -- "星期四",,
            ["周五"] = 4, -- "星期五",,
            ["周六"] = 5, -- "星期六",,
            ["周日"] = 6 -- "星期日",,
        }
        local today = getWeek()
        local num = weekTab[today]
        local tar = {weekDatas[num + 1], weekDatas[(num + 1) % 7 + 1], weekDatas[(num + 2) % 7 + 1],
                     weekDatas[(num + 3) % 7 + 1], weekDatas[(num + 4) % 7 + 1], weekDatas[(num + 5) % 7 + 1],
                     weekDatas[(num + 6) % 7 + 1]}

        local tar_datas = tableMerge(tar[1], tar[2])
        tar_datas = tableMerge(tar_datas, tar[3])
        tar_datas = tableMerge(tar_datas, tar[4])
        tar_datas = tableMerge(tar_datas, tar[5])
        tar_datas = tableMerge(tar_datas, tar[6])
        tar_datas = tableMerge(tar_datas, tar[7])
        return tar_datas, tar
    end

    local function setData(data)
        self.datas = getDatas()
        local num = getDataNum(data)
        if num < 0 then
            table.insert(self.datas, 1, data)
            if #self.datas > 100 then
                table.remove(self.datas)
                showToast("数据超过100条，已自动删除最后一条数据！")
            end
        else
            table.remove(self.datas, num)
            if #data[3] > 0 then
                table.insert(self.datas, 1, data)
            else
                showToast("已移除该条数据！")
            end
        end
        calendarFileUtil.setDatas(self.datas)
        return self.datas
    end

    local function removeData(data)
        self.datas = getDatas();
        local num = getDataNum(data)
        if num == -1 then
            showToast("该条数据不存在！")
            return self.datas
        else
            if #self.datas[num][3] < 2 then
                table.remove(self.datas, num)
                calendarFileUtil.setDatas(self.datas)
                showToast("删除成功！")
                return self.datas
            else
                local flag, num1 = judgeValueInTable(self.datas[num][3], data[3])
                if flag then
                    table.remove(self.datas[num][3], num1)
                    calendarFileUtil.setDatas(self.datas)
                    showToast("删除成功！")
                    return self.datas
                else
                    showToast("该条数据不存在！")
                    return self.datas
                end
            end
        end
    end

    local function clearDatas()
        self.datas = {};
        calendarFileUtil.setDatas(self.datas)
        showToast("清除成功！")
        return self.datas

    end
    return {
        setData = setData,
        getDatas = getDatas,
        removeData = removeData,
        clearDatas = clearDatas,
        getDataNum = getDataNum,
        getWeek = getWeek,
        getWeekDatas = getWeekDatas
    }
end
