-- 使弹出的输入法不影响布局
import "android.view.inputmethod.InputMethodManager"
import "com.google.android.material.textfield.TextInputEditText"
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);

searchBody = {

  CardView,
  -- orientation = "horizontal",
  layout_height = "fill",
  layout_width = "fill",
  radius = "15dp",

  backgroundColor = 0xffffffff, -- 背景颜色
  {
    LinearLayout, -- 线性布局
    layout_width = 'fill', -- 宽度
    layout_height = 'fill', -- 高度
    background = '#ffFFFFFF', -- 背景颜色或图片路径
    orientation = "vertical",
    layout_margin = '24dp', -- 布局左距
    -- windowSoftInputMode="adjustResize",
    -- layout_marginRight='24dp';--布局右距
    {
      MaterialCardView, -- 卡片控件
      layout_width = 'fill', -- 卡片宽度
      layout_height = '48dp', -- 卡片高度

      cardBackgroundColor = '#00ffffff', -- 卡片颜色
      layout_margin = '0dp', -- 卡片边距
      cardElevation = '0dp', -- 卡片阴影
      strokeWidth = "2dp", -- 边框宽度
      strokeColor = "#99000000", -- 边框颜色
      radius = '10dp', -- 卡片圆角

      {
        LinearLayout, -- 线性布局
        layout_width = 'fill', -- 宽度
        layout_height = 'fill', -- 高度
        background = '#ffFFFFFF', -- 背景颜色或图片路径
        orientation = "horizontal",
        gravity = "center", -- 内容重力

        {
          TextInputEditText, -- 编辑框控件
          layout_width = 'fill', -- 控件宽度
          layout_height = 'fill', -- 控件高度
          id = 'searchEdit', -- 设置控件ID
          focusable = true, -- 可聚焦
          focusableInTouchMode=true,
          textSize = '16sp', -- 本文大小
          textColor = '#333333', -- 本文颜色
          layout_marginLeft = '20dp', -- 布局左距
          layout_marginRight = '20dp', -- 布局右距
          gravity = 'left|center', -- 重力
          background = '#00ffffff', -- 底条透明
          singleLine = true, -- 设置单行输入，禁止换行
          imeOptions = 'actionSearch', -- 设置回车键搜索
          ellipsize = 'end', -- 多余文字用省略号
          minLines = 1, -- 默认占用的行数
          MaxLines = 1, -- 设置最大输入行数
          layout_weight = 1 -- 布局权重
        },

        {
          TextView, -- 文本控
          text = "取消",
          textSize = "16dp",
          id = "searchButton",
          textColor = "#ee000000",
          layout_marginRight = '20dp'
        }
      }
    },

    {
      LinearLayout, -- 线性布局
      layout_width = 'fill', -- 宽度
      layout_height = 'wrap', -- 高度
      background = '#ffFFFFFF', -- 背景颜色或图片路径
      orientation = "horizontal",
      layout_marginTop = '15dp',
      {
        TextView, -- 文本控
        text = "编辑：",
        textSize = "14dp",
        textColor = "#ee000000"

      },
      {
        TextView, -- 文本控
        textSize = "14dp",
        textColor = "#ee000000",
        text = "https://cn.tripadvisor.com/TravelersChoice-Destinations-cTrending-g1",
        id = "urlEdit",
        singleLine = true, -- 真

        layout_weight = 1, -- 布局权重
        ellipsize = "end"
      },

      {
        ImageView, -- 图片控件
        layout_width = '20dp', -- 图片宽度
        layout_height = '20dp', -- 图片高度
        layout_marginLeft = '10dp',
        ColorFilter = '#5C5C5C', -- 图片着色
        src = "static/img/webview/copy.png",
        --    id="homeButton"; ColorFilter='#5C5C5C';--图片着色
        scaleType = 'fitXY', -- 图片拉伸
        layout_gravity = 'center', -- 重力
        id = 'imgCopy' -- 设置控件ID
      }

    },
    {
      RecyclerView,
      layout_height = "wrap",
      id = "tip_list",
      layout_marginTop = '10dp',
      layout_width = "wrap"
    },

    {
      RecyclerView,
      layout_height = "wrap",
      layout_marginTop = '10dp',
      id = "searchWebList",
      layout_width = "fill",
      background = "#55ffffff"
    }
  }
}

