searchout = loadlayout({
  LinearLayout,
  backgroundColor = "#ffffff",
  layout_width = "fill",
  layout_height = "fill",
  orientation = "vertical",
  {
    LinearLayout,
    layout_gravity = "top|center",
    layout_width = "fill",
    orientation = "horizontal",
    layout_height = "50dp",
    gravity = "top|center",
    {
      LinearLayout,
      Focusable = true,
      layout_width = "fill",
      orientation = "horizontal",
      FocusableInTouchMode = true,
      layout_height = "fill",
      {
        ImageView,
        layout_gravity = "center|right",
        layout_width = "21dp",
        layout_marginRight = "5dp",
        id = "goback",
        src = "static/img/search/left.png",
        layout_height = "20dp",
        layout_marginLeft = "15dp",
        colorFilter = "#757575"
      },
      {
        EditText,
        background = "0xffeeeeee",
        layout_marginTop = "1dp",
        id = "searchtext",
        layout_weight = "1",
        hint = "输入搜索关键词",
        singleLine = "true",
        layout_gravity = "left|center",
        imeOptions = "actionSearch",
        textSize = "13dp",
        layout_marginRight = "5dp",
        lines = "1",
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))
      },
      {
        ImageView,
        layout_gravity = "center|right",
        layout_width = "21dp",
        colorFilter = "#757575",
        id = "searchdelete",
        src = "static/img/search/delete.png",
        layout_height = "25dp",
        layout_marginRight = "15dp"
      },
      {
        LinearLayout,
        backgroundColor = "0xFF000000",
        layout_width = "1",
        layout_height = "15dp",
        layout_gravity = "center"
      },
      {
        ImageView,
        layout_gravity = "center",
        layout_width = "21dp",
        colorFilter = "#757575",
        id = "searchevent",
        src = "static/img/search/search.png",
        layout_height = "21dp",
        layout_marginLeft = "15dp",
        layout_marginRight = "15dp"
      }
    }

  },
  {
    TextView, -- 文本框控件
    layout_width = 'fill',
    layout_height = '1dp',
    backgroundColor = 0x11000000

  },

  {
    LinearLayout,
    layout_width = "match_parent",
    layout_height = "wrap_content",
    orientation = "vertical",
    visibility = 4,
    id = "searchtip",
    {
      LinearLayout,
      layout_width = "match_parent",
      layout_height = "wrap_content",
      orientation = "horizontal",
      {
        TextView,
        textColor = "#227CEA",
        layout_weight = "1",
        text = "热门搜索",
        textSize = "17dp",
        layout_margin = "10dp"
      }
    },
    {
      GridView,
      numColumns = 1,
      VerticalScrollBarEnabled = false,
      layout_width = "match_parent",
      drawSelectorOnTop = true, -- 波纹
      OverScrollMode = 2, -- 线条
      id = "searchtipout"
    }

  },
  {
    LinearLayout,
    layout_width = "match_parent",
    layout_height = "fill",
    orientation = "horizontal",
    {
      ListView,
      dividerHeight = "0",
      layout_width = "80dp",
      layout_height = "fill",

      id = "sitenameout",
      verticalScrollBarEnabled = false -- 隐藏滑条
    },

    {
      RecyclerView,
      layout_height = "fill",
      --  background=白色;
      id = "bodyout",
      layout_width = "fill"
      --[=[  backgroundDrawable=绘制加载动画()  ]=]
    }
  }
})

searchTipItem = {
  LinearLayout, -- 线性布局
  orientation = "vertical", -- 布局方向
  layout_width = "fill", -- 布局宽度
  layout_height = "wrap", -- 布局高度
  {
    LinearLayout,
    layout_width = "match_parent",
    orientation = "horizontal",
    layout_height = "wrap",
    {
      ImageView,
      layout_gravity = "left|center",
      layout_height = "20dp",
      src = "static/img/search/search.png",
      layout_margin = "10dp",
      layout_width = "21dp",
      colorFilter = "#757575"
    },
    {
      TextView,
      ellipsize = "marquee", -- 跑马灯,以横向滚动方式显示(需获得当前焦点时)
      singleLine = true, -- 结束
      selected = true, -- 中选
      layout_margin = "10dp",
      layout_marginLeft = "0dp",
      textSize = "12dp",
      id = "title",
      text = "",
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf")),
      layout_weight = 1
    }
  }
}

