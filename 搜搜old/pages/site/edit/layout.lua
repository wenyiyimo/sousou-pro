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

      text = "编辑站源",
      layout_marginLeft = MarginStyles().medium,
      layout_margin = "5dp",
      textColor = ColorStyles().blue,
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf"))
    },
    {
      TextView,
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
      layout_marginRight = MarginStyles().medium,
      text = "格式化",
      layout_gravity = "right|center",
      layout_marginRight = "5dp",
      id = "editSiteout",
      textSize = TextStyles().big,
      Visibility=8,
      textColor = ColorStyles().black
    },
    {
      TextView,
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
      layout_marginRight = MarginStyles().medium,
      text = "上一步",
      layout_gravity = "right|center",
      layout_marginRight = "5dp",
      id = "editundo",
      textSize = TextStyles().big,
      Visibility=8,
      textColor = ColorStyles().black
    },

    {
      TextView,
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
      layout_marginRight = MarginStyles().medium,
      text = "下一步",
      layout_gravity = "right|center",
      layout_marginRight = "5dp",
      id = "editredo",
      textSize = TextStyles().big,
      Visibility=8,
      textColor = ColorStyles().black
    },



    {
      TextView,
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
      layout_marginRight = MarginStyles().medium,
      text = "测试",
      layout_gravity = "right|center",
      layout_marginLeft = "5dp",
      id = "popaddsite",
      textSize = TextStyles().big,
      textColor = ColorStyles().black
    }
  },
  {
    LinearLayout,
    layout_width = "fill",
    layout_height = "1dp",
    layout_marginTop = "0dp",
    backgroundColor = 0x22000000
  },
  {
    ScrollView,
    layout_width = "fill",
    verticalScrollBarEnabled = false,
    overScrollMode = 2,
    layout_height = "wrap",

    {
      LinearLayout,
      orientation = "vertical",
      background = "#ffffff",
      layout_width = "fill",
      layout_height = "fill",
      id = "bodyout"
    }
  },
  {
    LinearLayout,
    orientation = "vertical",
    background = "#ffffff",
    layout_width = "fill",
    layout_height = "fill",
    id = "bodyout2",
    Visibility=8,
    {
      LuaEditor,
      id = "luaEditor",
      layout_width = "fill",
      layout_weight = "1",
      layout_height = "fill"

    },


  }
})

function setItemout(idname, hinttext, text)

  visibilitynum = 8
  if text and #text > 0 then
    visibilitynum = 0
  end
  return loadlayout({
    LinearLayout, -- 线性布局
    orientation = 'vertical',
    layout_width = 'fill',
    layout_height = 'wrap',

    {
      LinearLayout, -- 线性布局
      orientation = 'vertical',
      layout_margin = '8dp', -- 布局边距
      layout_width = 'fill',
      layout_height = 'wrap',
      {
        TextView, -- 文本框控件
        text = hinttext,
        id = idname .. 'out', -- 控件ID
        textSize = "12dp",
        Typeface = Typeface.DEFAULT_BOLD,
        layout_marginTop = "5dp",
        visibility = visibilitynum -- 不可视4--隐藏8--显示0
      },
      {
        EditText,
        Text = text,
        id = idname,
        hint = hinttext,
        -- Typeface = L4_14.Typeface.defaultFromStyle(L4_14.Typeface.BOLD),
        layout_marginTop = "5dp",
        layout_width = "fill",
        layout_gravity = "center",
        MaxLines = 1, -- 设置最大输入行数
        MaxEms = 100000,
        Typeface = Typeface.DEFAULT_BOLD,
        textSize = "16dp",
        background = "#00000000",
        singleLine = true -- 设置单行输入
        -- hintTextColor=0xff000000
      },
      {
        LinearLayout,
        layout_width = "fill",
        layout_height = "1dp",
        layout_marginTop = "-2dp",
        layout_gravity = "center",
        backgroundColor = 0xff227CEA,
        id = "弹窗下划线"
      }
    }
  })
end

popMenuout = {
  LinearLayout,
  orientation = 'vertical',
  layout_width = "fill",
  {
    CardView,
    CardElevation = "5dp",
    CardBackgroundColor = 0xffffffff,
    Radius = "5dp",
    layout_width = "wrap",
    layout_height = "wrap",
    layout_margin = "5dp",
    layout_marginRight = "10dp",

    {
      LinearLayout,
      orientation = 'vertical',
      layout_height = 'fill',
      layout_width = 'fill',

      {
        TextView,
        text = '分类页', -- 文本内容
        textSize = "14dp",
        id = "classTest",
        textColor = 0xff000000,
        layout_margin = '15dp', -- 布局底距
        Typeface = Typeface.DEFAULT_BOLD

      },
      {
        TextView,
        text = '搜索页', -- 文本内容
        id = "searchTest",
        textSize = "14dp",
        textColor = 0xff000000,
        layout_margin = '15dp', -- 布局底距
        Typeface = Typeface.DEFAULT_BOLD

      },
      {
        TextView,
        text = '播放页', -- 文本内容
        textSize = "14dp",
        id = "playTest",
        textColor = 0xff000000,
        layout_margin = '15dp', -- 布局底距
        Typeface = Typeface.DEFAULT_BOLD
      },
      {
        TextView,
        text = '浏览器', -- 文本内容
        textSize = "14dp",
        id = "navWeb",
        textColor = 0xff000000,
        layout_margin = '15dp', -- 布局底距
        Typeface = Typeface.DEFAULT_BOLD
      }

    }
  }
}

dialogout = loadlayout({
  LinearLayout,
  layout_height = "fill",
  layout_width = "fill",
  orientation = "vertical",
  {
    LinearLayout,
    id = "loading",
    BackgroundDrawable = setProgress(ColorStrings().blue),
    layout_gravity = "center",
    layout_height = "fill",
    layout_width = "100dp",
    orientation = "vertical",
    layout_marginTop = "100dp"
  },
  {
    ScrollView,
    layout_width = "fill",
    verticalScrollBarEnabled = false,
    overScrollMode = 2,
    layout_height = "fill",
    id = 'testout', -- 控件ID
    layout_gravity = "bottom",
    -- visibility=8,--不可视4--隐藏8--显示0
    {
      LinearLayout,
      layout_height = "fill",
      layout_width = "fill",
      orientation = "vertical",
      layout_marginBottom = "30dp",

      {
        TextView, -- 文本框控件
        layout_width = 'fill',
        layout_height = 'wrap',
        id = 'test', -- 控件ID
        textIsSelectable = true,
        textSize = "12dp",
        Typeface = Typeface.DEFAULT_BOLD,
        textColor = 0xff000000,
        layout_margin = '8dp' -- 布局边距

      }
    }

  }

})