tipItem = {
  LinearLayout, -- 线性布局
  layout_width = 'wrap', -- 宽度
  layout_height = '48dp', -- 高度
  background = '#ffFFFFFF', -- 背景颜色或图片路径
  orientation = "horizontal",
  {
    CardView, -- 卡片控件
    layout_width = 'wrap', -- 卡片宽度
    layout_height = 'fill', -- 卡片高度
    cardBackgroundColor = '#11000000', -- 卡片颜色
    layout_margin = '5dp', -- 卡片边距
    cardElevation = '0dp', -- 卡片阴影
    id = 'singleItem',
    radius = '10dp', -- 卡片圆角
    {
      TextView, -- 文本控
      textSize = "14dp",
      textColor = "#ee000000",
      id = "name",
      layout_marginLeft = '10dp', -- 卡片边距
      layout_marginRight = '10dp', -- 卡片边距
      gravity = "center",
      layout_gravity = 'center'
    }

  }
}

searchUrlItem = {
  LinearLayout, -- 线性布局
  layout_width = 'fill', -- 宽度
  layout_height = '50dp', -- 高度
  background = '#ffFFFFFF', -- 背景颜色或图片路径
  orientation = "horizontal",
  {

    CardView, -- 卡片控件
    layout_width = 'fill', -- 卡片宽度
    layout_height = 'fill', -- 卡片高度
    -- cardBackgroundColor = '#00ffffff', -- 卡片颜色
    layout_margin = '5dp', -- 卡片边距
    {
      LinearLayout, -- 线性布局
      layout_width = 'fill', -- 宽度
      layout_height = 'fill', -- 高度
      background = '#ffFFFFFF', -- 背景颜色或图片路径
      orientation = "horizontal",
      gravity = "left|center", -- 内容重力
      id = "singleItem",
      {
        ImageView, -- 图片控件
        layout_width = '20dp', -- 图片宽度
        layout_height = '20dp', -- 图片高度
        layout_marginLeft = '10dp',
        --    id="homeButton"; ColorFilter='#5C5C5C';--图片着色
        scaleType = 'fitXY', -- 图片拉伸
        id = 'icon',
        layout_gravity = 'center' -- 重力
      },
      {
        TextView, -- 文本控件
        layout_width = 'wrap', -- 宽度
        layout_height = 'wrap', -- 高度
        layout_marginLeft = '10dp', -- 左边距
        layout_marginRight = '10dp', -- 右边距
        textSize = '14dp', -- 字体大小
        textColor = '#ee000000', -- 字体颜色
        id = 'name', -- 控件ID
        gravity = 'center' -- 内容重力
      }
    }
  }
}

