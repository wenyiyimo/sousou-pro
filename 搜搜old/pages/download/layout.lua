layout = loadlayout({
  LinearLayout,
  layout_height = "fill",
  layout_width = "fill",
  backgroundColor = ColorStyles().white,
  orientation = 'vertical',
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
      text = "下载",
      id="titleNet",
      layout_marginLeft = MarginStyles().medium,
      layout_margin = "5dp",
      textColor = ColorStyles().blue,
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf"))
    },
    {
      ImageView,
      src = "static/img/heart/delete.png",
      layout_marginRight = MarginStyles().medium,
      colorFilter = ColorStyles().blue,
      scaleType = "fitXY",
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
    id = "downout",
    layout_width = "fill"
  }
})

body_layout = loadlayout({
  LinearLayout,
  layout_height = "fill",
  layout_width = "fill",
  -- backgroundColor = ColorStyles().white,
  orientation = 'vertical',
  id = "body",

  {
    RecyclerView,
    layout_height = "fill",
    id = "bodyout",
    layout_width = "fill"
  }
})

bodyitemout = {
  LinearLayout,
  layout_width = "fill",
  layout_height = "wrap",
  backgroundColor = 0x55000000,
  {
    CardView,
    layout_gravity = "center",
    layout_width = "fill",
    layout_height = "wrap",
    layout_margin = MarginStyles().medium,
    cardElevation = "0dp",
    radius = "5dp",
    id = "bodyCard",
    cardBackgroundColor = 0x55ffffff,
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
        layout_marginBottom = "6dp",
        {
          TextView,
          text = "",
          id = "nameout",

          textColor = ColorStyles().white,
          gravity = "left|center",
          layout_height = "wrap",
          layout_weight = "1",
          singleLine = true,
          ellipsize = "marquee",
          selected = true,
          textSize = TextStyles().bigger_little,
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf"))
        },

        {
          TextView,

          -- text = "类型：",
          -- layout_marginRight="10dp";
          id = "progressout",
          textColor = ColorStyles().blue,
          gravity = "right|center",
          layout_height = "wrap",
          layout_marginLeft = "10dp",
          textSize = "14dp",
          Typeface = Typeface.DEFAULT_BOLD,
          layout_gravity = "left|center"
        }

      },
      {
        LinearLayout,
        orientation = "horizontal",
        layout_width = "fill",
        layout_height = "wrap",
        layout_margin = MarginStyles().medium,
        layout_marginTop = 0,
        {
          TextView,
          text = "",
          Typeface = Typeface.DEFAULT_BOLD,
          layout_width = "wrap",
          gravity = "left|center",
          layout_height = "wrap",
          textSize = "14dp",
          id = "titleout",
          textColor = ColorStyles().white,
          layout_marginRight = MarginStyles().medium,
          layout_gravity = "left|center"
        }
      }
    }
  }
}

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
          text = "",
          id = "nameout",
          textColor = ColorStyles().blue,
          gravity = "left|center",
          layout_height = "wrap",
          layout_weight = "1",
          singleLine = true,
          ellipsize = "marquee",
          selected = true,
          textSize = TextStyles().bigger_little,
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf"))
        },

        {
          TextView,

          -- text = "类型：",
          -- layout_marginRight="10dp";
          id = "titleout",
          gravity = "right|center",
          layout_height = "wrap",
          textColor = 0x99000000,
          layout_marginLeft = "10dp",
          textSize = TextStyles().bigger_little,
          Typeface = Typeface.DEFAULT_BOLD,
          layout_gravity = "left|center"
        }

      },
      {
        LinearLayout,
        orientation = "horizontal",
        layout_width = "fill",
        layout_height = "wrap",
        layout_margin = MarginStyles().medium,
        {
          TextView,
          text = "",
          Typeface = Typeface.DEFAULT_BOLD,
          layout_width = "wrap",
          gravity = "left|center",
          layout_height = "wrap",
          textSize = "14dp",
          id = "progressout",
          textColor = 0x99000000,
          layout_marginRight = MarginStyles().medium,
          layout_gravity = "left|center"
        },
        {
          LinearLayout,
          orientation = "horizontal",
          layout_width = "fill",
          layout_height = "wrap",
          gravity = "right|center",

          {
            TextView,
            text = "删除",
            -- layout_weight="1";
            layout_width = "wrap",
            layout_height = "wrap",
            layout_marginRight = "20dp",
            textSize = "14dp",
            id = "deleteout",
            textColor = 0x99000000,
            Typeface = Typeface.DEFAULT_BOLD
          },
          {
            TextView,
            text = "强制下完",
            -- layout_weight="1";
            layout_width = "wrap",
            layout_height = "wrap",
            layout_marginRight = "20dp",
            textSize = "14dp",
            id = "downSuccessout",
            textColor = 0x99000000,
            Typeface = Typeface.DEFAULT_BOLD
          },
          {
            TextView,
            text = "播放",
            textColor = 0x99000000,
            layout_width = "wrap",
            layout_height = "wrap",
            id = "playout",
            textSize = "14dp",
            Typeface = Typeface.DEFAULT_BOLD
          }

        }
      }
    }
  }
}

