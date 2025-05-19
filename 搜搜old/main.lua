require "import"
--print(activity.loadDex(activity.getLuaDir().."/libs"))
--if pcall(function()

    import "common.BaseActivity"
    import "android.text.Html"
    import "pages.agree.agreeout"
    import "com.sousou.utils.StreamFileUtil"


    function onCreate()
      if pcall(function()
          -- setting.saveBoolean("agreePolicy",false)
          if setting.agreePolicy then
            activity.newActivity("pages/home/home").overridePendingTransition(android.R.anim.fade_in,
            android.R.anim.fade_out);
           else
            import "utils.InitData"
            setting = settingUtil.init()
            activity.setContentView(loadlayout(agreeout))
            agreeButton.onClick = function()
              setting = settingUtil.setSetting("agreePolicy", true)
              activity.finish().overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
              activity.newActivity("pages/home/home").overridePendingTransition(android.R.anim.fade_in,
              android.R.anim.fade_out);
            end
            disagreeButton.onClick = function()
              systemUtil.killApp()
            end
          end
        end) then

       else
        task(200, function()
          import "java.io.File"
          if File("/sdcard/搜搜").exists() then
            showToast("正在初始化文件，请等待！")
            File("/sdcard/Download/搜搜").mkdirs()
            os.execute("mv /sdcard/搜搜/* /sdcard/Download/搜搜/")
            os.execute("rm -rf /sdcard/搜搜")
            showToast("初始化文件完成，请再次打开APP！")
            systemUtil.killApp()
          end
        end)

      end
    end


    function onNewIntent(intent)


      uri = intent.getData();

      -- print(uri)


      if uri and uri.toString():find(".sousou")then
        -- systemUtil.copyContent(uri.toString())
        --  local path=uri.getPath();
        -- print(path)
        --resolver = activity.getContentResolver();
        inputStream = activity.getContentResolver().openInputStream(uri);
        --showToast(inputStream)

        local stringData=StreamFileUtil().readStreamToString(inputStream)
        -- showToast(stringData)
        local data=cjson.decode(stringData)

        -- local data = cjson.decode(io.open(path):read("*a"))
        if data.type=="SITE"then
          sites = siteUtil.getSites()

          local siteIndex=siteUtil.getMySiteIndex()
          for k,v in pairs(data.datas)do
            if v.name and #v.name>=2 then

              local flag = true
              for m, n in pairs(sites[siteIndex].SITE) do
                if v.name == n.name then
                  flag = false
                  break
                end
              end
              if flag then
                table.insert(sites[siteIndex].SITE,v)
                siteUtil.setSites(sites)
              end
            end
          end
          showToast("站源添加成功！")
         elseif data.type=="WEBHEART" then
          import "pages.webview.WebHeartUtil"
          local webHeartUtil = WebHeartUtil()

          for k,v in pairs(data.datas) do
            webHeartUtil.setHeart(v)
          end
          showToast("书签导入完成！")
         else
          showToast("暂不支持的格式!")
        end

       elseif uri and endswith(uri.toString(),".torrent") then
        import "com.xunlei.downloadlib.XLTaskHelper";
        import "com.xunlei.downloadlib.parameter.XLTaskInfo";
        import "utils.FileUtil"
        inputStream = activity.getContentResolver().openInputStream(uri);
        --showToast(inputStream)
        local filePath="/sdcard/搜搜/temp.torrent"
        local byteData=StreamFileUtil().readStream(inputStream,filePath)
        -- showToast(stringData)

        -- io.open(filePath, "wb"):write(byteData):close()

        local downFileUtil = FileUtil("download.json")
        local downloads = downFileUtil.getDatas()
        XLTaskHelper.init(this);

        local torrentInfo = XLTaskHelper.instance().getTorrentInfo(filePath);
        local mFileCount = torrentInfo.mFileCount
        for i = 0, mFileCount - 1 do
          local temp={

            ["标题"]= "未知",

            ["progress"]= "0/0",
            ["地址"]=filePath,


            ["site"]= {
              ["name"]="temp",
              ["type"]="temp"
            }
          }

          temp.index = i
          temp.total = mFileCount
          temp.playHref = filePath
          temp.state = "等待中"
          temp.progress = "0/0"
          temp.saveDir = false
          temp.playName = luajava.astable(torrentInfo.mSubFileInfo)[i + 1]['mSubPath'] .. "/" ..
          luajava.astable(torrentInfo.mSubFileInfo)[i + 1]['mFileName']
          table.insert(downloads, temp)
        end

        downFileUtil.saveDatas(downloads)
        showToast("添加下载成功！")
       else
        if uri then
          showToast("只支持sousou文件结尾的文件!")
        end
      end


    end


    function onStart()
      if setting.agreePolicy then
        activity.finish()
      end



    end


  --end) then

 --else
 -- import "utils.util"
 -- showToast("请手动授予读写权限！")
--end