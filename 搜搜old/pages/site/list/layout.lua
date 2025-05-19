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
      id = "sitemanage",
      text = "站源管理",
      layout_marginLeft = MarginStyles().medium,
      layout_margin = "5dp",
      textColor = ColorStyles().blue,
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf"))
    },
    {
      ImageView,
      src = "static/img/site/plus_light.png",
      layout_marginRight = MarginStyles().medium,
      colorFilter = ColorStyles().blue,
      scaleType = "fitXY",
      layout_width = "25dp",
      layout_gravity = "right|center",
      layout_marginLeft = "5dp",
      id = "popaddsite",
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
  layout_width = "fill",
  layout_height = "wrap",
  {
    MaterialCardView,
    layout_gravity = "center",
    layout_width = "fill",
    layout_height = "wrap",
    layout_margin = MarginStyles().medium,
    cardElevation = "1dp",
    radius = "5dp",
    {
      LinearLayout,
      orientation = "vertical",
      layout_width = "fill",
      layout_height = "wrap",
      {
        LinearLayout,
        orientation = "horizontal",
        layout_width = "fill",
        layout_height = "wrap",
        layout_margin = MarginStyles().medium,
        {
          TextView,
          text = "自定义数据",
          id = "title",
          textColor = ColorStyles().blue,

          gravity = "left|center",
          layout_height = "wrap",
          layout_weight = "1",
          textSize = TextStyles().bigger_little,
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf"))
        },

        {
          LinearLayout,
          layout_height = "wrap",
          layout_width = "wrap",
          orientation = "horizontal",
          {
            TextView,
            text = "发现页：",
            Typeface = Typeface.DEFAULT_BOLD,
            layout_width = "wrap",
            gravity = "left|center",
            layout_height = "wrap",
            textSize = "14dp",
            layout_gravity = "left|center"
          },
          {
            Switch,
            switchMinWidth = "50dp",
            id = "classSwitch",
            checked = true
          }
        }
      },
      {
        LinearLayout,
        orientation = "horizontal",
        layout_width = "fill",
        layout_height = "wrap",
        {
          TextView,

          text = "类型：",
          -- layout_marginRight="10dp";

          gravity = "left|center",
          layout_height = "wrap",
          layout_marginLeft = "10dp",
          textSize = TextStyles().small,
          Typeface = Typeface.DEFAULT_BOLD,
          layout_gravity = "left|center"
        },
        {
          TextView,
          id = "type",
          text = "re",
          gravity = "left|center",
          layout_height = "wrap",
          textSize = TextStyles().small,
          Typeface = Typeface.DEFAULT_BOLD,
          layout_gravity = "left|center"
        }
      },
      {
        LinearLayout,
        orientation = "horizontal",
        layout_width = "fill",
        layout_height = "wrap",
        layout_margin = "10dp",
        gravity = "left|center",
        layout_marginBottom = "15dp",
        {
          TextView,
          text = "删除",
          -- layout_weight="1";
          layout_width = "wrap",

          layout_height = "wrap",
          layout_marginRight = "20dp",
          textSize = TextStyles().medium,
          id = "delete",
          Typeface = Typeface.DEFAULT_BOLD

        },

        {
          TextView,
          text = "置顶",
          layout_marginRight = "20dp",
          layout_width = "wrap",

          layout_height = "wrap",
          id = "setTop",

          textSize = TextStyles().medium,
          Typeface = Typeface.DEFAULT_BOLD

        },
        {
          TextView,
          text = "置底",
          layout_marginRight = "20dp",
          layout_width = "wrap",
          layout_height = "wrap",
          id = "setBottom",
          --  layout_weight="1";
          textSize = TextStyles().medium,
          Typeface = Typeface.DEFAULT_BOLD

        },
        {
          TextView,
          text = "分享",
          layout_marginRight = "12dp",
          layout_width = "wrap",
          layout_height = "wrap",
          id = "share",
          textSize = TextStyles().medium,
          Typeface = Typeface.DEFAULT_BOLD,
          layout_weight = "1"

        },
        {
          LinearLayout,
          layout_height = "wrap",
          layout_width = "wrap",
          layout_gravity = "right|center",
          orientation = "horizontal",
          {
            TextView,
            text = "搜索页：",
            Typeface = Typeface.DEFAULT_BOLD,
            layout_width = "wrap",
            layout_height = "wrap",
            textSize = "14dp",
            layout_gravity = "right|center"
          },
          {
            Switch,
            switchMinWidth = "50dp",
            id = "searchSwitch",
            checked = true
          }
        }
      }
    }
  }
}

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
        text = '写miru站源', -- 文本内容
        textSize = "14dp",
        id = "writeMiru",
        textColor = 0xff000000,
        layout_margin = '15dp', -- 布局底距
        Typeface = Typeface.DEFAULT_BOLD

      },
      {
        TextView,
        text = '写html站源', -- 文本内容
        textSize = "14dp",
        id = "writeHtml",
        textColor = 0xff000000,
        layout_margin = '15dp', -- 布局底距
        Typeface = Typeface.DEFAULT_BOLD

      },
      {
        TextView,
        text = '写采集站源', -- 文本内容
        id = "writeCms",
        textSize = "14dp",
        textColor = 0xff000000,
        layout_margin = '15dp', -- 布局底距
        Typeface = Typeface.DEFAULT_BOLD

      },
      {
        TextView,
        text = '导入站源', -- 文本内容
        textSize = "14dp",
        id = "importSite",
        textColor = 0xff000000,
        layout_margin = '15dp', -- 布局底距
        Typeface = Typeface.DEFAULT_BOLD

      },
      {
        TextView,
        text = '导出站源', -- 文本内容
        textSize = "14dp",
        id = "exportSite",
        textColor = 0xff000000,
        layout_margin = '15dp', -- 布局底距
        Typeface = Typeface.DEFAULT_BOLD

      }



    }
  }
}



addsiteitem={
  LinearLayout;
  background="0xFFFFFFFF";
  orientation="vertical";
  layout_height="match_parent";
  layout_width="fill";

  {
    EditText,
    Text ="" ,
    id="sitetext";
    hint = "请粘贴站源数据",
    -- Typeface = L4_14.Typeface.defaultFromStyle(L4_14.Typeface.BOLD),
    layout_marginTop = "10dp",
    layout_width = "80%w",
    layout_gravity = "center",
    MaxLines=1;--设置最大输入行数
    MaxEms=100000;
    Typeface = Typeface.DEFAULT_BOLD;
    textSize = "13dp",
    background = "#00000000"
  },
  {
    LinearLayout,
    layout_width = "80%w",
    layout_height = "1dp",
    layout_marginTop = "-2dp",
    layout_gravity = "center",
    backgroundColor= 0xff227CEA,
    id = "弹窗下划线"
  }
};