require "import"
autoFullScreenout.ThumbDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP));
autoFullScreenout.TrackDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP))
autoFullScreenout.setChecked(settingUtil.getSettingKey("autoFullScreen"))

autoFullScreenout.setOnCheckedChangeListener{
  onCheckedChanged=function(view,check)
    setting=settingUtil.setSetting("autoFullScreen", check)
end}



--[[isijkout.ThumbDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP));
isijkout.TrackDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP))
isijkout.setChecked(settingUtil.getSettingKey("isijk"))

isijkout.setOnCheckedChangeListener{
  onCheckedChanged=function(view,check)
    setting=settingUtil.setSetting("isijk", check)
end}
]]

showPlayRateout.ThumbDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP));
showPlayRateout.TrackDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP))
showPlayRateout.setChecked(settingUtil.getSettingKey("showPlayRate"))

showPlayRateout.setOnCheckedChangeListener{
  onCheckedChanged=function(view,check)

    setting=settingUtil.setSetting("showPlayRate", check)
end}
searchMode.ThumbDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP));
searchMode.TrackDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP))
searchMode.setChecked(settingUtil.getSettingKey("searchMode"))
--setting.saveBoolean("searchMode", searchMode.checked)

searchMode.setOnCheckedChangeListener{
  onCheckedChanged=function(view,check)

    setting=settingUtil.setSetting("searchMode", check)
end}


showPlayProgress.ThumbDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP));
showPlayProgress.TrackDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP))
showPlayProgress.setChecked(settingUtil.getSettingKey("showPlayProgress"))
--setting.saveBoolean("showPlayProgress", showPlayProgress.checked)

showPlayProgress.setOnCheckedChangeListener{
  onCheckedChanged=function(view,check)

    setting=settingUtil.setSetting("showPlayProgress", check)
end}


loadImg.ThumbDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP));
loadImg.TrackDrawable.setColorFilter(PorterDuffColorFilter(ColorStyles().blue, PorterDuff.Mode.SRC_ATOP))
loadImg.setChecked(settingUtil.getSettingKey("loadImg"))
--setting.saveBoolean("loadImg", loadImg.checked)

loadImg.setOnCheckedChangeListener{
  onCheckedChanged=function(view,check)

    setting=settingUtil.setSetting("loadImg", check)
end}

queryout.onClick=function()
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText("文一一墨")
  --写入剪贴板
  showToast("已复制公众号名称，请去公众号反馈！")
end

heartAuthorout.onClick=function()
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText("文一一墨")
  --写入剪贴板
  showToast("已复制公众号名称，请去微信添加！")
end

local appCode=tostring(this.getPackageManager().getPackageInfo(this.getPackageName(),((782268899/2/2-8183)/10000-6-231)/9).versionName)



checkUpdateout.onClick=function()

  import "android.view.Gravity"
  --利用包名获取到当前版本号
  版本号=tostring(this.getPackageManager().getPackageInfo(this.getPackageName(),((782268899/2/2-8183)/10000-6-231)/9).versionName)

  Http.get("https://raw.githubusercontent.com/wenyiyimo/sousou/main/update.json",nil,"utf8",nil,function(a,b)
    if a==200 then
      local jsondata=cjson.decode(b)
      if jsondata.version~=版本号 then
        --  showToast("APP有更新！")
        dialog=AlertDialog.Builder(this)
        .setTitle("APP有更新！")
        .setMessage(jsondata.msg)
        .setPositiveButton("更新",{onClick=function(v)
            import "utils.UpdateApp"
            UpdateApp()
        end})
        --  .setNeutralButton("取消",nil)
        .setNegativeButton("忽略",nil)
        .show()
        --更改Button颜色
        import "android.graphics.Color"
        dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff227CEA)
        dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff227CEA)
        dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff227CEA)

        --更改Title颜色
        import "android.text.SpannableString"
        import "android.text.style.ForegroundColorSpan"
        import "android.text.Spannable"
        local sp = SpannableString("APP有更新！")
        sp.setSpan(ForegroundColorSpan(0xff227CEA),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
        dialog.setTitle(sp)
       else
        dialog=AlertDialog.Builder(this)
        .setTitle("无更新，以下为版本信息")
        .setMessage(jsondata.msg)
        .show()
        --更改Button颜色
        import "android.graphics.Color"
        dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff227CEA)
        dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff227CEA)
        dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff227CEA)

        --更改Title颜色
        import "android.text.SpannableString"
        import "android.text.style.ForegroundColorSpan"
        import "android.text.Spannable"
        local sp = SpannableString("无更新，以下为版本信息：")
        sp.setSpan(ForegroundColorSpan(0xff227CEA),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
        dialog.setTitle(sp)
      end
    end
  end)
end



navRemote.onClick=function()
  activity.newActivity("pages/site/remote/remote")
end
navRemoteout.onClick=function()
  activity.newActivity("pages/site/remote/remote")
end

navMySiteout.onClick=function()
  local index=siteUtil.getMySiteIndex()
  activity.newActivity("pages/site/list/list",{index,true}).overridePendingTransition(android.R.anim.fade_in,
  android.R.anim.fade_out);
end
navMySite.onClick=function()
  local index=siteUtil.getMySiteIndex()
  activity.newActivity("pages/site/list/list",{index,true}).overridePendingTransition(android.R.anim.fade_in,
  android.R.anim.fade_out);
end


heart_card.onClick=function()
  activity.newActivity("pages/heart/heart").overridePendingTransition(android.R.anim.fade_in,
  android.R.anim.fade_out);
end

his_card.onClick=function()
  activity.newActivity("pages/history/history").overridePendingTransition(android.R.anim.fade_in,
  android.R.anim.fade_out);
end


down_card.onClick=function()
  activity.newActivity("pages/download/download").overridePendingTransition(android.R.anim.fade_in,
  android.R.anim.fade_out);
end


clearplayout.onClick=function()
  import"com.sousou.utils.CacheUtils"

  CacheUtils().clearCache(this)

  if File("/sdcard/Download/搜搜/download").exists() then
    os.execute("rm -rf /sdcard/Download/搜搜/download")
    File("/sdcard/Download/搜搜/download").mkdirs()
   else
    File("/sdcard/Download/搜搜/download").mkdirs()
  end
  showToast("清理完成！")
end