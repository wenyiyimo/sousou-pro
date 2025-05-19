layout = loadlayout({
  LinearLayout,
  backgroundColor = "#ffffff",
  layout_width = "fill",
  layout_height = "fill",
  orientation = "vertical",
  id = "playView",
  {
    FrameLayout,
    layout_width = "fill",
    layout_height = "25%h",
    id = "frame",
    backgroundColor = ColorStyles().black,
    {
      VideoView,
      id = "videoPlayer",
      layout_width = "fill",
      layout_height = "fill",
      -- layout_weight=1,
      layout_gravity = "center"
    },


    --[[   {
      SurfaceView,
      id = "surfaceView",
      layout_width = "fill",
      layout_height = "fill",
      -- layout_weight=1,
      layout_gravity = "center"
    },]]
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
            ImageView,
            src = "static/img/play/dlna.png",
            id = "dlnaout",
            layout_width = "30dp",
            layout_height = "25dp",
            layout_marginRight = "10dp"
          },

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

body_layout = loadlayout({
  LinearLayout,
  layout_width = "fill",
  layout_height = "wrap",
  orientation = "vertical",
  id = "body",

  {
    LinearLayout,
    layout_width = "fill",
    layout_height = "wrap",
    orientation = "horizontal",
    id = "search_item",
    layout_margin = MarginStyles().medium,
    {
      LinearLayout,
      layout_width = "wrap",
      layout_height = "fill",
      orientation = "vertical",
      layout_weight = 1,
      {
        TextView,
        layout_width = "fill",
        layout_height = "wrap",
        id = "title",
        text = "标题",
        textColor = ColorStyles().black,
        layout_gravity = "left|top",
        layout_weight = 1,
        singleLine = true,
        ellipsize = "marquee",
        selected = true,
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
        -- Typeface = Typeface.DEFAULT_BOLD, -- 粗体
        textSize = '20sp'
      },
      {
        LinearLayout,
        layout_width = "fill",
        layout_height = "wrap",
        orientation = "horizontal",
        {
          CardView,
          radius = RadiusStyles().small,
          layout_width = "wrap",
          layout_height = "wrap",
          layout_gravity = "right|bottom",
          cardBackgroundColor = ColorStyles().green_light,
          cardElevation = 0,
          layout_marginRight = MarginStyles().small,
          {
            TextView,
            layout_width = "wrap",
            layout_height = "wrap",
            layout_margin = MarginStyles().tiny,
            layout_marginLeft = MarginStyles().small,
            layout_marginRight = MarginStyles().small,

            id = "picture",
            text = "picture：未播放",
            textColor = ColorStyles().white,
            layout_gravity = "left|bottom",
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
            textSize = TextSizes().medium
          }

        },
        {
          CardView,
          radius = RadiusStyles().small,
          layout_width = "wrap",
          layout_height = "wrap",
          layout_gravity = "right|bottom",
          cardBackgroundColor = ColorStyles().blue,
          cardElevation = 0,
          layout_marginRight = MarginStyles().small,
          {
            TextView,
            layout_width = "wrap",
            layout_height = "wrap",
            layout_margin = MarginStyles().tiny,
            layout_marginLeft = MarginStyles().small,
            layout_marginRight = MarginStyles().small,

            id = "info",
            text = "详情 >",
            textColor = ColorStyles().white,
            layout_gravity = "left|bottom",
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
            textSize = TextSizes().medium
          }

        }

      },
      {
        LinearLayout,
        layout_width = "fill",
        layout_height = "wrap",
        orientation = "horizontal",
        layout_weight = 1,
        layout_marginLeft = 0,

        {
          CardView,
          radius = RadiusStyles().small,
          layout_width = "wrap",
          layout_height = "wrap",
          layout_gravity = "right|bottom",
          cardBackgroundColor = ColorStyles().pink_dark,
          cardElevation = 0,

          layout_marginRight = MarginStyles().small,
          {
            TextView,
            layout_width = "wrap",
            layout_height = "wrap",
            layout_margin = MarginStyles().tiny,

            layout_marginLeft = MarginStyles().small,
            layout_marginRight = MarginStyles().small,
            singleLine = true,
            ellipsize = "marquee",
            selected = true,
            id = "heartout",
            text = "收藏",
            textColor = ColorStyles().white,
            layout_gravity = "left|bottom",
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
            textSize = TextSizes().medium
          }

        },

        {
          CardView,
          radius = RadiusStyles().small,
          layout_width = "wrap",
          layout_height = "wrap",
          layout_gravity = "left|bottom",
          cardBackgroundColor = ColorStyles().little_blue,
          cardElevation = 0,

          layout_marginRight = MarginStyles().small,
          {
            TextView,
            layout_width = "wrap",
            layout_height = "wrap",

            layout_margin = MarginStyles().tiny,
            layout_marginLeft = MarginStyles().small,
            layout_marginRight = MarginStyles().small,
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
            id = "hisout",
            singleLine = true,
            ellipsize = "marquee",
            selected = true,
            text = "历史：暂无",
            textColor = ColorStyles().white,
            layout_gravity = "left|bottom",
            -- Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
            textSize = TextSizes().medium
          }

        }

      },
      {
        LinearLayout,
        layout_width = "fill",
        layout_height = "wrap",
        orientation = "horizontal",
        layout_weight = 1,
        layout_marginLeft = 0,

        {
          CardView,
          radius = RadiusStyles().small,
          layout_width = "wrap",
          layout_height = "wrap",
          layout_gravity = "right|bottom",
          cardBackgroundColor = ColorStyles().blue,
          cardElevation = 0,
          layout_marginRight = MarginStyles().small,
          {
            TextView,
            layout_width = "wrap",
            layout_height = "wrap",
            layout_margin = MarginStyles().tiny,
            layout_marginLeft = MarginStyles().small,
            layout_marginRight = MarginStyles().small,

            id = "navdownloadout",
            text = "下载列表",
            textColor = ColorStyles().white,
            layout_gravity = "left|bottom",
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
            textSize = TextSizes().medium
          }

        },

        {
          CardView,
          radius = RadiusStyles().small,
          layout_width = "wrap",
          layout_height = "wrap",
          layout_gravity = "left|bottom",
          cardBackgroundColor = ColorStyles().pink_dark,
          cardElevation = 0,
          layout_marginRight = MarginStyles().small,
          {
            TextView,
            layout_width = "wrap",
            layout_height = "wrap",
            layout_margin = MarginStyles().tiny,
            layout_marginLeft = MarginStyles().small,
            layout_marginRight = MarginStyles().small,
            singleLine = true,
            ellipsize = "marquee",
            selected = true,
            id = "calendarout",
            text = "加入日程",
            textColor = ColorStyles().white,
            layout_gravity = "left|bottom",
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
            textSize = TextSizes().medium
          }

        },

        {
          CardView,
          radius = RadiusStyles().small,
          layout_width = "wrap",
          layout_height = "wrap",
          layout_gravity = "left|bottom",
          cardBackgroundColor = ColorStyles().green_light,
          cardElevation = 0,
          {
            TextView,
            layout_width = "wrap",
            layout_height = "wrap",
            layout_margin = MarginStyles().tiny,
            layout_marginLeft = MarginStyles().small,
            layout_marginRight = MarginStyles().small,
            singleLine = true,
            ellipsize = "marquee",
            selected = true,
            id = "navWebout",
            text = "浏览器",
            textColor = ColorStyles().white,
            layout_gravity = "left|bottom",
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
            textSize = TextSizes().medium
          }

        }


      }

    },
    {
      CardView,
      layout_width = "90dp",
      layout_height = "120dp",
      radius = RadiusStyles().big,
      {
        FrameLayout,
        layout_width = "fill",
        layout_height = "fill",
        {
          ImageView,
          layout_width = "fill",
          layout_height = "fill",
          id = "picout",
          scaleType = "centerCrop"
        },
        {
          CardView,
          Radius = RadiusStyles().small,
          cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色
          layout_gravity = "left|top", -- 重力居中
          {
            TextView, -- 文本框控件
            id = "siteName",
            singleLine = true,
            ellipsize = "marquee",
            selected = true,
            layout_margin = MarginStyles().tiny,
            textSize = TextStyles().small, -- 文本大小
            textColor = ColorStyles().white -- 文本颜色
          }
        },
        {
          CardView,
          Radius = RadiusStyles().small,
          cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色
          layout_gravity = "right|bottom", -- 重力居中
          {
            TextView, -- 文本框控件
            id = "state",
            singleLine = true,
            ellipsize = "marquee",
            selected = true,
            layout_margin = MarginStyles().tiny,
            textSize = TextStyles().small, -- 文本大小
            textColor = ColorStyles().white -- 文本颜色
          }
        }
      }

    }
  },
  {
    TextView, -- 文本框控件
    layout_width = 'fill',
    layout_height = '1dp',
    backgroundColor = ColorStyles().lighter
  },
  {

    RecyclerView,
    layout_height = "wrap",
    id = "siteout",
    padding = PaddingStyles().small,
    layout_width = "fill"

  },

  {
    TextView, -- 文本框控件
    layout_width = 'fill',
    layout_height = '1dp',
    backgroundColor = ColorStyles().lighter
  },
  {
    LinearLayout,
    -- layout_marginTop = MarginStyles().super_large,
    layout_marginTop = "8%h",
    layout_width = "80dp",
    layout_height = "80dp",
    id = "loading",
    orientation = "vertical",
    layout_gravity = "center",
    BackgroundDrawable = setProgress(ColorStrings().blue)
  },
  {
    LinearLayout,
    layout_width = 'fill',
    layout_height = 'fill',
    orientation = 'vertical',
    id = "drama",
    Visibility = "8",
    {
      LinearLayout,
      layout_width = 'fill',
      layout_height = 'wrap',
      orientation = 'horizontal',
      padding = PaddingStyles().small,
      {

        RecyclerView,
        layout_height = "wrap",
        id = "listout",
        layout_width = "fill",
        layout_weight = 1
      },
      {
        CardView,
        radius = RadiusStyles().small,
        layout_width = "wrap",
        layout_height = "wrap",
        layout_gravity = "left|center",
        cardBackgroundColor = ColorStyles().blue,
        cardElevation = 0,
        {
          TextView,
          layout_width = "wrap",
          layout_height = "wrap",
          layout_margin = MarginStyles().tiny,
          layout_marginLeft = MarginStyles().small,
          layout_marginRight = MarginStyles().small,

          id = "orderout",
          text = "排序",
          textColor = ColorStyles().white,
          layout_gravity = "left|center",
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
          textSize = TextSizes().big_little
        }
      },
      {
        CardView,
        radius = RadiusStyles().small,
        layout_width = "wrap",
        layout_marginLeft = MarginStyles().small,
        layout_height = "wrap",
        layout_gravity = "left|center",
        cardBackgroundColor = ColorStyles().blue,
        cardElevation = 0,
        {
          TextView,
          layout_width = "wrap",
          layout_height = "wrap",
          layout_margin = MarginStyles().tiny,
          layout_marginLeft = MarginStyles().small,
          layout_marginRight = MarginStyles().small,

          id = "downloadout",
          text = "下载",
          textColor = ColorStyles().white,
          layout_gravity = "left|center",
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
          textSize = TextSizes().big_little
        }
      }
    },
    {
      TextView, -- 文本框控件
      layout_width = 'fill',
      layout_height = '1dp',
      backgroundColor = ColorStyles().lighter
    },
    {
      RecyclerView,
      layout_height = "wrap",
      id = "bodyout",
      layout_width = "fill"
    }

  }
})

item = {
  LinearLayout,
  layout_width = "wrap",
  layout_height = "wrap",
  gravity = "center",
  orientation = "horizontal",
  {
    CardView,
    radius = RadiusStyles().small,
    layout_width = "wrap",
    layout_height = "wrap",
    -- cardBackgroundColor = ColorStyles().blue,
    cardElevation = 0,
    id = 'cardout',
    layout_marginRight = MarginStyles().medium,
    {
      TextView,
      layout_width = "wrap",
      layout_height = "wrap",
      layout_margin = MarginStyles().tiny,
      layout_marginLeft = MarginStyles().small,
      layout_marginRight = MarginStyles().small,
      id = "nameout",
      text = "",
      textColor = ColorStyles().black,
      layout_gravity = "left|center",
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
      textSize = TextSizes().big_little
    }

  }
}

body_item = {
  LinearLayout,
  layout_width = "fill",
  layout_height = "wrap",
  orientation = "horizontal",
  gravity = "center",
  {
    CardView,
    radius = RadiusStyles().small,
    layout_width = "fill",
    layout_height = "wrap",
    layout_gravity = "right|bottom",
    -- cardBackgroundColor = ColorStyles().blue,
    cardElevation = 0,
    id = 'cardout',
    layout_margin = MarginStyles().small,
    {
      TextView,
      layout_width = "fill",
      layout_height = "wrap",
      layout_margin = MarginStyles().small,
      layout_marginLeft = MarginStyles().medium,
      layout_marginRight = MarginStyles().medium,
      id = "nameout",
      layout_gravity = 'center',
      gravity = 'center',
      text = "",
      textColor = ColorStyles().black,
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt1.ttf")),
      textSize = '14dp',
      singleLine = true,
      ellipsize = "marquee",
      selected = true
    }

  }
}

webinfo = {
  CardView,
  -- orientation = "horizontal",
  layout_height = "fill",
  layout_width = "fill",
  radius = "15dp",
  {
    LuaWebView,
    layout_height = "match_parent",
    layout_width = "match_parent",
    id = "luaweb"

  }
}

rateItem = {
  LinearLayout,
  orientation = "vertical",
  layout_width = "wrap",
  layout_height = "wrap",
  {
    TextView,
    textColor = "#ffffff",
    text = "x0.50",
    layout_marginTop = "2.5%h",
    layout_marginBottom = "2.5%h",
    layout_marginRight="15dp",
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

dlnaItem = {
  LinearLayout,
  orientation = "vertical",
  layout_width = "fill",
  layout_height = "fill",
  id = "item",
  {
    CardView,
    layout_width = "fill",
    layout_height = "wrap",
    layout_marginLeft = '20dp', -- 布局边距
    layout_marginRight = '20dp', -- 布局边距
    layout_marginTop = '10dp', -- 布局边距
    layout_marginBottom = '10dp', -- 布局边距
    radius = "10dp",
    cardBackgroundColor = '#ffffffff',
    {
      TextView,
      text = 'name',
      id = 'nameout',
      textColor = ColorStyles().black,
      singleLine = true,
      ellipsize = "marquee",
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf")),
      selected = true,
      gravity = "center|center",
      layout_margin = '10dp' -- 布局边距
    }
  }
}
dlnaLayout = {
  LinearLayout,
  orientation = "vertical",
  layout_width = "fill",
  layout_height = "fill",
  backgroundColor = ColorStyles().light,
  padding = PaddingStyles().medium,
  {
    TextView,
    text = '设备列表',
    textColor = ColorStyles().black,
    singleLine = true,
    ellipsize = "marquee",
    selected = true,
    gravity = "center|center",
    Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf")),
    layout_margin = '10dp' -- 布局边距
  },
  {
    RecyclerView,
    layout_height = "fill",
    id = "dlnaBodyout",
    layout_width = "fill"
  }
}

calendarLayout = {
  LinearLayout,
  orientation = "vertical",
  layout_width = "fill",
  layout_height = "fill",
  backgroundColor = ColorStyles().light,
  padding = PaddingStyles().medium,
  {
    TextView,
    text = '日程',
    textColor = ColorStyles().black,
    singleLine = true,
    ellipsize = "marquee",
    selected = true,
    gravity = "center|center",
    Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf")),
    layout_margin = '10dp' -- 布局边距
  },
  {
    RecyclerView,
    layout_height = "fill",
    id = "calendarBodyout",
    layout_width = "fill"
  }
}

calendarItem = {
  LinearLayout,
  orientation = "vertical",
  layout_width = "fill",
  layout_height = "wrap",
  id = "item",
  {
    CardView,
    layout_width = "fill",
    layout_height = "wrap",
    layout_marginLeft = '20dp', -- 布局边距
    layout_marginRight = '20dp', -- 布局边距
    layout_marginTop = '10dp', -- 布局边距
    layout_marginBottom = '10dp', -- 布局边距
    radius = "10dp",
    cardBackgroundColor = '#ffffffff',
    {
      TextView,
      text = 'name',
      id = 'nameout',
      textColor = ColorStyles().black,
      singleLine = true,
      ellipsize = "marquee",
      Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf")),
      selected = true,
      gravity = "center|center",
      layout_margin = '10dp' -- 布局边距
    }
  }
}

downloadLayout = {
  CardView,
  -- orientation = "horizontal",
  layout_height = "fill",
  layout_width = "fill",
  radius = "15dp",
  {
    LinearLayout,
    layout_height = "fill",
    layout_width = "fill",
    orientation = "vertical",





    {
      LinearLayout,
      layout_width = "fill",
      orientation = "horizontal",
      gravity = "center",

      {
        CardView,
        layout_width = "wrap",
        layout_height = "wrap",
        layout_marginLeft = '20dp', -- 布局边距
        layout_marginRight = '20dp', -- 布局边距
        layout_marginTop = '10dp', -- 布局边距
        layout_marginBottom = '10dp', -- 布局边距
        radius = "10dp",
        cardBackgroundColor = ColorStyles().blue,
        layout_weight = 1,
        id = "selectAll",
        {
          TextView,
          text = '全选',
          textColor = ColorStyles().white,
          singleLine = true,
          ellipsize = "marquee",
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf")),
          selected = true,
          layout_width = "fill",

          gravity = "center|center",
          layout_margin = '10dp' -- 布局边距
        }
      },

      {
        CardView,
        layout_width = "wrap",
        layout_height = "wrap",
        layout_marginLeft = '20dp', -- 布局边距
        layout_marginRight = '20dp', -- 布局边距
        layout_marginTop = '10dp', -- 布局边距
        layout_marginBottom = '10dp', -- 布局边距
        radius = "10dp",
        cardBackgroundColor = ColorStyles().blue,
        layout_weight = 1,
        id = "selectAllReverse",
        {
          TextView,
          text = '反选',

          textColor = ColorStyles().white,
          singleLine = true,
          ellipsize = "marquee",
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf")),
          selected = true,
          layout_width = "fill",
          gravity = "center|center",
          layout_margin = '10dp' -- 布局边距
        }
      },

      {
        CardView,
        layout_width = "wrap",
        layout_height = "wrap",
        layout_marginLeft = '20dp', -- 布局边距
        layout_marginRight = '20dp', -- 布局边距
        layout_marginTop = '10dp', -- 布局边距
        layout_marginBottom = '10dp', -- 布局边距
        radius = "10dp",
        cardBackgroundColor = ColorStyles().blue,
        layout_weight = 1,
        id = 'selectCancel',
        {
          TextView,
          text = '取消',

          textColor = ColorStyles().white,
          singleLine = true,
          ellipsize = "marquee",
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf")),
          selected = true,
          layout_width = "fill",
          gravity = "center|center",
          layout_margin = '10dp' -- 布局边距
        }
      },

      {
        CardView,
        layout_width = "wrap",
        layout_height = "wrap",
        layout_marginLeft = '20dp', -- 布局边距
        layout_marginRight = '20dp', -- 布局边距
        layout_marginTop = '10dp', -- 布局边距
        layout_marginBottom = '10dp', -- 布局边距
        radius = "10dp",
        layout_weight = 1,
        cardBackgroundColor = ColorStyles().blue,
        id = 'selectSure',
        {
          TextView,
          text = '确定',

          textColor = ColorStyles().white,
          singleLine = true,
          ellipsize = "marquee",
          Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf")),
          selected = true,
          layout_width = "fill",
          gravity = "center|center",
          layout_margin = '10dp' -- 布局边距
        }
      }
    },
    {
      RecyclerView,
      layout_height = "wrap",
      id = "downList",
      layout_width = "fill"
    },



  }

}



webxtinfo = {
  CardView,
  -- orientation = "horizontal",
  layout_height = "fill",
  layout_width = "fill",
  radius = "15dp",
  {
    FrameLayout,
    layout_height = "fill",
    layout_width = "fill",
    BackgroundColor = ColorStyles().white,

    {
      LuaWebView,
      layout_height = "fill",
      layout_width = "fill",
      id = "luaxtweb"

    },
    {

      CardView,
      -- orientation = "horizontal",
      layout_height = "wrap",
      layout_width = "wrap",
      radius = "15dp",
      cardBackgroundColor = ColorStyles().blue,
      gravity = "center|center",
      layout_gravity = "bottom|center",
      {
        TextView,
        text = '0',

        textColor = ColorStyles().white,
        singleLine = true,
        ellipsize = "marquee",
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/zt2.ttf")),
        selected = true,
        layout_width = "wrap",
        gravity = "center|center",
        layout_margin = '10dp' -- 布局边距
      }
    }
  }
}