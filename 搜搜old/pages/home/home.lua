require "import"
import "common.BaseActivity"

import "utils.InitData"
import "utils.HomeSite"
import "utils.SouGouUtil"
import "pages.home.layout"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

--if pcall(function()

function getLunboHeight()
  if isMobile then
    return "40%w"
   else
    return "40%h"
  end

end

import "pages.home.homeout"
activity.setContentView(loadlayout(homeout))
import "pages.home.home.homepageout"
--import "pages.home.top.topout"
import "pages.home.find.findpageout"
import "pages.home.more.morepageout"

import "pages.home.setting.setpageout"
local vpg = ArrayList()
vpg.add(loadlayout(homepageout))

vpg.add(loadlayout(setpageout))
pagev.setAdapter(BasePagerAdapter(vpg))

homeButton.onClick = function()
  pagev.setCurrentItem(0)
end




setButton.onClick = function()
  pagev.setCurrentItem(1)
end

pagev.setOnPageChangeListener(ViewPager.OnPageChangeListener {
  onPageSelected = function(a)

    if a == 0 then -- 日常
      a1.setTextColor(ColorStyles().blue) -- 选中字体颜色
      -- a2.setTextColor(ColorStyles().gray) -- 未选中字体颜色
      -- a3.setTextColor(ColorStyles().gray) -- 未选中字体颜色
      -- a4.setTextColor(ColorStyles().gray) -- 未选中字体颜色
      a5.setTextColor(ColorStyles().gray) -- 未选中字体颜色
      img1.setColorFilter(ColorStyles().blue)
      --  img2.setColorFilter(ColorStyles().gray)
      --   img3.setColorFilter(ColorStyles().gray)
      -- img4.setColorFilter(ColorStyles().gray)
      img5.setColorFilter(ColorStyles().gray)
      img1.setImageBitmap(loadbitmap("static/img/home/d1.png")) -- 选中图片
      -- img2.setImageBitmap(loadbitmap("static/img/home/d6.png")) -- 未选中图片
      -- img3.setImageBitmap(loadbitmap("static/img/home/d9.png"))
      -- img4.setImageBitmap(loadbitmap("static/img/home/d7.png")) -- 未选中图片
      img5.setImageBitmap(loadbitmap("static/img/home/d8.png")) -- 未选中图片
     elseif a == 1 then -- 功能
      a1.setTextColor(ColorStyles().gray) -- 选中字体颜色
      --  a2.setTextColor(ColorStyles().gray) -- 未选中字体颜色
      --a3.setTextColor(ColorStyles().gray) -- 未选中字体颜色
      -- a4.setTextColor(ColorStyles().blue) -- 未选中字体颜色
      a5.setTextColor(ColorStyles().gray) -- 未选中字体颜色
      img1.setColorFilter(ColorStyles().gray)
      -- img2.setColorFilter(ColorStyles().gray)
      --img3.setColorFilter(ColorStyles().gray)
      --img4.setColorFilter(ColorStyles().blue)
      img5.setColorFilter(ColorStyles().blue)
      img1.setImageBitmap(loadbitmap("static/img/home/d5.png")) -- 选中图片
      --  img2.setImageBitmap(loadbitmap("static/img/home/d6.png")) -- 未选中图片
      -- img3.setImageBitmap(loadbitmap("static/img/home/d9.png"))
      -- img4.setImageBitmap(loadbitmap("static/img/home/d3.png")) -- 未选中图片
      img5.setImageBitmap(loadbitmap("static/img/home/d4.png")) -- 未选中图片

  
    end -- 选中字体颜色与未选中字体颜色建议一致比较统一
  end

})

setWave(homeButton, 0x28000000) -- 分别为：id，颜色
--setWave(topButton, 0x28000000) -- 分别为：id，颜色
--setWave(moreButton, 0x28000000) -- 分别为：id，颜色
--setWave(findButton, 0x28000000) -- 分别为：id，颜色
setWave(setButton, 0x28000000) -- 分别为：id，颜色
img1.setColorFilter(ColorStyles().blue)
a1.setTextColor(ColorStyles().blue) -- 选中字体颜色

import "pages.home.home.home"
--import "pages.home.top.top"
--import "pages.home.find.find"
--import "pages.home.more.more"
import "pages.home.setting.setting"
function dealPlayTime(time)
  if time < 0 then
    return "00:00"
  end

  local miao = tostring(tointeger(time * 0.001 % 60))
  local fen = tostring(tointeger(time * 0.001 / 60))
  if #miao == 1 then
    miao = "0" .. miao
  end
  if #fen == 1 then
    fen = "0" .. fen
  end
  return fen .. ":" .. miao
end
function onResume()
  import "utils.HeartUtil"
  heartUtil = HeartUtil()
  hearts = heartUtil.getHearts()

  heart_num.setText("共" .. #hearts .. "部")
  if #hearts > 0 then
    glideImg(heart1, hearts[1][2]["图片"])
    if #hearts > 1 then
      glideImg(heart2, hearts[2][2]["图片"])
    end
  end
  import "utils.HistoryUtil"
  historyUtil = HistoryUtil()
  historys = historyUtil.getHistorys()
  his_num.setText("共" .. #historys .. "部")
  if #historys > 0 then
    import "android.text.Html"

    if historys[1][3]["播放"] and tostring(historys[1][3]["播放"])~="nil" then
     else
      historys[1][3]["播放"] ="未知"
    end


    home_history_out.setText(
    Html.fromHtml("继续播放：" .. historys[1][3]["标题"] .. ' ' .. historys[1][3]["播放"] .. ' ' ..
    dealPlayTime(historys[1][3]['进度'])))
    glideImg(his1, historys[1][2]["图片"])
    if #historys > 1 then
      glideImg(his2, historys[2][2]["图片"])
    end
  end

  import "utils.DownloadUtil"
  downloadUtil = DownloadUtil()
  downloads = downloadUtil.getDownloads()
  down_num.setText("共" .. #downloads .. "部")
  if #downloads > 0 then
    import "android.text.Html"

    glideImg(down1, downloads[1]["图片"])
    if #downloads > 1 then
      glideImg(down2, downloads[2]["图片"])
    end
  end

  sites = siteUtil.getActiveClassSites()
  if site_adapter and class_adapter and body_adapter then
    site_adapter.notifyDataSetChanged()
    class_adapter.notifyDataSetChanged()
    body_adapter.notifyDataSetChanged()
  end
end



--检测剪切板开始
function sitetip(str,copydata)
  local tipout={

    LinearLayout;
    background="#ffffffff";
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    gravity='center',
    {
      TextView,--文本框控件
      textSize="16dp",
      text=str,--文本内容
      layout_width='fill',
      layout_height='wrap',
      layout_margin='15dp',--布局边距
      textColor="#227CEA";
      --Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
    },
    {
      LinearLayout,--线性布局
      layout_width='fill',
      layout_height='wrap',
      orientation='horizontal',
      gravity='right',
      -- layout_margin='15dp',--布局边距
      {
        TextView,--文本框控件;
        text='取消',--文本内容
        textSize="16dp",
        layout_margin='15dp',--布局边距
        textColor="#227CEA";
        onClick=function ()
          dialogsite.dismiss()
        end
      },
      {
        TextView,--文本框控件
        text='确定',--文本内容
        textSize="16dp",
        textColor="#227CEA";
        layout_margin='15dp',--布局边距
        onClick=function ()
          local sites = siteUtil.getSites()
          if str:find("订阅") then

            if copydata.URL~="自定义数据" then
              local copyurl=trim(copydata.URL)
              local siteflag = siteUtil.checkSiteUrlExist(copyurl)

              if siteflag then
                Http.get(copyurl, nil, "utf8", nil, function(a, b)
                  if a == 200 then
                    local jsondata = cjson.decode(b)

                    if judgeKeyInTable(jsondata, "NAME") and judgeKeyInTable(jsondata, "URL") and
                      judgeKeyInTable(jsondata, "SITE") then
                      if not judgeKeyInTable(jsondata, "CONTACT") then
                        jsondata.CONTACT = "无"
                      end
                      if not judgeKeyInTable(jsondata, "AUTHOR") then
                        jsondata.AUTHOR = "无"
                      end
                      jsondata.isActive = true
                      table.insert(sites, jsondata)
                      siteUtil.setSites(sites)
                      showToast("添加成功！")
                     else
                      showToast("数据格式错误！")
                    end
                   else
                    showToast("该链接返回结果错误！")
                  end
                end)

               else
                showToast("请检查导入的链接，是否已经存在或者链接不是以http开头。")
              end
             elseif copydata.URL=="自定义数据" and copydata.SITE then
              local siteIndex=siteUtil.getMySiteIndex()
              for k,v in pairs(copydata.SITE)do
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
            end
           elseif str:find("站源") then
            local siteIndex=siteUtil.getMySiteIndex()
            local flag = true
            for m, n in pairs(sites[siteIndex].SITE) do
              if copydata.name == n.name then
                flag = false
                break
              end
            end
            if flag then
              table.insert(sites[siteIndex].SITE,copydata)
              siteUtil.setSites(sites)
              showToast("站源添加成功！")
             else
              showToast("站源名称已存在！")
            end
          end
          dialogsite.dismiss()
        end
      }
    }

  }
  dialogsite=Dialog(activity)

  --设置弹窗布局
  dialogsite.setContentView(loadlayout(tipout))
  --设置弹窗位置

  dialogsite.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
  --设置触摸弹窗外部隐藏弹窗

  dialogsite.setCanceledOnTouchOutside(true);
  local p=dialogsite.getWindow().getAttributes()
  p.dimAmount=0
  p.width=activity.width*0.8

  --p.height=activity.Height*0.74;
  dialogsite.getWindow().setAttributes(p);
  --dialog.getWindow().getDecorView().setPadding(0,0,0,0)

  dialogsite.show()
end


function siteplaytip(str,copydata)

  local tipout={

    LinearLayout;
    background="#ffffffff";
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    gravity='center',
    {
      TextView,--文本框控件
      textSize="16dp",
      text=str,--文本内容
      layout_width='fill',
      layout_height='wrap',
      layout_margin='15dp',--布局边距
      textColor="#227CEA";
      --Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
    },
    {
      LinearLayout,--线性布局
      layout_width='fill',
      layout_height='wrap',
      orientation='horizontal',
      gravity='right',
      -- layout_margin='15dp',--布局边距
      {
        TextView,--文本框控件;
        text='取消',--文本内容
        textSize="16dp",
        layout_margin='15dp',--布局边距
        textColor="#227CEA";
        onClick=function ()
          dialogsiteplay.dismiss()
        end
      },
      {
        TextView,--文本框控件
        text='确定',--文本内容
        textSize="16dp",
        textColor="#227CEA";
        layout_margin='15dp',--布局边距
        onClick=function ()
          local site={}
          site.name="temp"
          site.type="temp"



          activity.newActivity("pages/play/play", {{site, {["标题"]="未知",["地址"]=copydata}}})

          dialogsiteplay.dismiss()
        end
      }
    }

  }
  dialogsiteplay=Dialog(activity)

  --设置弹窗布局
  dialogsiteplay.setContentView(loadlayout(tipout))
  --设置弹窗位置

  dialogsiteplay.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
  --设置触摸弹窗外部隐藏弹窗

  dialogsiteplay.setCanceledOnTouchOutside(true);
  local p=dialogsiteplay.getWindow().getAttributes()
  p.dimAmount=0
  p.width=activity.width*0.8

  --p.height=activity.Height*0.74;
  dialogsiteplay.getWindow().setAttributes(p);
  --dialog.getWindow().getDecorView().setPadding(0,0,0,0)

  dialogsiteplay.show()
end


--检测剪切板结束




function onStart()

  task(1000,function()
    pcall(function()
      local copydata=trim(systemUtil.getCopyContent())
      if copydata and #copydata>10 and startswith(copydata,"{") and endswith(copydata,"}")
        copydata=cjson.decode(copydata)
        if copydata.URL and copydata.NAME then
          systemUtil.copyContent("",false)
          sitetip("已识别到订阅，是否导入？",copydata)

         elseif copydata.name then
          systemUtil.copyContent("",false)
          sitetip("已识别到站源，是否导入？",copydata)

        end
       elseif copydata and #copydata>10 and (startswith(copydata,"http") or startswith(copydata,"magnet") or startswith(copydata,"ftp") or startswith(copydata,"ed2k") or startswith(copydata,"thunder")) then

        systemUtil.copyContent("",false)

        siteplaytip("已识别到链接："..string.sub(copydata,1,200).."，是否播放？",copydata)
      end
    end)
  end)

end

--[[end) then



 else
  task(200,function()
    import "java.io.File"
    if File("/sdcard/搜搜").exists() then
      showToast("正在初始化文件，请等待！")
      File("/sdcard/Download/搜搜").mkdirs()
      os.execute("mv /sdcard/搜搜/* /sdcard/Download/搜搜/")
      os.execute("rm -rf /sdcard/搜搜")

      showToast("正在初始化文件，请再次打开APP！")
      --systemUtil.killApp()
    end
  end)


end

]]