layout=loadlayout({
  LinearLayout,
  layout_width = "fill",
  orientation = "vertical",
  id = "发现页面",
  backgroundColor=ColorStyles().white,
  {
    LinearLayout,
    layout_height = "fill",
    layout_width = "fill",
    orientation = "vertical",
    {
      LinearLayout,
      layout_width = "fill",
      layout_height = ButtonStyles().height_large,
      gravity = "center",
      {
        TextView,
        id = "bt",
        text = "豆瓣影评-douban",
        textSize = TextStyles().large_little,
        gravity = "center",
        layout_weight = "1",
        textColor=ColorStyles().blue,
        --Typeface=Typeface.DEFAULT_BOLD;
        Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font/font.ttf"));
      }
    },
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "fill",
      layout_height = ButtonStyles().height_medium_little,
      layout_marginTop=MarginStyles().big,
      layout_marginLeft = MarginStyles().big,
      layout_marginRight=MarginStyles().big,
      {
        CardView,
        layout_width = "30dp",
        layout_height = "30dp",
        layout_gravity = "center",
        cardElevation = "0dp",
        radius = "15dp",
        {
          ImageView,--圆形图片控件
          layout_width="fill",--布局宽度
          layout_height="fill",--布局高度
          --src="icon.png",--视图路径
          id='webuserpic',--控件ID
        },
      },
      {
        LinearLayout,
        layout_height = "wrap",
        orientation = "vertical",
        layout_width = "fill",
        layout_gravity = "center",
        layout_marginLeft=MarginStyles().big,
        {
          TextView,--文本框控件
          id='webusernameout',--控件ID
          textSize = TextStyles().medium,

          Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font/font.ttf"));
        },
        {
          TextView,--文本框控件
          id='webtitledateout',--控件ID
          textSize = TextStyles().small,
        }

      }

    },
    {
      TextView,--文本框控件
      layout_margin = MarginStyles().big,
      layout_width='fill',
      layout_height='wrap',
      id='webtitleout',--控件ID
      textSize = TextStyles().bigger_little,
      textColor=ColorStyles().black,
      Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font/zt1.ttf"));
    },

    {
      HtmlTextView,
      layout_width="fill",
      layout_height="fill",
      id="luaweb",
      textColor=ColorStyles().black,
      textSize=TextStyles().big,
      layout_margin=MarginStyles().big,
      layout_marginTop='0dp',--布局顶距
    },

  }
})