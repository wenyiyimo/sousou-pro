import "utils.util"
import "java.io.File"
import "utils.FileUtil"
import "utils.DataUtil"
import "com.xunlei.downloadlib.XLTaskHelper";
import "com.xunlei.downloadlib.parameter.XLTaskInfo";
import "java.io.File";
import "android.os.Environment";

XLTaskHelper.init(this);
dataUtil = DataUtil()

-- title,href,picture,state,site,playName,playHref,trueUrl,savePath,index(磁力顺序),total(磁力总数),progress
-- state 等待中 下载中 已暂停 已完成 下载失败 嗅探中
function DownloadUtil()
    local totalLine = 3 -- 总下载个数
    local flag = 0 -- 实际下载中的个数
    local line = 0 -- 已存在的下载个数
    local isFind = false -- 是否存在嗅探任务
    local results = {}
    local downFileUtil = FileUtil("download.json")
    local basePath = "/sdcard/搜搜/download/"
    local isWrite = 0
    if not File(basePath).exists() then
        File(basePath).mkdirs()
    end
    local function saveDownloads(downs)
        -- task(50, function()
        --     downFileUtil.saveDatas(downs)
        -- end)
        if isWrite > 1 then
            task(1000, saveDownloads, downs)
        else
            downFileUtil.saveDatas(downs)
            isWrite = isWrite - 1
        end

    end
    local function getDataNum(data, datas)

        for k, v in pairs(datas) do
            if v['地址'] == data['地址'] and v.playHref == data.playHref and v.playName == data.playName then
                -- if data.index then
                --     if data.index == v.index then
                --         return k
                --     end
                -- else
                return k
                -- end

            end
        end
        return -1
    end

    local function parseM3U8String(t, url)
        local result = {}
        local datas = {}
        local netUrls = {}
        local num = 0
        -- print(t)
        local lastUrl = url:match("(.+)/(.+)$")
        local startUrl, tag = url:match("(.-//.-)/(.-)/(.+)$")

        for v in ((t .. "\n")):gmatch("(.-)\n") do -- 取每一行

            if v:find("%#EXT%-X%-KEY") then
                secretUrl = v:match([[URI="(.-)"]])
                -- print(secretUrl)
                if secretUrl and #secretUrl > 2 and not startsWith(secretUrl, "http") then

                    if startsWith(secretUrl, "/") then
                        v = replace(v, [[URI="]] .. secretUrl .. [["]], [[URI="]] .. lastUrl .. secretUrl .. [["]])
                    else
                        v = replace(v, [[URI="]] .. secretUrl .. [["]], [[URI="]] .. lastUrl .. "/" .. secretUrl .. [["]])

                        -- secretUrl=lastUrl .. "/" .. secretUrl
                    end
                end
            end

            table.insert(datas, v)
            num = num + 1
            if v:find("m3u8") or v:find("ts") then -- 发现了就把该行装入table

                if startsWith(v, "http") then
                    table.insert(netUrls, {v, num})
                else
                    if v:find(tag) then
                        if startsWith(v, "/") then
                            table.insert(netUrls, {startUrl .. v, num})
                        else
                            table.insert(netUrls, {startUrl .. "/" .. v, num})
                        end
                    else
                        if startsWith(v, "/") then
                            table.insert(netUrls, {lastUrl .. v, num})
                        else
                            table.insert(netUrls, {lastUrl .. "/" .. v, num})
                        end
                    end
                end
            end
        end
        return {datas, netUrls}, t:find("ts") ~= nil
    end

    local function removeAD(rt, html)

        for k, v in pairs(rt[2]) do
            rt[1][v[2]] = v[1]
        end

        if html:find("%#EXT%-X%-DISCONTINUITY") then

            local flag = true

            newResult1 = {}
            for k, v in pairs(rt[1]) do

                if flag then
                    if v:find("%#EXT%-X%-DISCONTINUITY") then

                        lastV = rt[1][k - 1]
                        if not lastV:find("http") then
                            lastV = rt[1][k - 2]
                            if not lastV:find("http") then
                                lastV = rt[1][k - 3]
                            end
                        end
                        if not lastV:find("http") then
                            table.insert(newResult1, v)
                        else
                            local urlLength = #lastV
                            local spLength = #split(lastV, "/")
                            nextV = rt[1][k + 1]
                            if not nextV:find("http") then
                                nextV = rt[1][k + 2]
                                if not nextV:find("http") then
                                    nextV = rt[1][k + 3]
                                end
                            end
                            if not nextV:find("http") then
                                table.insert(newResult1, v)
                            else

                                if #nextV < 5 + urlLength and #nextV > urlLength - 5 and #split(nextV, "/") == spLength then
                                    table.insert(newResult1, v)
                                else

                                    flag = false
                                end
                            end

                        end

                    else
                        table.insert(newResult1, v)
                    end
                else
                    if v:find("%#EXT%-X%-DISCONTINUITY") then

                        flag = true
                    end

                end
            end

            newResult = {}
            for k, v in pairs(newResult1) do

                if v:find("http") and v:find("ts") then
                    table.insert(newResult, {v, k})
                end
            end
            return {newResult1, newResult}
        else
            -- print(html)
            return rt
        end
    end

    local function parseM3U8Url(url, item)
        Http.get(url, function(code, body)
            if code == 200 and body:find("EXTM3U") then
                if pcall(function()
                    local result, types = parseM3U8String(body, url)
                    if types == true then

                        result = removeAD(result, body)
                        -- print(dump(result))
                        task(50, function()
                            io.open(item.savePath, "w"):write(table.concat(result[1], "\n") .. "\n#EXT-X-ENDLIST" .. "\n"):close()
                        end)

                        function changeFlag()
                            flag = flag + 1
                            -- print(flag)
                        end

                        thread(function(result, item)
                            require "import"
                            import "utils.FileUtil"
                            local downFileUtil = FileUtil("download.json")
                            local pline = 8
                            local total = #result[2]
                            local downNum = 0
                            local current = 1
                            local isWrite = 0

                            local function saveDownloads(downs)
                                if isWrite > 1 then
                                    task(1000, saveDownloads, downs)
                                else
                                    downFileUtil.saveDatas(downs)
                                    isWrite = isWrite - 1
                                end
                            end

                            local function xdc(url, path)

                                return pcall(function()
                                    require "import"
                                    import "java.net.URL"
                                    local ur = URL(url)
                                    import "java.io.File"
                                    file = File(path);
                                    con = ur.openConnection();
                                    co = con.getContentLength();
                                    is1 = con.getInputStream();
                                    bs = byte[1024]
                                    local len, read = 0, 0
                                    import "java.io.FileOutputStream"
                                    wj = FileOutputStream(path);
                                    len = is1.read(bs)
                                    while len ~= -1 do
                                        wj.write(bs, 0, len);
                                        read = read + len
                                        len = is1.read(bs)
                                    end
                                    wj.close();
                                    is1.close();
                                end)

                            end

                            local function getDataNum(data, datas)

                                for k, v in pairs(datas) do
                                    if v['地址'] == data['地址'] and v.playHref == data.playHref then
                                        -- if data.index then
                                        --     if data.index == v.index then
                                        --         return k
                                        --     end
                                        -- else
                                        return k
                                        -- end

                                    end
                                end
                                return -1
                            end

                            local function downTask(num)
                                local saveTsPath = item.saveDir .. "/" .. tostring(num) .. ".ts"
                                Http.download(result[2][num][1], saveTsPath, function(a, b)
                                    -- body
                                    downNum = downNum + 1
                                    pline = pline + 1
                                    if a == 200 then
                                        result[1][result[2][num][2]] = saveTsPath
                                    end
                                end)
                                --[=[local xdc_flag = xdc(result[2][num][1], saveTsPath)
                  downNum = downNum + 1
                  pline = pline + 1
                  if xdc_flag then
                    result[1][result[2][num][2]] = saveTsPath
                  end]=]
                                --[=[if pcall( OkDownUtil().download(result[2][num][1],item.saveDir,tostring(num) .. ".ts",OkDownUtil.OnDownloadListener{
                      onDownloadSuccess=function(file)
                        downNum = downNum + 1
                        pline = pline + 1
                        result[1][result[2][num][2]] = saveTsPath
                      end,

                      onDownloadFailed=function(e)
                        downNum = downNum + 1
                        pline = pline + 1
                        showToast(dump(e))
                      end

                    }))then
                   else
                    showToast("111111")
                  end
]=]

                            end

                            local function runTask()
                                if pline > 0 then
                                    downloads = downFileUtil.getDatas()
                                    local downIndex = getDataNum(item, downloads)
                                    if downIndex > 0 then
                                        if downNum < total then
                                            item = downloads[downIndex]
                                            if downloads[downIndex].state == "已暂停" then
                                                call("changeFlag")
                                                return true
                                            else
                                                for i = 1, pline do
                                                    pline = pline - 1
                                                    if current <= total then
                                                        downTask(current)
                                                        current = current + 1
                                                    end
                                                end
                                                task(50, function(...)
                                                    io.open(item.savePath, "w"):write(
                                                        table.concat(result[1], "\n") .. "\n#EXT-X-ENDLIST" .. "\n"):close()
                                                end)

                                                downloads[downIndex].progress = tostring(downNum) .. "/" .. tostring(#result[2])
                                                if downNum == #result[2] then
                                                    downloads[downIndex].state = "已完成"
                                                end
                                                isWrite = isWrite + 1
                                                saveDownloads(downloads)

                                                task(2000, runTask)
                                            end

                                        else
                                            if downNum == #result[2] then
                                                downloads[downIndex].state = "已完成"
                                            end
                                            isWrite = isWrite + 1
                                            saveDownloads(downloads)

                                            call("changeFlag")
                                            return true
                                        end
                                    else
                                        call("changeFlag")
                                        return true
                                    end
                                end
                            end
                            runTask()

                        end, result, item)
                    else
                        parseM3U8Url(result[2][1][1], item)
                    end
                end) then

                else
                    downloads = downFileUtil.getDatas()
                    local downIndex = getDataNum(item, downloads)
                    if downIndex > 0 then
                        downloads[downIndex].state = "m3u8下载失败"
                        isWrite = isWrite + 1
                        saveDownloads(downloads)
                    end

                    flag = flag + 1

                end

            else
                downloads = downFileUtil.getDatas()
                local downIndex = getDataNum(item, downloads)
                if downIndex > 0 then
                    downloads[downIndex].state = "m3u8获取失败"
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                end

                flag = flag + 1

            end
        end)
    end
    local function convertFileSize(size)
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
    local function downloadUrl(taskId, item)
        downloads = downFileUtil.getDatas()
        local downIndex = getDataNum(item, downloads)
        if downIndex > 0 then
            item = downloads[downIndex]
            if downloads[downIndex].state == "已暂停" then
                XLTaskHelper.instance().stopTask(taskId)
                flag = flag + 1
            else
                local taskInfo = XLTaskHelper.instance().getTaskInfo(taskId);
                downloads[downIndex].progress = convertFileSize(taskInfo.mDownloadSize) .. "/" .. convertFileSize(taskInfo.mFileSize)
                if taskInfo.mTaskStatus == 2 then
                    downloads[downIndex].state = "已完成"
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                    flag = flag + 1
                elseif taskInfo.mTaskStatus == 3 then
                    downloads[downIndex].state = "下载失败"
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                    XLTaskHelper.instance().stopTask(taskId)
                    flag = flag + 1
                else
                    downloads[downIndex].state = "下载中"
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                    task(5000, function()
                        downloadUrl(taskId, item)
                    end)
                end
            end
        else
            XLTaskHelper.instance().stopTask(taskId)
            flag = flag + 1
        end

    end

    local function downloadMagnet(taskId, item)
        downloads = downFileUtil.getDatas()
        local downIndex = getDataNum(item, downloads)
        if downIndex > 0 then
            item = downloads[downIndex]
            if downloads[downIndex].state == "已暂停" then
                XLTaskHelper.instance().stopTask(taskId)
                flag = flag + 1
            else
                local taskInfo = XLTaskHelper.instance().getTaskInfo(taskId);
                downloads[downIndex].progress = convertFileSize(taskInfo.mDownloadSize) .. "/" .. convertFileSize(taskInfo.mFileSize)
                if taskInfo.mTaskStatus == 2 then
                    downloads[downIndex].state = "已完成"
                    flag = flag + 1
                    local temp = {}
                    for k, v in pairs(downloads[downIndex]) do
                        temp[k] = v
                    end

                    torrentInfo = XLTaskHelper.instance().getTorrentInfo(temp.savePath);
                    mFileCount = torrentInfo.mFileCount
                    for i = 0, mFileCount - 1 do
                        temp.index = i
                        temp.total = mFileCount
                        temp.playHref = temp.savePath
                        temp.state = "等待中"
                        temp.progress = "0/0"
                        temp.saveDir = false
                        temp.playName = luajava.astable(torrentInfo.mSubFileInfo)[i + 1]['mSubPath'] .. "/" ..
                                            luajava.astable(torrentInfo.mSubFileInfo)[i + 1]['mFileName']
                        table.insert(downloads, temp)
                    end
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                    -- for k, v in pairs(luajava.astable(torrentInfo.mSubFileInfo)) do
                    --   if #v.mSubPath > 0 then
                    --     table.insert(thunder_datas, {
                    --       name = v.mSubPath .. "/" .. v.mFileName,
                    --       size = v.mFileSize
                    --     })
                    --    else
                    --     table.insert(thunder_datas, {
                    --       name = v.mFileName,
                    --       size = v.mFileSize
                    --     })
                    --   end
                    -- end

                elseif taskInfo.mTaskStatus == 3 then
                    downloads[downIndex].state = "下载失败"
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                    XLTaskHelper.instance().stopTask(taskId)
                    flag = flag + 1
                else
                    downloads[downIndex].state = "下载中"
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                    task(5000, function()
                        downloadMagnet(taskId, item)
                    end)
                end
            end
        else
            XLTaskHelper.instance().stopTask(taskId)
            flag = flag + 1
        end

    end
    local function downloadTorrent(taskId, item)
        downloads = downFileUtil.getDatas()
        local downIndex = getDataNum(item, downloads)
        if downIndex > 0 then
            item = downloads[downIndex]
            if downloads[downIndex].state == "已暂停" then
                XLTaskHelper.instance().stopTask(taskId)
                flag = flag + 1
            else
                local taskInfo = XLTaskHelper.instance().getTaskInfo(taskId);
                downloads[downIndex].progress = convertFileSize(taskInfo.mDownloadSize) .. "/" .. convertFileSize(taskInfo.mFileSize)
                if taskInfo.mTaskStatus == 2 then
                    downloads[downIndex].state = "已完成"
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                    flag = flag + 1

                elseif taskInfo.mTaskStatus == 3 then
                    downloads[downIndex].state = "下载失败"
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                    XLTaskHelper.instance().stopTask(taskId)
                    flag = flag + 1
                else
                    downloads[downIndex].state = "下载中"
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                    task(5000, function()
                        downloadTorrent(taskId, item)
                    end)
                end
            end
        else
            XLTaskHelper.instance().stopTask(taskId)
            flag = flag + 1
        end

    end

    local function start()
        local downloads = downFileUtil.getDatas()
        line = 0
        for k, v in pairs(downloads) do
            if v.state == "嗅探中" or v.state == "下载中" then
                line = line + 1
            end
        end
        flag = totalLine - line

        for k, v in pairs(downloads) do
            if flag > 0 then
                if v.state == "等待中" then
                    flag = flag - 1
                    if v.saveDir then
                        os.execute("rm -rf " .. v.saveDir)
                    end
                    downloads[k].state = "嗅探中"
                    isWrite = isWrite + 1
                    saveDownloads(downloads)
                    if startswith(string.lower(v.playHref), "thunder") or startswith(string.lower(v.playHref), "ftp:") or
                        startswith(string.lower(v.playHref), "ed2k:") then
                        local tarPath = File(basePath .. tostring(os.time() - flag))
                        if not tarPath.exists() then
                            tarPath.mkdirs()
                        end
                        downloads[k].trueUrl = v.playHref
                        downloads[k].state = "下载中"
                        downloads[k].saveDir = tarPath.toString()
                        fileName = XLTaskHelper.instance().getFileName(v.playHref)

                        if not fileName or #fileName < 4 then
                            fileName = "index.mp4"
                        end
                        local taskId = XLTaskHelper.instance().addMagentTask(v.playHref, tarPath.toString(), fileName);
                        local savePath = File(tarPath, fileName)
                        downloads[k].savePath = savePath.toString()
                        isWrite = isWrite + 1
                        saveDownloads(downloads)
                        downloadUrl(taskId, v)

                    elseif startswith(string.lower(v.playHref), "magnet") then

                        local tarPath = File(basePath .. tostring(os.time() - flag))
                        if not tarPath.exists() then
                            tarPath.mkdirs()
                        end
                        downloads[k].trueUrl = v.playHref
                        downloads[k].state = "下载中"
                        downloads[k].saveDir = tarPath.toString()
                        local taskId = XLTaskHelper.instance().addMagentTask(v.playHref, tarPath.toString(), null);
                        fileName = XLTaskHelper.instance().getFileName(v.playHref)
                        local savePath = File(tarPath, fileName)
                        downloads[k].savePath = savePath.toString()
                        isWrite = isWrite + 1
                        saveDownloads(downloads)
                        downloadMagnet(taskId, v)

                    elseif endswith(string.lower(v.playHref), "torrent") then
                        local tarPath = File(basePath .. tostring(os.time() - flag))
                        if not tarPath.exists() then
                            tarPath.mkdirs()
                        end
                        downloads[k].trueUrl = v.playHref
                        downloads[k].state = "下载中"
                        downloads[k].saveDir = tarPath.toString()

                        taskId = XLTaskHelper.instance().addTorrentTask(v.playHref, tarPath.toString(), downloads[k].index)

                        -- local taskId = XLTaskHelper.instance().addMagentTask(v.playHref, tarPath.toString(), null);
                        -- fileName = XLTaskHelper.instance().getFileName(v.playHref)
                        local savePath = File(tarPath, v.playName)
                        downloads[k].savePath = savePath.toString()
                        isWrite = isWrite + 1
                        saveDownloads(downloads)
                        downloadTorrent(taskId, downloads[k])
                    else
                        function findVideo()
                            if isFind then
                                task(5000, findVideo)
                            else
                                isFind = true
                                dataUtil.getTrueUrl({
                                    site = v.site,
                                    url = v.playHref,
                                    callback = function(res)
                                        isFind = false
                                        downloads = downFileUtil.getDatas()
                                        local downIndex = getDataNum(v, downloads)
                                        if downIndex > 0 then
                                            if res.flag then

                                                if downloads[downIndex].state == "已暂停" then
                                                    flag = flag + 1
                                                else
                                                    local tarPath = File(basePath .. tostring(os.time() - flag))
                                                    if not tarPath.exists() then
                                                        tarPath.mkdirs()
                                                    end
                                                    downloads[downIndex].trueUrl = res.url
                                                    downloads[downIndex].state = "下载中"
                                                    downloads[downIndex].saveDir = tarPath.toString()
                                                    downloads[downIndex].progress = "0/0"
                                                    if res.url:find("m3u8") then
                                                        savePath = File(tarPath, "index.m3u8")
                                                        downloads[downIndex].savePath = savePath.toString()
                                                        isWrite = isWrite + 1
                                                        saveDownloads(downloads)

                                                        parseM3U8Url(res.url, downloads[downIndex])

                                                    else
                                                        fileName = XLTaskHelper.instance().getFileName(res.url)
                                                        if not fileName or #fileName < 4 then
                                                            fileName = "index.mp4"
                                                        end
                                                        local taskId =
                                                            XLTaskHelper.instance().addMagentTask(res.url, tarPath.toString(), fileName);

                                                        local savePath = File(tarPath, fileName)
                                                        downloads[downIndex].savePath = savePath.toString()
                                                        isWrite = isWrite + 1
                                                        saveDownloads(downloads)
                                                        downloadUrl(taskId, downloads[downIndex])

                                                    end
                                                end

                                            else
                                                downloads[downIndex].state = "嗅探失败"
                                                isWrite = isWrite + 1
                                                saveDownloads(downloads)
                                                flag = flag + 1
                                            end
                                        else
                                            flag = flag + 1
                                        end
                                    end
                                })
                            end
                        end
                        findVideo()

                    end
                end
            end
        end

        task(5000, function()
            start()
        end)

    end
    local function init()
        -- local file = VideoStorageUtils.getVideoCacheDir(this);
        local file = File("/sdcard/搜搜/download")
        if not file.exists() then
            file.mkdir()
        end

        local downloads = downFileUtil.getDatas()
        for k, v in pairs(downloads) do
            if v.state ~= "已完成" and v.state ~= "已暂停" then
                downloads[k].state = "等待中"
                downloads[k].progress = "0/0"
            end
        end
        isWrite = isWrite + 1
        saveDownloads(downloads)

        start()
        return downloads
    end

    local function convertToTable(data)
        if type(data) == "userdata" then
            data = luajava.astable(data)
        end
        for k, v in pairs(data) do

            if type(v) == "userdata" then
                data[k] = luajava.astable(v)
            end
            if type(data[k]) == "table" then
                data[k] = convertToTable(data[k])
            end
        end
        return data
    end
    local function setDownload(data)
        data = convertToTable(data)
        local downloads = downFileUtil.getDatas()
        local num = getDataNum(data, downloads)
        if num < 0 then
            table.insert(downloads, data)
            downFileUtil.setDatas(downloads)
        end
        showToast(data['标题'] .. "--" .. data.playName .. "添加成功！")
        return downloads
    end
    local function setDownloadMany(datas)
        datas = convertToTable(datas)
        local downloads = downFileUtil.getDatas()
        for k, v in pairs(datas) do
            local num = getDataNum(v, downloads)
            if num < 0 then
                table.insert(downloads, v)
                -- downFileUtil.setDatas(downloads)
            end
        end
        downFileUtil.setDatas(downloads)
        showToast("添加成功！")
        return downloads
    end

    local function getDownloads()
        return downFileUtil.getDatas()
    end

    local function clearDownloads()
        downloads = downFileUtil.getDatas()
        os.execute("rm -rf " .. "/sdcard/搜搜/download")
        downFileUtil.setDatas({})
        return {}
    end
    local function removeDownload(index)
        downloads = downFileUtil.getDatas()
        if downloads[index].saveDir then
            os.execute("rm -rf " .. downloads[index].saveDir)
        end
        table.remove(downloads, index)
        downFileUtil.setDatas(downloads)
        return downloads
    end
    local function getPlayUrl(path)
        -- body
        if path:find('m3u8') then
            return path
        else
            return XLTaskHelper.instance().getLoclUrl(path)
        end
    end

    return {
        init = init,
        setDownload = setDownload,
        getDownloads = getDownloads,
        getDataNum = getDataNum,
        saveDownloads = saveDownloads,
        setDownloadMany = setDownloadMany,
        clearDownloads = clearDownloads,
        removeDownload = removeDownload,
        getPlayUrl = getPlayUrl
    }

end
