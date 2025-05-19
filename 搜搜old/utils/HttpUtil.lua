require "import"
import "cjson"
import "utils.util"

function HttpUtil()

  local function request(...)
    local self = {...}
    import "android.net.Uri"
    local url, data, header, encoding, callback
    for k, v in pairs(self) do
      if type(v) == "function" then
        callback = v
       elseif type(v) == "string" then
        if v:find("http") and not v:find("{") then
          url = tostring(Uri.parse(v))
         elseif v:find("{") and v:find "}" then
          if v:find("agent") or v:find("Agent") then
            header = cjson.decode(v)
           else
            data = cjson.decode(v)
          end
         elseif #v < 8 then
          encoding = v
         else
          cookie = v
        end
      end
    end
    if not startswith(url, "http") then
      showToast("错误的请求链接!")
      return
    end
    if not callback then
      showToast("无回调函数")
      return
    end
    if data then
      Http.post(url, data, cookie, encoding, header, callback)
     else
      Http.get(url, cookie, encoding, header, callback)
    end
  end
  local function getHtml(...)
 -- local function request(...)
    local self = {...}
    import "android.net.Uri"
    local url, data, header, encoding, callback, cookie
    for k, v in pairs(self) do
      if type(v) == "function" then
        callback = v
       elseif type(v) == "string" then
        if v:find("http") and not v:find("{") then
          url = tostring(Uri.parse(v))
         elseif v:find("{") and v:find "}" then
          if v:find("agent") or v:find("Agent") then
            header = cjson.decode(v)
           else
            data = cjson.decode(v)
          end
         elseif #v < 8 then
          encoding = v
         else
          cookie = v
        end
      end
    end
    if not startswith(url, "http") then
      showToast("错误的请求链接!")
      return
    end

    import "java.net.URL"
    import "java.net.HttpCookie"
    import "java.net.HttpURLConnection"
    import "java.io.BufferedReader"
    import "java.io.InputStreamReader"
    import "java.io.OutputStreamWriter"

    import "java.io.PrintWriter"
    local url1 = URL(url)
    local conn = url1.openConnection()
    conn.setUseCaches(true)

    conn.setConnectTimeout(2 * 1000);
    conn.setReadTimeout(2 * 1000);

    conn.setRequestProperty("Accept", "*/*");
    -- conn.setRequestProperty("Content-Type", "application/json");
    conn.setRequestProperty("Connection", "Keep-Alive");
    if header then
      for k, v in pairs(header) do
        conn.setRequestProperty(k, v);
      end
    end
    if cookie then
      conn.setRequestProperty("Cookie", cookie);
    end
    if data then
      conn.setDoOutput(true);
      conn.setDoInput(true)
      conn.setRequestMethod("POST");
      writer = OutputStreamWriter(conn.getOutputStream());
      local temp = ""
      for k, v in pairs(data) do
        temp =temp.. k .. "=" .. v .. "&"
      end
      writer.write(temp);
      writer.flush();
      writer.close();
     else
      conn.setRequestMethod("GET");
    end
    conn.setInstanceFollowRedirects(true);
    local code = conn.getResponseCode()
    local cookieStrings = conn.getHeaderFields().get("Set-Cookie")

    local headerFields = conn.getHeaderFields()
    local headerMap = {}
    for k, v in pairs(luajava.astable(headerFields.keySet())) do
      headerMap[v] = headerFields[v]
    end

    if code == 200 then
      is1 = conn.getInputStream()
     else
      is1 = conn.getErrorStream()
    end
    local isr = InputStreamReader(is1)
    local br = BufferedReader(isr)

    -- 读取响应内容到字符串
    local sb = ""
    local inputLine = br.readLine()
    while inputLine ~= nil do
      sb = sb .. inputLine
      inputLine = br.readLine()
    end

    br.close()
    is1.close()
    local redirectUrl = conn.getURL().toString();
    if code == HttpURLConnection.HTTP_MOVED_TEMP or code == HttpURLConnection.HTTP_MOVED_PERM or code ==
      HttpURLConnection.HTTP_SEE_OTHER then
      redirectUrl = conn.getHeaderField("Location");
    end
    --callback(code, sb, headerMap, cookieStrings, redirectUrl)
    return code, sb, headerMap, cookieStrings, redirectUrl
  end
  function getWebHtml(...)
    local self = {...}
    import "android.webkit.CookieSyncManager"
    import "android.webkit.CookieManager"

    local function setCookie(context, url, content) -- 设置cookie
      CookieSyncManager.createInstance(context)
      local cookieManager = CookieManager.getInstance()
      cookieManager.setAcceptCookie(true)
      cookieManager.setCookie(url, content)
      CookieSyncManager.getInstance().sync()
    end

    import "android.net.Uri"

    local url, data, header, encoding, callback
    for k, v in pairs(self) do
      if type(v) == "function" then
        callback = v
       elseif type(v) == "string" then
        if v:find("http") then
          url = tostring(Uri.parse(v))
         elseif v:find("{") and v:find "}" then
          if v:find("agent") or v:find("Agent") then
            header = cjson.decode(v)
           else
            data = cjson.decode(v)
          end
         elseif #v < 8 then
          encoding = v
         else
          cookie = v
        end
      end
    end
    if not startswith(url, "http") then
      showToast("错误的请求链接!")
      return
    end
    if not callback then
      showToast("无回调函数")
      return
    end
    local ua = header["User-Agent"]
    if not ua then
      ua = header["User-agent"]
    end
    if not ua then
      ua = header["user-agent"]
    end
    if not ua then
      ua =
      "Mozilla/5.0 (Linux; Android 7.1.2; Build/NJH47F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.109 Safari/537.36"
    end
    local gh = LuaWebView(this);
    gh.getSettings().setUserAgentString(ua)
    gh.getSettings().setJavaScriptEnabled(true)
    if not data then
      gh.loadUrl(tostring(Uri.parse(url)), header)
     else
      gh.postUrl(tostring(Uri.parse(url)), String(data).getBytes())
    end
    setCookie(activity, url, cookie)

    gh.setWebViewClient {
      onPageFinished = function(view, url)
        view.evaluateJavascript(
        "function getSource(){return \"<html>\"+document.getElementsByTagName('html')[0].innerHTML+\"</html>\";};getSource();",
        {
          onReceiveValue = function(result)
            result = result:gsub("%%", "%%;"):gsub("\\\\n", "%%n"):gsub("\\\\t", "%%t")
            :gsub("\\n", "\n"):gsub("\\t", "\t"):gsub("%%n", "\\n"):gsub("%%t", "\\t"):gsub("%%;",
            "%%"):gsub("\\u003C", "<"):gsub("\\\"", "\""):gsub("^\"", "")
            -- :gsub("\"$","")
            -- result=result:gsub("%%","%%;"):gsub("\\\\n","%%n"):gsub("\\n","\n"):gsub("%%n","\\n"):gsub("%%;","%%"):gsub("\\u003C","<"):gsub("\\\"","\""):gsub("^\"",""):gsub("\"$","")

            callback(result)

            luajava.clear(gh)
          end
        })
      end
    }
  end
  return {
    request = request,
    getHtml = getHtml,
    getWebHtml = getWebHtml
  }
end
