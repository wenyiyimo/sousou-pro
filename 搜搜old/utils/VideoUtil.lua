import "utils.FileUtil"
function VideoUtil()
    local videoFileUtil = FileUtil("videos.json")
    local self = {
        datas = videoFileUtil.getDatas()
    }
    local function getHisNum(data)
        for k, v in pairs(self.datas) do
            if v[1] == data[1] then
                return k
            end
        end
        return -1
    end
    local function getDatas()
        self.datas = videoFileUtil.getDatas()
        return self.datas;
    end

    local function setData(data)

        self.datas = getDatas()
        local num = getHisNum(data)
        if num < 0 then
            table.insert(self.datas, 1, data)
            if #self.datas > 100 then
                table.remove(self.datas)
            end
        else
            table.remove(self.datas, num)
            table.insert(self.datas, 1, data)
        end
        videoFileUtil.setDatas(self.datas)
        return self.datas
    end

    local function clearDatas()
        self.datas = {};
        videoFileUtil.setDatas(self.datas)
        showToast("清除成功！")
        return self.datas

    end

    local function getVideoFrame(path)
        import "android.media.MediaMetadataRetriever"

        return MediaMetadataRetriever().setDataSource(path).getFrameAtTime()

    end

    local function queryAllVideo()
        import "android.provider.MediaStore"
        cursor = activity.ContentResolver
        mImageUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
        mCursor = cursor.query(mImageUri, nil, nil, nil, MediaStore.Video.Media.DATE_TAKEN)
        mCursor.moveToLast()
        VideoTable = {}
        while mCursor.moveToPrevious() do
            path = tostring(mCursor.getString(mCursor.getColumnIndex(MediaStore.Video.Media.DATA)))
            names = split(path, "/")
            name = names[#names - 1]

            if VideoTable[name] then
                table.insert(VideoTable[name], path)
            else
                VideoTable[name] = {path}
            end
        end
        mCursor.close()
        print(dump(VideoTable))
        return VideoTable
    end

    return {
        getVideoFrame = getVideoFrame,
        queryAllVideo = queryAllVideo,
        setData = setData,
        getDatas = getDatas,
        clearDatas = clearDatas,
        getHisNum = getHisNum
    }
end
