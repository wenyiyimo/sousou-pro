require("import");
import("common.BaseActivity");
import("pages.site.edit.layout");

siteIndex, itemIndex, itemType = ...
sites = siteUtil.getSites()

class_datas = {}
search_datas = {}
play_datas = {}

activity.setContentView(layout);

function setBodyItem(name1, hint, value)
  bodyout.addView(setItemout(name1, hint, value))

  getIdByString(name1).setOnFocusChangeListener(OnFocusChangeListener {
    onFocusChange = function(v, hasFocus)
      if hasFocus then
        getIdByString(name1 .. "out").setVisibility(View.VISIBLE)
        getIdByString(name1).setHint("")
       else
        if #getIdByString(name1).text > 0 then
          getIdByString(name1 .. "out").setVisibility(View.VISIBLE)
          getIdByString(name1).setHint("")
         else
          getIdByString(name1 .. "out").setVisibility(View.GONE)
          getIdByString(name1).setHint(getIdByString(name1 .. "out").text)
        end
      end
    end
  })

  getIdByString(name1).addTextChangedListener {
    onTextChanged = function(a)
      sites[siteIndex]["SITE"][itemIndex][name1] = getIdByString(name1).text
      if #sites[siteIndex]["SITE"][itemIndex].name >= 2 then
        local flag = true
        for k, v in pairs(sites[siteIndex].SITE) do
          if v.name == sites[siteIndex]["SITE"][itemIndex].name and k ~= itemIndex then
            flag = false
            break
          end
        end
        if flag then

          siteUtil.setSites(sites)
         else
          showToast("站源名称已存在!")
        end
       else
        showToast("站源名称至少2个字符!")
      end
    end
  }
end

if not itemType or itemType == "html" then
  import "pages.site.edit.html"
 elseif itemType == "cms" then
  import "pages.site.edit.cms"
 elseif itemType=="miru" then
  import "pages.site.edit.miru"
end




-- 弹窗开始
function popDialog()

  dialog = Dialog(activity)

  -- 设置弹窗布局
  dialog.setContentView(dialogout)
  -- 设置弹窗位置
  dialog.getWindow().setGravity(Gravity.BOTTOM)
  dialog.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
  -- 设置触摸弹窗外部隐藏弹窗

  dialog.setCanceledOnTouchOutside(true);
  local p = dialog.getWindow().getAttributes()
  p.dimAmount = 0
  p.width = activity.width

  p.height = activity.Height * 0.8;
  dialog.getWindow().setAttributes(p);
  -- dialog.getWindow().getDecorView().setPadding(0,0,0,0)

  dialog.show()
  --
end



function loadingState()
  if dialog and test.text == '' then
    loading.setVisibility(0)
    task(200,loadingState)
   elseif dialog then
    loading.setVisibility(8)
  end

end



function showDialog()
  if dialog then
    dialog.show()
    loading.setVisibility(0)
    test.text = ''

   else
    popDialog()
  end
  loadingState()
end


function convertTable(tab)
  local temp="[\n"

  for k,v in pairs(tab) do
    if type(k)==number then
      if type(v)=="string" then

        temp=temp..v..",\n"
       else
        temp=temp..cjson.encode(v)..",\n"
      end
     else
      return cjson.encode(tab)
    end
  end
  return temp.."]"
end


