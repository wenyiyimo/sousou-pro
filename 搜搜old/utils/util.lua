import "com.sousou.utils.JavaUtils"


import "org.jsoup.Jsoup"

import "android.webkit.CookieSyncManager"
import "android.webkit.CookieManager"

function setCookie(context,url,content)--设置cookie
  CookieSyncManager.createInstance(context)
  local cookieManager = CookieManager.getInstance()
  cookieManager.setAcceptCookie(true)
  cookieManager.setCookie(url, content)
  CookieSyncManager.getInstance().sync()
end

function getCookie(url)--获取cookie
  local cookieManager = CookieManager.getInstance();
  return cookieManager.getCookie(url);
end

function delCookie()--删除全部cookie
  local cookieManager = CookieManager.getInstance()
  cookieManager.removeSessionCookie()
  cookieManager.removeAllCookie()
end



function px2dp(pxValue)
  local scale = this.getResources().getDisplayMetrics().density
  return (pxValue / scale + 0.5)
end



-- 获取文件夹大小
function getFolderSize(folderPath, conversion)
  import "java.io.File"
  import "android.text.format.Formatter"

  import "java.io.*"
  local size = 0
  local fileList = luajava.astable(File(folderPath).listFiles())

  if (fileList == nil) then
    return 0
  end

  -- 开始遍历循环获取文件夹底下所有文件的字节大小
  if (fileList ~= nil) then
    for count = 1, #fileList do
      if (File(tostring(fileList[count])).isDirectory()) then
        size = size + getFolderSize(tostring(fileList[count]))
       else
        local singleFileSize = File(tostring(fileList[count])).length()
        size = size + singleFileSize
      end
    end
  end

  -- 字节换算
  if (conversion == true) then
    local GB = 1024 * 1024 * 1024; -- 定义GB的计算常量
    local MB = 1024 * 1024; -- 定义MB的计算常量
    local KB = 1024; -- 定义KB的计算常量
    local countResult = ""

    if (size / GB >= 1) then
      -- 如果当前Byte的值大于等于1GB
      countResult = string.format("%.2f", size / GB) .. "GB"
      return countResult
     elseif (size / MB >= 1) then
      -- 如果当前Byte的值大于等于1MB
      countResult = string.format("%.2f", size / MB) .. "MB"
      return countResult
     elseif (size / KB >= 1) then
      -- 如果当前Byte的值大于等于1KB
      countResult = string.format("%.2f", size / KB) .. "KB"
      return countResult
     else
      countResult = tostring(size) .. "B"
      return countResult
    end

   elseif (conversion == nil or conversion == false) then
    return size
  end
end


function dp2px(dpValue)
  local scale = this.getResources().getDisplayMetrics().density
  return (dpValue * scale + 0.5)
end

function sp2px(spValue)
  local fontScale = this.getResources().getDisplayMetrics().scaledDensity
  return (spValue * fontScale + 0.5)
end

function glideImg(id, url)
  if setting.loadImg then
    id.setImageBitmap(loadbitmap('static/img/zs.png'))
   else
    if not pcall(function(...)
        Glide.with(this).load(url).placeholder(R.drawable.zs).error(R.drawable.vd).fallback(R.drawable.vd)
        .dontTransform() -- 磁盘缓存策略
        -- .diskCacheStrategy(DiskCacheStrategy.NONE)
        .sizeMultiplier(0.8).into(id);
      end) then
      id.setImageBitmap(loadbitmap('static/img/zs.png'))
    end

  end
end

function getIdByString(tt)
  --  return assert(loadstring(tt))()
  return loadstring("return " .. tt)()

end

function judgeKeyInTable(tab, keyword)
  for key, value in pairs(tab) do
    if key == keyword then
      return true
    end
  end
  return false
end

function judgeValueInTable(tab, keyword)
  for key, value in pairs(tab) do
    if value == keyword then
      return true, key
    end
  end
  return false
end

function setFont(id, path)
  id.setTypeface(Typeface.createFromFile(File(file)))
end

