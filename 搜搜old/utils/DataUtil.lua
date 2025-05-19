import "utils.ReUtil"
import "utils.CmsUtil"


function DataUtil()


  function getClassDatas(data)
    if pcall(function()
        if data.site.type == "html" or not data.site.type then
          ReUtil().getClassDatas(data)
         elseif data.site.type == "cms" then
          CmsUtil().getClassDatas(data)
         elseif data.site.type == "miru" then

          function print(text)
            if type(text)=="table" then
              text=dump(text)
            end
            if test then
              test.setText(tostring(text).."\n\n\n"..test.text)
             else
              if text:find("error")
                showToast(tostring(data.site.name.."获取失败！\n")..tostring(text))
               else
                showToast(tostring(text))
              end
            end
          end

          loadstring(data.site.code)().getClassDatas(data)


        end
      end) then
     else
      showToast(data.site.name.."获取分类列表失败，请检查获取规则！")
    end
  end
  function getSearchDatas(data)
    if pcall(function()
        if data.site.type == "html" or not data.site.type then
          ReUtil().getSearchDatas(data)
         elseif data.site.type == "cms" then
          CmsUtil().getSearchDatas(data)
         elseif data.site.type == "miru" then

          local miru= loadstring(data.site.code)()


          function print(text)
            if type(text)=="table" then
              text=dump(text)
            end

            if test then
              test.setText(tostring(text).."\n\n\n"..test.text)
             else
              --[[if text:find("error")
                showToast(tostring(data.site.name.."获取失败！\n")..tostring(text))
               else
                showToast(tostring(text))
              end]]
            end
          end

          miru.getSearchDatas(data)


        end
      end) then
     else
      showToast(data.site.name.."获取搜索列表失败，请检查获取规则！")
    end
  end
  function getPlayDatas(data)
    if pcall(function()
        if data.site.type == "html" or not data.site.type then
          ReUtil().getPlayDatas(data)
         elseif data.site.type == "cms" then
          CmsUtil().getPlayDatas(data)
         elseif data.site.type == "miru" then

          function print(text)

            if type(text)=="table" then
              text=dump(text)
            end

            if test then
              test.setText(tostring(text).."\n\n\n"..test.text)
             else
              if text:find("error")
                showToast(tostring(data.site.name.."获取失败！\n")..tostring(text))
               else
                showToast(tostring(text))
              end
            end
          end
          loadstring(data.site.code)().getPlayDatas(data)


         elseif data.site.type=="temp" then
          return data.callback({
            flag = true,
            play_state = "未知",--剧集状态
            datas = {["线路1"]={{["地址"]=data.url,["标题"]=tostring(os.time())}}}
          })
        end
      end) then
     else
      showToast(data.site.name.."获取播放列表失败，请检查获取规则！")
    end
  end
  function getTrueUrl(data)
    if pcall(function()
        if data.site.type == "html" or not data.site.type then
          ReUtil().getTrueUrl(data)
         elseif data.site.type == "cms" then
          CmsUtil().getTrueUrl(data)


         elseif data.site.type == "miru" then


          function print(text)

            if type(text)=="table" then
              text=dump(text)
            end

            if test then
              test.setText(tostring(text).."\n\n\n"..test.text)
             else
              if text:find("error")
                showToast(tostring(data.site.name.."获取失败！\n")..tostring(text))
               else
                showToast(tostring(text))
              end
            end
          end

          miru=loadstring(data.site.code)()
          if not miru.getTrueUrl then
            --showToast(2222)
            ReUtil().getTrueUrl(data)
           else
            miru.getTrueUrl(data)
          end
         elseif data.site.type=="temp" then
          ReUtil().getTrueUrl(data)
        end
      end) then
     else
      showToast(data.site.name.."获取真实地址失败，请检查获取规则！")
    end
  end
  function getTagDatas(data)
    if pcall(function()
        if data.site.type == "html" or not data.site.type then
          ReUtil().getTagDatas(data)
         elseif data.site.type == "cms" then
          CmsUtil().getTagDatas(data)
         elseif data.site.type == "miru" then

          function print(text)

            if type(text)=="table" then
              text=dump(text)
            end

            if test then
              test.setText(tostring(text).."\n\n\n"..test.text)
             else
              if text:find("error")
                showToast(tostring(data.site.name.."获取失败！\n")..tostring(text))
               else
                showToast(tostring(text))
              end
            end
          end

          --dofile("/sdcard/搜搜/test.lua").getTagDatas(data)
          loadstring(data.site.code)().getTagDatas(data)



        end
      end) then
     else
      showToast(data.site.name.."获取标签失败，请检查获取规则！")
    end
  end

  function init(data)
    if data.site.type == "miru" then

      -- showToast(111111)
      function print(text)
        if type(text)=="table" then
          text=dump(text)
        end


        if test then
          test.setText(tostring(text).."\n\n\n"..test.text)
         else
          if text:find("error")
            showToast(tostring(data.site.name.."获取失败！\n")..tostring(text))
           else
            showToast(tostring(text))
          end
        end
      end

      miru=loadstring(data.site.code)()
      if not miru.init or length(miru.init)==0then
        --showToast(2222)
        return{}
       else
        return miru.init
      end

     else
      return {}
    end



  end

  return {
    getClassDatas = getClassDatas,
    getSearchDatas = getSearchDatas,
    getPlayDatas = getPlayDatas,
    getTrueUrl = getTrueUrl,
    getTagDatas=getTagDatas,
    init=init,

  }
end