media_layout = loadlayout({
  LinearLayout,
  backgroundColor = "#ffffff",
  layout_width = "fill",
  layout_height = "fill",
  orientation = "vertical",
  id = "playView",
  {
    FrameLayout,
    layout_width = "fill",
    layout_height = "fill",
    id = "frame",
    backgroundColor = ColorStyles().black,
    {
      SurfaceView,
      id = "surfaceView",
      layout_width = "fill",
      layout_height = "fill",
      -- layout_weight=1,
      layout_gravity = "center"
    },
    {
      CardView, -- 卡片控件
      layout_gravity = 'center|bottom', -- 重力
      -- 左:left 右:right 中:center 顶:top 底:bottom
      elevation = '1dp', -- 阴影
      layout_width = 'fill', -- 宽度
      layout_height = '3', -- 高度
      id = "cardProgress1",
      CardBackgroundColor = ColorStyles().blue, -- 颜色
      radius = '1dp', -- 圆角
      {
        TextView, -- 卡片控件
        id = 'progress1', -- 设置ID
        layout_margin = '0', -- 卡片边距
        layout_gravity = 'center', -- 重力属性
        Elevation = '1', -- 阴影属性
        layout_width = 'fill', -- 卡片宽度
        layout_height = '3', -- 卡片高度
        BackgroundColor = '#ffffffff' -- 卡片背景颜色
      }
    },
    {
      CardView, -- 卡片控件
      layout_gravity = 'center|bottom', -- 重力
      -- 左:left 右:right 中:center 顶:top 底:bottom
      elevation = '1dp', -- 阴影
      layout_width = 'fill', -- 宽度
      id = "cardProgress2",
      layout_height = '3', -- 高度
      -- layout_marginTop='10';--卡片边距
      CardBackgroundColor = ColorStyles().tiny_blue, -- 颜色
      radius = '1dp', -- 圆角
      {
        TextView, -- 卡片控件
        id = 'progress2', -- 设置ID

        layout_gravity = 'center', -- 重力属性
        Elevation = '1', -- 阴影属性
        layout_width = 'fill', -- 卡片宽度
        layout_height = '3', -- 卡片高度
        BackgroundColor = '#ffffffff' -- 卡片背景颜色
      }

    },

    {
      LinearLayout,
      layout_width = "wrap",
      layout_height = "wrap",
      id = "playLoading",
      orientation = "vertical",
      layout_gravity = "center",
      Visibility = 8,
      {
        LinearLayout,
        layout_width = "80dp",
        layout_height = "80dp",
        orientation = "vertical",
        BackgroundDrawable = setProgress(ColorStrings().blue)
      },
      {
        TextView,
        id = "netWorkText",
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
        textSize = '16sp',
        text = "",
        layout_gravity = "center",
        textColor = ColorStyles().blue
      }
    },
    {
      LinearLayout,
      layout_width = "fill",
      layout_height = "fill",
      id = "control",
      orientation = "vertical",

      {
        LinearLayout,
        layout_width = "fill",
        layout_height = "wrap_content",
        orientation = "horizontal",
        id = "videoHead",
        gravity = "left|center",
        padding = PaddingStyles().medium,
        {
          ImageView,
          src = "static/img/play/left.png",
          id = "goBack",
          layout_width = "30dp",
          layout_height = "30dp",
          layout_marginLeft = "10dp"
        },

        {
          CardView,
          layout_height = "wrap",
          layout_width = "wrap",
          -- background="#00000000";
          radius = "5dp",
          elevation = "0dp",
          layout_width = "wrap",
          layout_gravity = "right|center",

          -- Visibility=8;
          {
            LinearLayout,
            layout_width = "wrap",
            layout_height = "wrap_content",
            orientation = "horizontal",
            gravity = "center",
            padding = "3dp",
            paddingLeft = "5dp",
            paddingRight = "5dp",
            backgroundColor = ColorStyles().lighter,
            {
              TextView,
              -- layout_height = "30dp",
              -- layout_width="50dp",
              -- padding="5dp",
              textSize = TextStyles().small,
              textColor = ColorStyles().blue,
              --  backgroundColor = ColorStyles().lighter,
              text = "未知",
              id = "netWork",
              Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf"))
            }
          }
        },
        {

          TextView,
          selected = true,
          layout_height = "wrap",
          layout_width = "wrap_content",
          layout_gravity = "left|center",
          gravity = "left|center",
          singleLine = true,
          textColor = "#ffffff",
          ellipsize = "marquee",
          id = "playTitle",
          textSize = "15dp",
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))

        },
        {
          LinearLayout,
          layout_width = "fill",
          layout_height = "wrap_content",
          orientation = "horizontal",
          gravity = "right|center",
          layout_weight = "1",

          {
            TextView,
            id = "nowTimeout",
            textSize = "14dp",
            textColor = "#ffffff",
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))
          },

          {
            TextView,
            TextColor = "#ffffff",
            layout_height = "40dp",
            layout_width = "40dp",
            layout_gravity = "right|center",
            gravity = "center",
            -- text = "85",

            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf")),
            --  paddingLeft = "8sp",
            id = "batteryText",
            layout_marginTop = "10dp",
            textSize = "10dp"
          }

        }
      },
      {
        LinearLayout,
        layout_width = "fill",
        orientation = "horizontal",
        layout_height = "fill",
        layout_weight = "1",
        {
          LinearLayout,
          layout_weight = "1",
          orientation = "vertical",
          layout_width = "fill",
          layout_height = "match_parent",
          id = "videoControl"
        },
        {
          RecyclerView,
          layout_height = "fill",
          id = "videoPlayRateout",
          layout_width = "wrap_content",
          layout_gravity = "center|right",
          -- layout_marginRight = "10dp",
          layout_marginTop = "10dp",
          layout_marginBottom = "10dp",
          visibility = 8

        }
      },
      {
        LinearLayout,
        layout_width = "fill",
        layout_height = "wrap_content",
        orientation = "horizontal",
        id = "videoFoot",
        padding = PaddingStyles().medium,
        {
          LinearLayout,
          layout_width = "fill",
          layout_height = "wrap_content",
          orientation = "vertical",
          {
            LinearLayout,
            layout_width = "fill",
            layout_height = "wrap_content",
            orientation = "horizontal",
            {
              TextView,
              textColor = "#ffffff",
              id = "playCurrentout",
              text = "00:00",
              Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))
            },
            {
              SeekBar,
              layout_weight = "1",
              id = "seekbar",
              layout_gravity = "center"
            },
            {
              TextView,
              textColor = "#ffffff",
              id = "playDurationout",
              text = "00:00",
              Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))
            }
          },
          {
            LinearLayout,
            layout_width = "fill",
            layout_height = "wrap_content",
            orientation = "horizontal",
            {
              ImageView,
              layout_height = "40dp",
              src = "static/img/play/last.png",
              layout_width = "40dp",
              layout_gravity = "left|center",
              id = "playLast"
            },
            {
              ImageView,
              layout_height = "50dp",
              src = "static/img/play/pause.png",
              layout_width = "50dp",
              layout_gravity = "left|center",
              id = "playPause"
            },
            {
              ImageView,
              layout_height = "50dp",
              id = "playStart",
              src = "static/img/play/album_play_btn.png",
              layout_width = "50dp",
              layout_gravity = "left|center",
              visibility = 8
            },
            {
              ImageView,
              layout_height = "40dp",
              src = "static/img/play/next.png",
              layout_width = "40dp",
              layout_gravity = "left|center",
              id = "playNext"
            },

            {
              TextView,
              layout_weight = "1"
            },
            {
              LinearLayout,
              layout_width = "wrap_content",
              orientation = "horizontal",
              layout_height = "match_parent",
              id = "skipPlayTime",
              gravity = "right|center",
              visibility = 8,
              {
                TextView,
                textColor = "#ffffff",
                id = "playStartout",
                text = "片头：00:00",
                textSize = "15dp",
                gravity = "right|center",
                layout_height = "fill",
                layout_marginRight = "25dp"
              },
              {
                TextView,
                textColor = "#ffffff",
                id = "playEndout",
                text = "片尾：00:00",
                textSize = "15dp",
                gravity = "right|center",
                layout_height = "fill",
                layout_marginRight = "25dp"
              }
            },
            {
              TextView,
              textColor = "#ffffff",
              id = "selectPlayMode",
              text = "画面",
              textSize = "15dp",
              gravity = "right|center",
              layout_height = "fill",
              layout_marginRight = "25dp"
            },
            {
              TextView,
              textColor = "#ffffff",
              id = "selectPlayout",
              text = "选集",
              textSize = "15dp",
              gravity = "right|center",
              layout_height = "fill",
              layout_marginRight = "25dp"
            },
            {
              TextView,
              textColor = "#ffffff",
              id = "selectPlayrateout",
              text = "倍速",
              textSize = "15dp",
              gravity = "right|center",
              layout_height = "fill",
              layout_marginRight = "25dp"
            },
            {
              ImageView,
              layout_height = "40dp",
              src = "static/img/play/hen.png",
              layout_width = "40dp",
              layout_gravity = "right|center",
              visibility = 8,
              id = "playH"
            },
            {
              ImageView,
              layout_height = "40dp",
              id = "playV",
              src = "static/img/play/shu.png",
              layout_width = "40dp",
              layout_gravity = "right|center",
              visibility = 8
            }
          }
        }
      }
    },
    {
      CardView,
      layout_width = "wrap_content",
      layout_height = "wrap_content",
      visibility = '0',
      layout_marginTop = "20dp",
      cardBackgroundColor = 0xA5000000,
      layout_gravity = "center|top",
      cardElevation = 0,
      radius = '5dp',
      id = "msgRate",
      Visibility = "8",
      {
        TextView,
        layout_width = "wrap",
        layout_height = "wrap",
        id = "msgRateText",
        text = "x2倍速",
        layout_margin = "10dp",
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
        textSize = '16sp',
        textColor = ColorStyles().blue
      }
    },

    {
      CardView,
      layout_width = "wrap_content",
      layout_height = "wrap_content",
      visibility = '0',
      -- layout_marginTop = "0dp",
      cardBackgroundColor = 0xA5000000,
      layout_gravity = "center",
      cardElevation = 0,
      radius = '5dp',
      id = "msgBox",
      Visibility = "8",
      {
        TextView,
        layout_width = "wrap",
        layout_height = "wrap",
        id = "msgBoxText",
        text = "x2倍速",
        layout_margin = "10dp",
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
        textSize = '16sp',
        textColor = ColorStyles().blue
      }
    }

  }

})

rateItem = {
  LinearLayout,
  orientation = "vertical",
  layout_width = "wrap",
  layout_height = "wrap_content",
  {
    TextView,
    textColor = "#ffffff",
    text = "x0.50",
    layout_margin = "15dp",
    -- layout_marginRight="0dp",
    textSize = "15dp",
    gravity = "center|right",
    layout_gravity = "center",
    layout_height = "wrap_content",
    layout_weight = "1",
    layout_width = "wrap_content",
    id = "rate",
    Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))
  }
}