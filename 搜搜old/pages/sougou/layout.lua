layout = {
    LinearLayout,
    layout_height = "fill",
    layout_width = "fill",
    backgroundColor = "#ffffff",
    orientation = 'vertical',

    {
        LinearLayout,
        orientation = "horizontal",
        layout_height = "wrap",
        layout_width = "fill",
        -- gravity="right";
        layout_gravity = "left|center",
        layout_marginLeft = '10dp', -- 布局左距

        {
            HorizontalListView,
            layout_height = "36dp",
            layout_width = "fill",
            layout_weight = '1',
            HorizontalScrollBarEnabled = false,
            id = "taglist"

        },
        {
            ImageView,
            layout_marginRight = "10dp",
            layout_width = "25dp",
            src = "static/img/class/menu.png",
            layout_height = "25dp",
            id = 'control', -- 控件ID
            layout_gravity = "left|center"
        }
    },
    {
        HorizontalListView,
        layout_height = "36dp",
        layout_width = "match_parent",
        HorizontalScrollBarEnabled = false,
        id = "stylelist",
        layout_marginLeft = '10dp', -- 布局左距
        layout_marginRight = '10dp' -- 布局右距
    },
    {
        HorizontalListView,
        layout_height = "36dp",
        layout_width = "match_parent",
        HorizontalScrollBarEnabled = false,

        id = "zonelist",
        layout_marginLeft = '10dp', -- 布局左距
        layout_marginRight = '10dp' -- 布局右距
    },
    {
        HorizontalListView,
        layout_height = "36dp",
        layout_width = "match_parent",
        HorizontalScrollBarEnabled = false,
        id = "yearlist",
        layout_marginLeft = '10dp', -- 布局左距
        layout_marginRight = '10dp' -- 布局右距
    },
    {
        HorizontalListView,
        layout_height = "36dp",
        layout_width = "match_parent",
        HorizontalScrollBarEnabled = false,
        id = "orderlist",
        layout_marginLeft = '10dp', -- 布局左距
        layout_marginRight = '10dp' -- 布局右距
    },
    {
        TextView, -- 文本框控件
        layout_height = '1dp',
        layout_width = 'fill',
        backgroundColor = 0x18000000

    },
    {
        RecyclerView,
        layout_width = "fill",
        layout_height = "fill",
        id = "bodyout"
    }

}
itemout = {
    LinearLayout,
    orientation = "vertical",
    layout_width = "fill",
    layout_height = "wrap",
    gravity = 'left',
    background = '#ffffffff',
    gravity = "center",
    id = "single",
    {
        LinearLayout,
        orientation = "horizontal",
        layout_width = "fill",
        layout_height = "100dp",
        -- BackgroundColor = 布局背景,
        layout_marginTop = '10dp', -- 布局顶距='15dp',--布局底距
        layout_marginBottom = '5dp', -- 布局底距
        {
            CardView,
            layout_width = "70dp",
            layout_height = "fill",

            layout_marginLeft = "7dp",
            cardElevation = "0dp",
            radius = "5dp",
            {
                ImageView,
                id = "picout",
                layout_width = "fill",
                layout_height = "fill",
                scaleType = "centerCrop"
            }

        },
        {
            LinearLayout,
            orientation = "vertical",
            layout_gravity = "center",
            layout_width = "fill",
            layout_marginLeft = "15dp",
            layout_marginRight = "5dp",
            layout_height = "fill",
            -- layout_marginTop='3dp',--布局顶距
            {
                TextView,
                text = "影片名",
                id = "titleout",
                textSize = "14dp",
                textColor = 0xff000000,
                Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf")),

                ellipsize = "end",
                singleLine = true,
                layout_weight = "1"

            },

            {
                TextView,
                id = "director",
                text = "导演：未知",
                layout_weight = "1",
                textSize = "12dp",
                -- textColor = 专辑未选中颜色,
                Typeface = Typeface.DEFAULT_BOLD,
                ellipsize = "end",
                singleLine = true
            },
            {
                TextView,
                id = "starring",
                layout_weight = "1",
                text = "演员：未知",
                textSize = "12dp",
                -- textColor = "0xFFFF99D3",
                layout_marginTop = "3dp",
                Typeface = Typeface.DEFAULT_BOLD,
                ellipsize = "end",
                singleLine = true
            },
            {
                TextView,
                id = "score",
                -- layout_weight = "1",
                text = "评分：暂无",
                textSize = "12dp",
                -- textColor = "0xFFFF99D3",
                layout_marginTop = "3dp",
                Typeface = Typeface.DEFAULT_BOLD,
                ellipsize = "end",
                singleLine = true

            }
        }
    }
}
itemlist = {
    LinearLayout,
    orientation = "vertical",
    layout_width = "fill",
    layout_height = 'wrap',
    gravity = "center",
    id = "single",
    {
        CardView,
        layout_width = "100dp",
        layout_height = "wrap",
        layout_margin = "5dp",
        cardElevation = "1dp",
        radius = "5dp",

        {
            FrameLayout,
            layout_width = "fill",
            layout_height = "130dp",
            {
                ImageView,
                id = "picout",
                layout_width = "fill",
                layout_height = "130dp",
                scaleType = "centerCrop"
            },
            {
                CardView,
                Radius = RadiusStyles().small,
                layout_gravity = "left|bottom", -- 重力居中
                cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色

                {
                    TextView, -- 文本框控件

                    id = "stateout",
                    layout_margin = MarginStyles().tiny,
                    singleLine = true,
                    ellipsize = "marquee",
                    selected = true,
                    textSize = TextStyles().small, -- 文本大小
                    textColor = ColorStyles().white -- 文本颜色

                }
            },
            {
                CardView,
                Radius = RadiusStyles().small,
                cardBackgroundColor = ColorStyles().little_blue, -- 背景颜色
                layout_gravity = "right|top", -- 重力居中
                {
                    TextView, -- 文本框控件

                    id = "score",
                    singleLine = true,
                    ellipsize = "marquee",
                    selected = true,
                    layout_margin = MarginStyles().tiny,
                    textSize = TextStyles().small, -- 文本大小
                    textColor = ColorStyles().white -- 文本颜色

                }
            }
        }

    },
    {
        TextView,
        id = "titleout",
        layout_margin = "5dp",
        text = "影片名",
        textSize = "12dp",
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf")),

        singleLine = true,
        ellipsize = "end"
    }

}

itemc = {
    LinearLayout,
    Orientation = "vertical",
    layout_width = "wrap",
    layout_height = "fill",
    Gravity = "center",
    backgroundColor = 0xffffffff,
    {
        CardView,
        id = "card",
        Elevation = "0dp",
        layout_width = "wrap",
        layout_height = "wrap",
        radius = "12dp",
        layout_margin = "5dp",
        -- CardBackgroundColor = 0xffffffff,
        {
            TextView,
            id = "text",
            layout_marginLeft = "8dp",
            layout_marginRight = "8dp",
            Gravity = "center",
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf")),
            -- textColor = 0xC9000000,
            -- Typeface = L0_0.Typeface.defaultFromStyle(L0_0.Typeface.BOLD),
            layout_margin = "3.5dp",
            textSize = "12dp"
        }
    }
}