item = {
  LinearLayout,
  layout_height = "wrap",
  background = "#00FFFFFF",
  layout_width = "fill",
  orientation = 'horizontal',
  -- gravity='center|center';--重力
  {
    LinearLayout,
    layout_height = "wrap",
    background = "#00FFFFFF",
    layout_width = "fill",
    orientation = "horizontal",
    id = "singleItem",
    -- gravity='center|center';--重力
    layout_margin = '8dp', -- 布局边距

    {
      CardView, -- 卡片控件
      layout_width = "65dp",
      layout_height = 'wrap', -- 高度
      layout_gravity = 'center|center', -- 重力
      -- 左:left 右:right 中:center 顶:top 底:bottom
      elevation = '5dp', -- 阴影
      CardBackgroundColor = '#ffffffff', -- 颜色
      radius = '4dp', -- 圆角

      {
        ImageView, -- 图片控件
        -- src=item[2][3] ;--图片路径
        -- imageBitmap=loadbitmap(item[2][3]);
        layout_width = 'fill', -- 宽度
        layout_height = '90dp',
        id = "picout",
        scaleType = 'fitXY' -- 图片显示类型
      }
    },

    {
      LinearLayout, -- 线性布局
      orientation = 'vertical', -- 方向
      layout_width = 'fill', -- 宽度
      layout_height = '90dp', -- 高度
      background = '#00FFFFFF', -- 背景颜色或图片路径
      layout_marginLeft = "10dp",
      {
        TextView, -- 文本控件
        -- 左:left 右:right 中:center 顶:top 底:bottom
        -- text=item[2][1];--显示文字
        textSize = '14dp', -- 文字大小
        textIsSelectable = false, -- 长按复制
        -- ellipsize = "marquee", -- 跑马灯,以横向滚动方式显示(需获得当前焦点时)
        --singleLine = true, -- 结束
        --selected = true, -- 中选
        maxLines=3,
        layout_weight = "1",
        id = "titleout",
        textColor = "#000000",
        gravity = 'left|center', -- 重力
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))
      },
      {
        TextView, -- 按钮控件
        -- text=item[1]["name"];--显示文字
        gravity = 'center|center', -- 重力
        textSize = '12dp', -- 文字大小
        textColor = 0xff227CEA, -- 文字颜色
        id = "nameout",

        --   backgroundColor='0xff1e8ae8';--纽扣背景颜色
        ellipsize = "marquee", -- 跑马灯,以横向滚动方式显示(需获得当前焦点时)
        singleLine = true, -- 结束
        layout_weight = "1",
        selected = true, -- 中选
        layout_marginTop = "5dp",
        Typeface = Typeface.DEFAULT_BOLD
      },
      {
        TextView, -- 文本控件
        -- 左:left 右:right 中:center 顶:top 底:bottom
        -- text=item[2][4];--显示文字
        textSize = '12dp', -- 文字大小
        textIsSelectable = false, -- 长按复制
        ellipsize = "marquee", -- 跑马灯,以横向滚动方式显示(需获得当前焦点时)
        singleLine = true, -- 结束
        id = "stateout",
        selected = true, -- 中选
        layout_weight = "1",
        gravity = 'left|center', -- 重力
        Typeface = Typeface.DEFAULT_BOLD
      }
    }

  }
}

siteNameItem = {
  LinearLayout,
  layout_height = "wrap",
  layout_width = "fill",
  orientation = "vertical",
  -- gravity='center|center';--重力

  {
    CardView, -- 卡片控件
    layout_width = "fill",
    layout_height = 'wrap', -- 高度
    layout_gravity = 'center|center', -- 重力
    -- 左:left 右:right 中:center 顶:top 底:bottom
    elevation = '5dp', -- 阴影
    layout_width = 'fill', -- 宽度
    layout_height = 'wrap', -- 高度
    radius = '5dp', -- 圆角
    layout_margin = "5dp",
    {
      TextView,
      gravity = 'center|center', -- 重力
      textSize = '12dp', -- 文字大小
      ellipsize = "marquee", -- 跑马灯,以横向滚动方式显示(需获得当前焦点时)
      singleLine = true, -- 结束
      selected = true, -- 中选
      id = "title",
      layout_width = "fill",
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf")),
      paddingTop = "10dp",
      paddingBottom = "10dp"

    }
  }
}

