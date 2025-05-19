layout = loadlayout({
  LinearLayout,
  orientation = "vertical",
  layout_width = "match_parent",
  layout_height = "match_parent",
  backgroundColor = ColorStyles().white,

  {
    LinearLayout,
    layout_height = ButtonStyles().height_bigger,
    orientation = "horizontal",
    layout_width = "match_parent",
    elevation = ElevationStyles().small,
    {
      TextView,
      layout_height = "40dp",
      textSize = TextStyles().bigger,
      gravity = "left|center",
      layout_width = "wrap_content",
      layout_gravity = "left|center",
      layout_weight = "1",
      text = "本地视频",
      layout_marginLeft = MarginStyles().medium,
      layout_margin = "5dp",
      textColor = ColorStyles().blue,
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf"))
    },
    {
      ImageView,
      src = "static/img/video/delete.png",
      layout_marginRight = MarginStyles().medium,
      colorFilter = ColorStyles().blue,
      scaleType = "fitXY",
      Visibility="8",
      layout_width = "25dp",
      layout_gravity = "right|center",
      layout_marginLeft = "5dp",
      id = "clearout",
      layout_height = "25dp"
    }
  },
  {
    RecyclerView,
    layout_height = "fill",
    id = "bodyout",
    layout_width = "fill"
  }
})
itemout = {
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
      layout_width = "120dp",
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
        layout_height = '70dp',
        id = "picout",
        scaleType = 'fitXY' -- 图片显示类型
      }
    },

    {
      LinearLayout, -- 线性布局
      orientation = 'vertical', -- 方向
      layout_width = 'fill', -- 宽度
      layout_height = 'fill', -- 高度
      background = '#00FFFFFF', -- 背景颜色或图片路径
      layout_marginLeft = MarginStyles().big,
      {
        TextView, -- 文本控件
        -- 左:left 右:right 中:center 顶:top 底:bottom
        -- text=item[2][1];--显示文字
        textSize = '14dp', -- 文字大小
        textIsSelectable = false, -- 长按复制
        ellipsize = "marquee", -- 跑马灯,以横向滚动方式显示(需获得当前焦点时)
        singleLine = true, -- 结束
        selected = true, -- 中选
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
        id = "stateout",
        --   backgroundColor='0xff1e8ae8';--纽扣背景颜色
        ellipsize = "marquee", -- 跑马灯,以横向滚动方式显示(需获得当前焦点时)
        singleLine = true, -- 结束
        layout_weight = "1",
        selected = true, -- 中选
        layout_marginTop = "5dp",
        Typeface = Typeface.DEFAULT_BOLD
      },

    }

  }
}