-- 弹窗结束
local space = "\n\n*******************************************************\n\n"
popaddsite.onClick = function()
  if itemType=="miru" then

    sites[siteIndex]["SITE"][itemIndex]["code"] = luaEditor.text
    if #sites[siteIndex]["SITE"][itemIndex].name >= 2 then
      local flag = true
      for k, v in pairs(sites[siteIndex].SITE) do
        if v.name == sites[siteIndex]["SITE"][itemIndex].name and k ~= itemIndex then
          flag = false
          break
        end
      end
      if flag then

        siteUtil.setSites(sites)
       else
        showToast("站源名称已存在!")
      end
     else
      showToast("站源名称至少2个字符!")
    end
  end


  pop = PopupWindow(activity)
  pop.setContentView(loadlayout(popMenuout))
  -- pop.setWidth(width / 3)
  pop.setWidth(-2)
  pop.setHeight(-2)
  pop.setOutsideTouchable(true)
  pop.setBackgroundDrawable(ColorDrawable(0))
  function pop.onDismiss()

  end
  classTest.onClick = function()
    showDialog()
    dataUtil.getTagDatas({
      site = sites[siteIndex].SITE[itemIndex],
      callback = function(resp)
        if resp.flag then

          if sites[siteIndex].SITE[itemIndex].type=="miru" then
            dataUtil.getClassDatas({
              page = 1,
              site = sites[siteIndex].SITE[itemIndex],
              tag = 1,
              tagNames = resp.datas[1],
              tagOrders = resp.datas[2],
              callback = function(res)
                loading.setVisibility(8)
                if res.flag then

                  test.setText("分类页数据获取成功！" .. space .. convertTable(res.datas) ..
                  space .. test.text)
                  class_datas = res.datas
                 else

                end
              end

            })

           else


            dataUtil.getClassDatas({
              page = 1,
              site = sites[siteIndex].SITE[itemIndex],
              tag = 1,
              tagNames = resp.datas[1],
              tagOrders = resp.datas[2],
              callback = function(res)
                loading.setVisibility(8)
                if res.flag then
                  test.setText("分类页源码获取成功！" .. space .. res.html)
                  test.setText("分类页范围获取成功！" .. space .. res.range .. space ..
                  test.text)
                  test.setText("分类页数据获取成功！" .. space .. convertTable(res.datas) ..
                  space .. test.text)
                  class_datas = res.datas
                 else
                  test.setText("分类页源码获取成功！" .. space .. res.html)
                  if res.range then
                    test.setText("分类页范围获取成功！" .. space .. res.range .. space ..
                    test.text)
                    test.setText(res.msg .. space .. test.text)
                   else
                    test.setText(res.msg .. space .. test.text)
                  end
                end
              end

            })
          end
         else
          test.setText(resp.msg .. space .. test.text)
        end
      end


    })

  end
  searchTest.onClick = function()
    showDialog()
    dataUtil.getSearchDatas({
      searchKey = "爱情",
      site = sites[siteIndex].SITE[itemIndex],
      callback = function(res)


        if sites[siteIndex].SITE[itemIndex].type=="miru" then
          loading.setVisibility(8)
          if res.flag then
            test.setText("搜索页数据获取成功！" .. space .. convertTable(res.datas) .. space ..
            test.text)
            search_datas = res.datas


          end
         else

          -- print(dump(datas))
          loading.setVisibility(8)
          if res.flag then
            test.setText("搜索页源码获取成功！" .. space .. res.html)
            test.setText("搜索页范围获取成功！" .. space .. res.range .. space .. test.text)
            test.setText("搜索页数据获取成功！" .. space .. convertTable(res.datas) .. space ..
            test.text)
            search_datas = res.datas
           else
            test.setText("搜索页源码获取成功！" .. space .. res.html)
            if res.range then
              test.setText("搜索页范围获取成功！" .. space .. res.range .. space .. test.text)
              test.setText(res.msg .. space .. test.text)
             else
              test.setText(res.msg .. space .. test.text)
            end

          end
        end
      end
    })
  end
  playTest.onClick = function()
    showDialog()
    if #search_datas == 0 and #class_datas == 0 then
      loading.setVisibility(8)
      test.setText("请先获取分类页或搜索页数据！" .. space)
     else
      local p_url
      if #search_datas > 0 then
        p_url = search_datas[1]["地址"]
       else
        p_url = class_datas[1]["地址"]
      end
      dataUtil.getPlayDatas({
        site = sites[siteIndex].SITE[itemIndex],
        url = p_url,
        callback = function(res)
          loading.setVisibility(8)

          if sites[siteIndex].SITE[itemIndex].type=="miru" then



            if res.play_state then
              test.setText("播放页剧集状态获取成功！" .. space .. res.play_state .. space ..
              test.text)
             else
              test.setText("播放页剧集状态获取失败！" .. space .. test.text)
            end

            test.setText("播放页数据获取成功！" .. space .. convertTable(res.datas) .. space ..
            test.text)


            for k, v in pairs(res.datas) do
              if startswith(string.lower(v[1]["地址"]),"thunder") or startswith(string.lower(v[1]["地址"]),"ftp") or startswith(string.lower(v[1]["地址"]),"magnet") or startswith(string.lower(v[1]["地址"]),"ed2k") then
                test.setText("迅雷地址不支持测试获取真实地址！" .. space ..test.text)

                return
               else
                test.setText("获取播放地址。。。" .. space .. test.text)

                dataUtil.getTrueUrl({
                  site = sites[siteIndex].SITE[itemIndex],
                  url = v[1]["地址"],
                  callback = function(res)
                    if res.flag then
                      test.setText("播放页真实地址获取成功！" .. space ..
                      cjson.encode(res.url) .. space .. test.text)
                     else
                      if res.html then
                        test.setText("播放页真实地址获取失败！" .. space .. res.html ..
                        space .. test.text)
                      end

                    end
                  end

                })
              end

              return
            end





           else
            if res.flag then
              test.setText("播放页源码获取成功！" .. space .. res.html)
              if res.play_state then
                test.setText("播放页剧集状态获取成功！" .. space .. res.play_state .. space ..
                test.text)
               else
                test.setText("播放页剧集状态获取失败！" .. space .. test.text)
              end

              if res.play_tag_range then
                test.setText("播放页线路名称范围获取成功！" .. space .. res.play_tag_range ..
                space .. test.text)
               else
                test.setText("播放页线路名称范围获取失败！" .. space .. res.play_tag_range ..
                space .. test.text)
              end
              if length(res.play_tag_name) > 0 then
                test.setText("播放页线路名称数据获取成功！" .. space ..
                convertTable(res.play_tag_name) .. space .. test.text)
               else
                test.setText("播放页线路名称数据获取失败！" .. space .. test.text)
              end

              test.setText("播放页范围获取成功！" .. space .. res.play_range .. space .. test.text)
              test.setText("播放页线路列表获取成功！" .. space .. convertTable(res.play_list) ..
              space .. test.text)
              test.setText("播放页线路列表条目获取成功！" .. space ..
              convertTable(res.play_item) .. space .. test.text)
              test.setText("播放页数据获取成功！" .. space .. convertTable(res.datas) .. space ..
              test.text)


              for k, v in pairs(res.datas) do
                if startswith(string.lower(v[1]["地址"]),"thunder") or startswith(string.lower(v[1]["地址"]),"ftp") or startswith(string.lower(v[1]["地址"]),"magnet") or startswith(string.lower(v[1]["地址"]),"ed2k") then
                  test.setText("迅雷地址不支持测试获取真实地址！" .. space ..test.text)

                  return
                 else
                  test.setText("获取播放地址。。。" .. space .. test.text)

                  dataUtil.getTrueUrl({
                    site = sites[siteIndex].SITE[itemIndex],
                    url = v[1]["地址"],
                    callback = function(res)
                      if res.flag then
                        test.setText("播放页真实地址获取成功！" .. space ..
                        cjson.encode(res.url) .. space .. test.text)
                       else
                        if res.html then
                          test.setText("播放页真实地址获取失败！" .. space .. res.html ..
                          space .. test.text)
                        end

                      end
                    end

                  })
                end

                return
              end

             else
              if res.code == 200 then
                test.setText("播放页源码获取成功！" .. space .. res.html)
                if res.play_state then
                  test.setText(
                  "播放页剧集状态获取成功！" .. space .. res.play_state .. space ..
                  test.text)
                 else
                  test.setText("播放页剧集状态获取失败！" .. space .. test.text)
                end

                if res.play_tag_range then
                  test.setText(
                  "播放页线路名称范围获取成功！" .. space .. res.play_tag_range .. space ..
                  test.text)
                 else
                  test.setText(
                  "播放页线路名称范围获取失败！" .. space .. res.play_tag_range .. space ..
                  test.text)
                end
                if length(res.play_tag_name) > 0 then
                  test.setText("播放页线路名称数据获取成功！" .. space ..
                  convertTable(res.play_tag_name) .. space .. test.text)
                 else
                  test.setText("播放页线路名称数据获取失败！" .. space .. test.text)
                end
                if res.play_range then
                  test.setText("播放页范围获取成功！" .. space .. res.play_range .. space ..
                  test.text)
                 else
                  test.setText("播放页范围获取失败！" .. space .. test.text)
                end

                if length(res.play_list) > 0 then
                  test.setText("播放页线路列表获取成功！" .. space ..
                  convertTable(res.play_list) .. space .. test.text)
                 else
                  test.setText("播放页线路列表获取失败！" .. space .. test.text)
                end
                if length(res.play_item) > 0 then
                  test.setText("播放页线路列表条目获取成功！" .. space ..
                  convertTable(res.play_item) .. space .. test.text)
                 else
                  test.setText("播放页线路列表条目获取失败！" .. space .. test.text)
                end
                test.setText(res.msg .. space .. convertTable(res.play_item) .. space .. test.text)

               else
                test.setText(res.msg .. space .. res.html)
              end
            end
          end
        end
      })

    end

  end
  setWave(classTest, ColorStyles().gray)
  setWave(searchTest, ColorStyles().gray)
  setWave(playTest, ColorStyles().gray)
  pop.showAsDropDown(popaddsite)

  navWeb.onClick=function()
    activity.newActivity("pages/webview/webview")
  end


end