webTitle.onClick = function()
  isPop = true
  searchTipDatas = webHisUtli.getHistorys()
  searchUrls = {}

  local btemp = {}
  btemp.url = 'https://cn.bing.com/search?q=searchKey'
  btemp.name = '必应'
  btemp.icon = 'static/img/webview/bing.png'
  table.insert(searchUrls, btemp)

  local bdtemp = {}
  bdtemp.url = 'https://www.baidu.com/s?word=searchKey'
  bdtemp.name = '百度'
  bdtemp.icon = 'static/img/webview/bd.png'
  table.insert(searchUrls, bdtemp)

  local sgtemp = {}
  sgtemp.url = 'https://www.sogou.com/web?query=searchKey'
  sgtemp.name = '搜狗'
  sgtemp.icon = 'static/img/webview/sg.png'
  table.insert(searchUrls, sgtemp)

  local kktemp = {}
  kktemp.url = 'https://quark.sm.cn/s?q=searchKey'
  kktemp.name = '夸克'
  kktemp.icon = 'static/img/webview/kk.png'
  table.insert(searchUrls, kktemp)

  local tstemp = {}
  tstemp.url = 'https://www.so.com/s?q=searchKey'
  tstemp.name = '360'
  tstemp.icon = 'static/img/webview/360.png'
  table.insert(searchUrls, tstemp)

  local gtemp = {}
  gtemp.url = 'https://www.google.com/search?q=searchKey'
  gtemp.name = '谷歌'
  gtemp.icon = 'static/img/webview/gg.png'
  table.insert(searchUrls, gtemp)

  local searchPop = PopupWindow(activity)
  searchPop.setContentView(loadlayout(searchBody))
  searchPop.setWidth(activity.width) -- 设置宽度
  searchPop.setHeight(activity.height * 0.8)
  searchPop.setFocusable(true) -- 设置可获得焦点
  searchPop.setTouchable(true).setClippingEnabled(false) -- 设置启用剪辑
  .setBackgroundDrawable(nil)
  -- 设置可触摸
  -- 设置点击外部区域是否可以消失
  searchPop.setOutsideTouchable(true)
  activity.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or View.SYSTEM_UI_FLAG_IMMERSIVE

  searchPop.showAtLocation(menu, Gravity.BOTTOM, 0, 0)
  task(200, function()
    searchEdit.requestFocus()
    activity.getSystemService(Context.INPUT_METHOD_SERVICE).showSoftInput(searchEdit, 0)
    -- 注:如果没效果请配合延迟使用,id是编辑框的id
  end)
  urlEdit.text = webView.getUrl()

  searchPop.onDismiss = function()
    isPop = false

  end

  urlEdit.onClick = function()
    searchEdit.setText(urlEdit.text)
  end

  searchButton.onClick = function()

    if #searchEdit.text == 0 then
      searchPop.dismiss()
     else

      searchPop.dismiss()
      -- webView.clearHistory()

      if startsWith(searchEdit.text, 'http') and searchEdit.text:find('//') then
        webView.loadUrl(searchEdit.text)
       elseif startsWith(searchEdit.text, 'www') then
        webView.loadUrl("http://" .. searchEdit.text)
       elseif startsWith(searchEdit.text, '//') then
        webView.loadUrl("http:" .. searchEdit.text)
       elseif startsWith(searchEdit.text, 'magnet:') or startsWith(searchEdit.text, 'thunder:') or startsWith(searchEdit.text, 'ed2k:') or startsWith(searchEdit.text, 'ftp:')then

        local site={}
        site.name="temp"
        site.type="temp"
        local fileName =XLTaskHelper.instance().getFileName(searchEdit.text)
        if not fileName then
          fileName=tostring(os.time())
        end
        activity.newActivity("pages/play/play", {{site, {["标题"]=fileName,["地址"]=searchEdit.text}}})

       else
        webHisUtli.setHistory(searchEdit.text)
        webView.loadUrl(replace(webSearchUrl, "searchKey", searchEdit.text))
      end
    end
  end

  imgCopy.onClick = function()

    systemUtil.copyContent(webView.getUrl())

  end

  tip_list.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.HORIZONTAL))
  tip_adp = LuaCustRecyclerAdapter(AdapterCreator({
    getItemCount = function()
      return #searchTipDatas
    end,
    getItemViewType = function(position)
      return 0
    end,
    onCreateViewHolder = function(parent, viewType)
      local views = {}
      holder = LuaCustRecyclerHolder(loadlayout(tipItem, views))
      holder.view.setTag(views)
      return holder
    end,
    onBindViewHolder = function(holder, position)
      local view = holder.view.getTag()
      view.name.setText(searchTipDatas[position + 1])
      view.singleItem.onClick = function()
        searchEdit.setText(searchTipDatas[position + 1])
      end
    end
  }))

  tip_list.setAdapter(tip_adp)

  searchWebList.setLayoutManager(StaggeredGridLayoutManager(2, StaggeredGridLayoutManager.VERTICAL))
  searchWebAdapter = LuaRecyclerAdapter(searchUrls, searchUrlItem, {
    onBindViewHolder = function(holder, position)
      local view = holder.view.getTag()
      local data = searchUrls[position + 1]
      view.name.setText(data.name)

      view.icon.setImageBitmap(loadbitmap(data.icon))
      if data.url == webSearchUrl then
        view.name.setTextColor(0xff227CEA)
        view.singleItem.setBackgroundColor(0x33227CEA)
       else
        view.name.setTextColor(0xee000000)
        view.singleItem.setBackgroundColor(0xffffff)
      end

      view.singleItem.onClick = function()
        webSearchUrl = data.url
        settingUtil.setSetting("webSearchUrl", webSearchUrl)
        searchWebAdapter.notifyDataSetChanged()
      end
    end
  })
  searchWebList.setAdapter(searchWebAdapter)

  searchEdit.addTextChangedListener {
    onTextChanged = function(a)
      if #searchEdit.text == 0 then
        searchButton.setTextColor(0xee000000); -- 设置文本颜色
        searchButton.setText("取消")
        searchTipDatas = webHisUtli.getHistorys()
        tip_adp.notifyDataSetChanged()

        --[[elseif searchEdit.text:find('%.') then
        searchButton.setTextColor(0xff227CEA); -- 设置文本颜色
        searchButton.setText("进入")
        httpUtil.request("http://suggestion.baidu.com/su?wd=" .. searchEdit.text .. "&p=1", function(a, b)
          if a == 200 then

            local datai = string.gmatch(b, '"(.-)"')
            searchTipDatas = {}
            for item in datai do
              table.insert(searchTipDatas, item)
            end

            tip_adp.notifyDataSetChanged()
            -- tip_list.setAdapter(tip_adp)
          end
        end)]]
       elseif startsWith(searchEdit.text, 'http') or startsWith(searchEdit.text, 'magnet:') or startsWith(searchEdit.text, 'thunder:') or startsWith(searchEdit.text, 'ed2k:') or startsWith(searchEdit.text, 'ftp:')then
        searchButton.setTextColor(0xff227CEA); -- 设置文本颜色
        searchButton.setText("进入")
       else
        searchButton.setTextColor(0xff227CEA); -- 设置文本颜色
        searchButton.setText("搜索")
        httpUtil.request("http://suggestion.baidu.com/su?wd=" .. searchEdit.text .. "&p=1", function(a, b)
          if a == 200 then
            local datai = string.gmatch(b, '"(.-)"')
            searchTipDatas = {}
            for item in datai do
              table.insert(searchTipDatas, item)
            end
            tip_adp.notifyDataSetChanged()
            -- tip_list.setAdapter(tip_adp)
          end
        end)
      end
    end
  }
  searchEdit.setOnEditorActionListener({
    onEditorAction = function(a, b)
      if b == 3 then
        if a.text == "" then
          showToast("搜索内容不能为空！")
          return
         else

          searchPop.dismiss()
          -- webView.clearHistory()
          if startsWith(searchEdit.text, 'http') and searchEdit.text:find('//') then
            webView.loadUrl(searchEdit.text)
           elseif startsWith(searchEdit.text, 'www') or searchEdit.text:find('%.') then
            webView.loadUrl("http://" .. searchEdit.text)
           elseif startsWith(searchEdit.text, '//') then
            webView.loadUrl("http:" .. searchEdit.text)

           elseif startsWith(searchEdit.text, 'magnet:') or startsWith(searchEdit.text, 'thunder:') or startsWith(searchEdit.text, 'ed2k:') or startsWith(searchEdit.text, 'ftp:')then

            local site={}
            site.name="temp"
            site.type="temp"
            local fileName =XLTaskHelper.instance().getFileName(searchEdit.text)
            if not fileName then
              fileName=tostring(os.time())
            end
            activity.newActivity("pages/play/play", {{site, {["标题"]=fileName,["地址"]=searchEdit.text}}})


           else
            webHisUtli.setHistory(searchEdit.text)
            webView.loadUrl(replace(webSearchUrl, "searchKey", searchEdit.text))
          end

        end

      end
    end
  })
end
