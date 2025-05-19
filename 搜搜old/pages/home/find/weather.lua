天气网path="https://m.tianqi.com/"
中国天气网path="https://m.weather.com.cn/"
天气源=1 --1天气网，2中国天气网

--天气网的天气获取
Http.get(天气网path,nil,"utf8",nil,function(code,content,cookie,header)
  if(code==200 and content)then
    定位城市=content:match("<text>(.-)</text>")
    湿度=content:match('<span class="b2"><i></i>湿度(.-)</span')
    空气质量=content:match('<div class="info"><span class="b1"><i></i>(.-)</span')
    风力风向=content:match('<span class="b3"><i></i>(.-)</span>')
    度数=content:match('<dd class="now">(.-)<i>')
    详细=content:match('<dd class="txt">(.-)</dd>')
    天气图标=content:match('<dt><img src="(.-)"></dt>')
    if startswith(天气图标,"http")
      then
      天气icon.setImageBitmap(loadbitmap(天气图标))

     else
      天气icon.setImageBitmap(loadbitmap("https://m.tianqi.com/"..天气图标))
    end
    温度text.text=度数.."℃"
    温度数据text.text=详细
    当前城市text.text=定位城市
    湿度text.text="湿度:"..湿度
    风力风向text.text=风力风向
    天气icon.setColorFilter(0x00000000)
   else
    天气icon.setColorFilter(0xff000000)
    天气icon.setImageBitmap(loadbitmap("drawable/unknown.png"))
    温度text.text="-- ℃"
    温度数据text.text="未知温度"
    当前城市text.text=" "
    --空气质量text.text=" "
    湿度text.text="无法获取天气信息.退出刷新或检查网络"
    风力风向text.text=" "
  end
end)

--同步系统时间
function 时间()
  hb()
end
十二小时制=1
asp.setText(os.date("%H:%M"))
--if 十二小时制==0 or 十二==0 then
if tonumber(os.date("%H"))==tonumber("24") then
  asp.setText(os.date("00:%M"))
 elseif tonumber(os.date("%H"))==tonumber("23") then
  asp.setText(os.date("11:%M"))
 elseif tonumber(os.date("%H"))==tonumber("22") then
  asp.setText(os.date("10:%M"))
 elseif tonumber(os.date("%H"))==tonumber("21") then
  asp.setText(os.date("9:%M"))
 elseif tonumber(os.date("%H"))==tonumber("20") then
  asp.setText(os.date("8:%M"))
 elseif tonumber(os.date("%H"))==tonumber("19") then
  asp.setText(os.date("7:%M"))
 elseif tonumber(os.date("%H"))==tonumber("18") then
  asp.setText(os.date("6:%M"))
 elseif tonumber(os.date("%H"))==tonumber("17") then
  asp.setText(os.date("5:%M"))
 elseif tonumber(os.date("%H"))==tonumber("16") then
  asp.setText(os.date("4:%M"))
 elseif tonumber(os.date("%H"))==tonumber("15") then
  asp.setText(os.date("3:%M"))
 elseif tonumber(os.date("%H"))==tonumber("14") then
  asp.setText(os.date("2:%M"))
 elseif tonumber(os.date("%H"))==tonumber("13") then
  asp.setText(os.date("1:%M"))
end
function hb(十二)
  asp2.setText(os.date("%S"))
  -- asp.setText(os.date("%H:%M"))
  --检测时间并设置时间段
  if tonumber(os.date("%H"))>=tonumber("24") then
    asp3.setText("半夜")
   elseif tonumber(os.date("%H"))>=tonumber("19") then
    asp3.setText("晚上")
   elseif tonumber(os.date("%H"))>=tonumber("17") then
    asp3.setText("傍晚")
   elseif tonumber(os.date("%H"))>=tonumber("14") then
    asp3.setText("下午")
   elseif tonumber(os.date("%H"))>=tonumber("12") then
    asp3.setText("中午")
   elseif tonumber(os.date("%H"))>=tonumber("10") then
    asp3.setText("上午")
   elseif tonumber(os.date("%H"))>=tonumber("7") then
    asp3.setText("早上")
   elseif tonumber(os.date("%H"))<=tonumber("5") then
    asp3.setText("清晨")
  end
  if asp2.text:find"00" then
    asp.setText(os.date("%H:%M"))
    --if 十二小时制==0 or 十二==0 then
    if tonumber(os.date("%H"))==tonumber("24") then
      asp.setText(os.date("00:%M"))
     elseif tonumber(os.date("%H"))==tonumber("23") then
      asp.setText(os.date("11:%M"))
     elseif tonumber(os.date("%H"))==tonumber("22") then
      asp.setText(os.date("10:%M"))
     elseif tonumber(os.date("%H"))==tonumber("21") then
      asp.setText(os.date("9:%M"))
     elseif tonumber(os.date("%H"))==tonumber("20") then
      asp.setText(os.date("8:%M"))
     elseif tonumber(os.date("%H"))==tonumber("19") then
      asp.setText(os.date("7:%M"))
     elseif tonumber(os.date("%H"))==tonumber("18") then
      asp.setText(os.date("6:%M"))
     elseif tonumber(os.date("%H"))==tonumber("17") then
      asp.setText(os.date("5:%M"))
     elseif tonumber(os.date("%H"))==tonumber("16") then
      asp.setText(os.date("4:%M"))
     elseif tonumber(os.date("%H"))==tonumber("15") then
      asp.setText(os.date("3:%M"))
     elseif tonumber(os.date("%H"))==tonumber("14") then
      asp.setText(os.date("2:%M"))
     elseif tonumber(os.date("%H"))==tonumber("13") then
      asp.setText(os.date("1:%M"))
    end
  end
  if tonumber(os.date("%S"))<03 then
    --print("less than 02")
    --if 十二小时制==0 or 十二==0 then
    if tonumber(os.date("%H"))==tonumber("24") then
      asp.setText(os.date("00:%M"))
     elseif tonumber(os.date("%H"))==tonumber("23") then
      asp.setText(os.date("11:%M"))
     elseif tonumber(os.date("%H"))==tonumber("22") then
      asp.setText(os.date("10:%M"))
     elseif tonumber(os.date("%H"))==tonumber("21") then
      asp.setText(os.date("9:%M"))
     elseif tonumber(os.date("%H"))==tonumber("20") then
      asp.setText(os.date("8:%M"))
     elseif tonumber(os.date("%H"))==tonumber("19") then
      asp.setText(os.date("7:%M"))
     elseif tonumber(os.date("%H"))==tonumber("18") then
      asp.setText(os.date("6:%M"))
     elseif tonumber(os.date("%H"))==tonumber("17") then
      asp.setText(os.date("5:%M"))
     elseif tonumber(os.date("%H"))==tonumber("16") then
      asp.setText(os.date("4:%M"))
     elseif tonumber(os.date("%H"))==tonumber("15") then
      asp.setText(os.date("3:%M"))
     elseif tonumber(os.date("%H"))==tonumber("14") then
      asp.setText(os.date("2:%M"))
     elseif tonumber(os.date("%H"))==tonumber("13") then
      asp.setText(os.date("1:%M"))
    end
  end
end
--
function 刷新()
  require "import"
  while true do
    Thread.sleep(100)
    call("时间")
  end
end
thread(刷新)



天气部分.onClick=function()
  setWater(天气部分,500)
end