function showToast(content, width, height)
  -- Toast.makeText(activity,tostring(text), Toast.LENGTH_LONG).setGravity(Gravity.TOP, 0, activity.height/5).show()
  tcxx = {
    LinearLayout, -- 线性布局
    orientation = 'vertical', -- 布局方向
    layout_width = 'fill', -- 布局宽度
    layout_height = 'fill', -- 布局高度
    {
      CardView, -- 卡片控件
      layout_width = 'wrap', -- 卡片宽度
      layout_height = 'wrap', -- 卡片高度
      -- CardBackgroundColor='#aaeeeeee';--卡片颜色
      CardBackgroundColor = '#aaeeeeee', -- 卡片颜色
      elevation = 0, -- 阴影属性
      radius = '19dp', -- 卡片圆角
      {
        TextView,
        layout_width = "wrap", -- 布局宽度
        layout_height = "wrap", -- 布局高度
        background = "#227CEA", -- 背景颜色
        padding = "15dp", -- 布局填充
        textSize = "15dp", -- 文字大小
        textColor = "#ffffff", -- 文字颜色
        gravity = "center", -- 布局居中
        id = "wenzi" -- 控件ID
      }
    }
  };
  local toast = Toast.makeText(activity, "文本", Toast.LENGTH_SHORT).setView(loadlayout(tcxx))
  if not height then
    height = activity.height / 5
  end
  if not width then
    width = 0
  end
  toast.setGravity(Gravity.TOP, width, height)
  wenzi.Text = tostring("" .. content .. "")
  toast.show()
end

function print(text)
  if type(text)==table then
   showToast(dump(text))
   else
   showToast(tostring(text))
  end
end



function toTable(datas)
  local temp = {}
  for k, v in pairs(luajava.astable(datas)) do
    temp[k] = v
  end
  return temp
end

function matchonce(key, html)
  if not html then
    return false
  end
  local html = tostring(html)
  local result = html:match(key)
  if not result then
    return false
   else
    return result
  end
end

function matchall(key, html)
  if not html then
    return false
  end
  if not key then
    return false
  end
  local result = string.gmatch(tostring(html), key)
  if not result then
    return false
  end
  local temp = {}
  for k, v, m, n, j, t, s, p, q, a in result do
    local tt = {}
    if v then
      table.insert(tt, k:match("^[%s]*(.-)[%s]*$"))
      table.insert(tt, v:match("^[%s]*(.-)[%s]*$"))
      if m then
        table.insert(tt, m:match("^[%s]*(.-)[%s]*$"))
      end
      if n then
        table.insert(tt, n:match("^[%s]*(.-)[%s]*$"))
      end
      if j then
        table.insert(tt, j:match("^[%s]*(.-)[%s]*$"))
      end
      if t then
        table.insert(tt, t:match("^[%s]*(.-)[%s]*$"))
      end
      if s then
        table.insert(tt, s:match("^[%s]*(.-)[%s]*$"))
      end
      if p then
        table.insert(tt, p:match("^[%s]*(.-)[%s]*$"))
      end
      if q then
        table.insert(tt, q:match("^[%s]*(.-)[%s]*$"))
      end
      if a then
        table.insert(tt, a:match("^[%s]*(.-)[%s]*$"))
      end
      table.insert(temp, tt)
     else
      table.insert(temp, k:match("^[%s]*(.-)[%s]*$"))
    end
  end
  if #temp == 0 then
    return false
   else
    return temp
  end
end

function trim(input)
  ---print(1111)
  if not input then
    return false
  end
  -- print(input)
  input = tostring(input)
  return (input:gsub("^%s+", ""):gsub("%s+$", ""))
end
function length(t)
  local res = 0
  for k, v in pairs(t) do
    res = res + 1
  end
  return res
end

