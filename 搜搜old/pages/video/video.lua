require("import");
import("common.BaseActivity");
import "pages.video.layout"

import "utils.VideoUtil"
videoUtil = VideoUtil()

videos = {}
videoTable = {}

activity.setContentView(layout);

bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))

adapter = LuaCustRecyclerAdapter(AdapterCreator({

  getItemCount = function()
    videoTable = {}
    for k, v in pairs(videos) do
      table.insert(videoTable, {k, v})
    end
    return #videoTable
  end,

  getItemViewType = function(position)
    return 0
  end,

  onCreateViewHolder = function(parent, viewType)
    local views = {}
    holder = LuaCustRecyclerHolder(loadlayout(itemout, views))
    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder = function(holder, position)
    -- print(hearts[position+1][1])
    view = holder.view.getTag()

    -- view.nameout.text = "来源：" .. hearts[position + 1][1].name
    view.titleout.text = videoTable[position + 1][1]
    view.stateout.text = #videoTable[position + 1][2][2] .. "个视频"
    -- local url = hearts[position + 1][2]['图片']
    -- view.picout.setImageBitmap(videoTable[position + 1][2][1])
    glideImg(view.picout, videoTable[position + 1][2][1])
    -- glideImg(view.picout, url)

    -- 子项目点击事件

    -- 为Item设置点击事件
    view.singleItem.onClick = function()
      -- setting.saveString("search", cjson.encode(bodyhearts))
      -- getSameTitle(hearts[position + 1]["标题"],hearts[position + 1]["地址"])
      -- activity.newActivity("pages/play/play", {hearts[position + 1]})
      activity.newActivity("pages/video/play", {videoTable[position + 1][2][2]})
    end;

  end
}))

-- RecyclerView绑定适配器
bodyout.setAdapter(adapter)

function updatePic()

  for k,v in pairs(videos)do
    if not videos[k][1] then
      local picFlag, pic = pcall(videoUtil.getVideoFrame, videos[k][2][1])
      if picFlag then
        videos[k][1]=pic

        adapter.notifyDataSetChanged()

      end
      return task(1000,updatePic)
    end
  end
end



function addVideo(path, flag)
  if flag then
    names = split(path, "/")
    name = names[#names - 1]

    if videos[name] then
      table.insert(videos[name][2], path)
     else
      -- local picFlag, pic = pcall(videoUtil.getVideoFrame, path)
      -- if picFlag then
      videos[name] = {nil, {path}}
      -- adapter.notifyDataSetChanged()
      --  end
    end

   else
    --  showToast("视频列表加载完成！")
    adapter.notifyDataSetChanged()
    task(200, updatePic)
  end
  ----print(path)
end


--[[videoFlag=false
function QueryAllVideo(path)

  local t=os.clock()
  local ret={}
  require "import"
  import "java.io.File"
  import "java.lang.String"
  import"utils.util"


  function FindFile(catalog)

    local ls=catalog.listFiles() or File{}
    for 次数=0,#ls-1 do
      --local 目录=tostring(ls[次数])
      local f=ls[次数]
      if f.isDirectory() then--如果是文件夹则继续匹配
        FindFile(f)
       else--如果是文件则

        local nm=f.Name
        local tar={
          ".rmvb",
          ".avi",
          ".mkv",
          ".flv",
          ".mp4",
          ".rm",
          ".vob",
          ".wmv",
          ".mov",
          ".3gp",
          ".asf",
          ".mpg",
          ".mpeg",

        }
        local function getFlag(name,tar)
          for k,v in pairs(tar) do
            if name and endswith(name,v) then
              return true
            end
          end
          return false
        end


        if getFlag(nm,tar) then
          --thread(insert,目录)

          call("addVideo", tostring(f), true)

        end
      end
      luajava.clear(f)
    end
  end
  FindFile(File(path))
  --call("outPath",ret)
  call("addVideo", nil, false)

  Thread.currentThread().interrupt()

end
-- 返回一个表

--function onResume()
videos = {}

-- adapter.notifyDataSetChanged()
--end
datas={}
local ls=File("/sdcard").listFiles() or File{}
for 次数=0,#ls-1 do
  local f=ls[次数]
  if f.isDirectory() then--如果是文件夹则继续匹配

    table.insert(datas,tostring(f))
   else--如果是文件则

    local nm=f.Name
    local tar={
      ".rmvb",
      ".avi",
      ".mkv",
      ".flv",
      ".mp4",
      ".rm",
      ".vob",
      ".wmv",
      ".mov",
      ".3gp",
      ".asf",
      ".mpg",
      ".mpeg",

    }
    local function getFlag(name,tar)
      for k,v in pairs(tar) do
        if name and endswith(name,v) then
          return true
        end
      end
      return false
    end


    if getFlag(nm,tar) then
      --thread(insert,目录)
      addVideo(tostring(f), true)
      --call("addVideo", tostring(f), true)

    end

  end
end

]]
function QueryAllVideo()
  videos={}
  import "android.provider.MediaStore"
  cursor = activity.ContentResolver
  mImageUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
  mCursor = cursor.query(mImageUri,nil,nil,nil,MediaStore.Video.Media.DATE_TAKEN)
  mCursor.moveToLast()
  --VideoTable={}
  while mCursor.moveToPrevious() do
    path = mCursor.getString(mCursor.getColumnIndex(MediaStore.Video.Media.DATA))
    addVideo(tostring(path), true)

    --table.insert(VideoTable,tostring(path))
  end
  mCursor.close()
  addVideo(nil, false)
  -- adapter.notifyDataSetChanged()
  --return VideoTable
end
--返回一个表




function onStart()

  task(200,QueryAllVideo)

end

--threading=Threading(6,500,QueryAllVideo,datas)

--threading.run()
function onDestroy()
  --threading.interrupt()
end