function split(input, delimiter)
  input = tostring(input)
  delimiter = tostring(delimiter)
  if (delimiter == "") then
    return {input}
  end
  if (input == "") then
    return {}
  end

  local pos, arr = 0, {}
  for st, sp in function()
      return string.find(input, delimiter, pos, true)
    end do
    table.insert(arr, string.sub(input, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(input, pos))
  return arr
end

function replace(str, re_str, tar_str)
  if not tar_str or not str or #str < #re_str then
    return str
  end
  local temp = ''
  local re_temp = ''
  local tar_temp = ''
  for i = 1, #str do
    temp = temp .. tostring(string.byte(str, i)) .. 'm'
  end
  for i = 1, #re_str do
    re_temp = re_temp .. tostring(string.byte(re_str, i)) .. 'm'
  end

  for i = 1, #tar_str do
    tar_temp = tar_temp .. tostring(string.byte(tar_str, i)) .. 'm'
  end
  local res = string.gsub(temp, re_temp, tar_temp)
  local results = split(res, 'm')
  local result = ''
  for k, v in pairs(results) do
    if #v > 0 then
      result = result .. string.char(tointeger(v))
    end
  end
  return result
end

function slice(str, num1, num2)
  if #str < num2 or str == nil or #str == 0 then
    return str
  end
  local tar = {}
  local temp = {}
  local tt = str:gmatch("(%S)")
  for t in tt do
    table.insert(tar, t)
  end
  for k, v in ipairs(tar) do
    local c = string.byte(v)
    if k + 2 < #tar then
      c1 = string.byte(tar[k + 2])
    end
    if (c >= 48 and c <= 57) or (c >= 65 and c <= 90) or (c >= 97 and c <= 122) then
      table.insert(temp, v)
     elseif c >= 228 and c <= 233 then
      if (c1 >= 48 and c1 <= 57) or (c1 >= 65 and c1 <= 90) or (c1 >= 97 and c1 <= 122) then
       else
        table.insert(temp, v .. tar[k + 1] .. tar[k + 2])
      end
    end

  end
  if #temp < num2 then
    return table.concat(temp)
  end
  local ss = ""
  for k = num1, num2 do
    if temp[k] then
      ss = ss .. temp[k]
    end
  end

  return ss
end

function startswith(str, key)

  if str == nil or key == nil then
    return nil, "the string or the sub-stirng parameter is nil"
  end
  if string.find(str, key) ~= 1 then
    return false
   else
    return true
  end
end
function endswith(str, substr)
  if str == nil or substr == nil then
    return false, "the string or the sub-string parameter is nil"
  end
  str_tmp = string.reverse(str)
  substr_tmp = string.reverse(substr)
  if string.find(str_tmp, substr_tmp) ~= 1 then
    return false
   else
    return true
  end
end
function startsWith(str, key)

  if str == nil or key == nil then
    return nil, "the string or the sub-stirng parameter is nil"
  end
  if string.find(str, key) ~= 1 then
    return false
   else
    return true
  end
end
function endsWith(str, substr)
  if str == nil or substr == nil then
    return nil, "the string or the sub-string parameter is nil"
  end
  str_tmp = string.reverse(str)
  substr_tmp = string.reverse(substr)
  if string.find(str_tmp, substr_tmp) ~= 1 then
    return false
   else
    return true
  end
end

function decodestring(Unicode)
  if Unicode and Unicode:find([[\]]) then
    local res, info = pcall(function(str)
      local json = [[{"name":"]]
      local t = [["}]]
      local zh = json .. Unicode .. t -- 把它们结合为json
      local b = [[{"name":"\u5c0f\u83dc\u9e1f\u6700\u5e05"}]] -- 完整的json
      local data = cjson.decode(zh); -- 解析json字符串
      return data["name"]; -- 打印json字符串中的name字段
    end, Unicode)
    if res then
      return info
     else
      local res1, info1 = pcall(function(Unicode)
        return loadstring([[return "]] .. str:gsub("\\", "\\\\"):gsub("\\\\u", "\\u"):gsub("\"", "\\\"") ..
        [["]])()
      end, Unicode)
      if res1 then
        return info1
       else
        return Unicode
      end
    end
   else
    return Unicode
  end
end

function tableMerge(table1, table2)
  for k, v in pairs(table2) do
    if type(k) == "number" then
      table.insert(table1, v)
     else
      table1[k] = v
    end
  end
  return table1
end
