layout = loadlayout({
    LinearLayout,
    layout_width = "fill",
    orientation = "vertical",
    backgroundColor = ColorStyles().white,

    {
        LinearLayout,
        layout_width = "fill",
        layout_height = ButtonStyles().height_large,
        gravity = "center",
        {
            TextView,
            id = "qiyi_title",
            text = "影视排行榜-iQIYI",
            textSize = TextStyles().large_little,
            gravity = "center",
            layout_weight = "1",
            textColor = ColorStyles().blue,
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))
        }
    },

    {
        LinearLayout,
        orientation = "horizontal",
        layout_height = ButtonStyles().height_big,
        layout_width = "fill",
        elevation = ElevationStyles().tiny,
        {
            Button,
            layout_height = ButtonStyles().height_big_little,
            layout_weight = 1,
            id = "qiyi_top1",
            background = "",
            text = "总榜",
            textSize = TextStyles().medium,
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))

        },
        {
            Button,
            layout_height = ButtonStyles().height_big_little,
            layout_weight = 1,
            id = "qiyi_top2",
            background = "",
            text = "剧集",
            textSize = TextStyles().medium,
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))

        },
        {
            Button,
            layout_height = ButtonStyles().height_big_little,
            layout_weight = 1,
            id = "qiyi_top3",
            background = "",
            text = "电影",
            textSize = TextStyles().medium,
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))

        },

        {
            Button,
            layout_height = ButtonStyles().height_big_little,
            layout_weight = 1,
            id = "qiyi_top4",
            background = "",
            text = "动漫",
            textSize = TextStyles().medium,
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))

        },
        {
            Button,
            layout_height = ButtonStyles().height_big_little,
            layout_weight = 1,
            id = "qiyi_top5",
            background = "",
            text = "综艺",
            textSize = TextStyles().medium,
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))

        },
        {
            Button,
            layout_height = ButtonStyles().height_big_little,
            layout_weight = 1,
            id = "qiyi_top6",
            background = "",
            text = "飙升",
            textSize = TextStyles().medium,
            Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf"))

        }
    },
    {
        LinearLayout,

        layout_width = "match_parent",
        layout_height = "4dp",
        backgroundColor = "0xFFffffff",
        {
            CardView,
            id = "qiyi_scrollbar",
            layout_width = "14%w",
            backgroundColor = ColorStyles().blue,
            layout_marginLeft = "3%w",
            layout_height = "match_parent"
        }
    },
    {
        LinearLayout,
        layout_width = "fill",
        layout_height = "1dp",
        layout_marginTop = "0dp",
        backgroundColor = ColorStyles().light
    },
    {
        ViewPager,
        id = "qiyi_page",
        layout_width = "fill",
        layout_height = "fill"
    }
})

function base_qiyi_out(name)
    return {
        LinearLayout,
        orientation = "vertical",
        layout_width = "fill",
        layout_height = "fill",
        {
            RecyclerView,
            layout_width = "fill",
            layout_height = "fill",
            id = name
        }
    }
end
top_hitem_out = {
    LinearLayout,
    orientation = "horizontal",
    layout_width = "fill",
    layout_height = "120dp",
    -- BackgroundColor = 布局背景,
    id = "item",
    {
        CardView,
        layout_width = "200dp",
        layout_height = 'fill',
        layout_gravity = "center",
        layout_margin = "7dp",
        cardElevation = "0dp",
        radius = "5dp",
        {
            ImageView,
            id = "picout",
            layout_width = "fill",
            layout_height = "fill",
            scaleType = "centerCrop"
        },
        {
            CardView,
            layout_gravity = "top|left",
            layout_width = "22dp",
            layout_height = "15dp",
            radius = "2dp",
            id = "sortcolor",
            {
                TextView,
                id = "hotout",
                gravity = "center",
                layout_width = "fill",
                layout_height = "fill",
                textColor = "#ffffffff",
                text = "1",
                textSize = "11dp"
            }
        },
        {
            TextView,
            id = "stateout",
            layout_margin = "5dp",
            layout_gravity = "right|bottom",
            text = "未知",
            textSize = "10sp",
            Typeface = Typeface.DEFAULT_BOLD,
            textColor = "#ffffff"
        }
    },
    {
        LinearLayout,
        orientation = "vertical",
        layout_gravity = "center",
        layout_width = "fill",
        layout_margin = "7dp",
        layout_height = "fill",

        {
            TextView,
            text = "影片名",
            id = "titleout",
            textSize = "14dp",
            textColor = 0xff000000,
            Typeface = Typeface.DEFAULT_BOLD,
            ellipsize = "end",
            singleLine = true,
            layout_weight = "1"
        },

        {
            TextView,
            id = "subtitleout",
            text = "",
            layout_weight = "1",
            textSize = "12dp",
            -- textColor = 专辑未选中颜色,
            Typeface = Typeface.DEFAULT_BOLD
        },
        {
            TextView,
            id = "hotnumout",
            layout_weight = "1",
            text = "热度:未知",
            textSize = "12dp",
            textColor = "0xFFFF99D3",
            layout_marginTop = "3dp",
            Typeface = Typeface.DEFAULT_BOLD,
            ellipsize = "end",
            singleLine = true
        }

    }
}
top_item_out = {
    LinearLayout,
    orientation = "horizontal",
    layout_width = "fill",
    layout_height = "14%h",
    -- BackgroundColor = 布局背景,
    id = "item",
    {
        CardView,
        layout_width = "38%w",
        layout_height = "11%h",
        layout_gravity = "center",
        layout_marginLeft = "7dp",
        cardElevation = "0dp",
        radius = "5dp",
        {
            ImageView,
            id = "picout",
            layout_width = "fill",
            layout_height = "fill",
            scaleType = "centerCrop"
        },
        {
            CardView,
            layout_gravity = "top|left",
            layout_width = "22dp",
            layout_height = "15dp",
            radius = "2dp",
            id = "sortcolor",
            {
                TextView,
                id = "hotout",
                gravity = "center",
                layout_width = "fill",
                layout_height = "fill",
                textColor = "#ffffffff",
                text = "1",
                textSize = "11dp"
            }
        },
        {
            TextView,
            id = "stateout",
            layout_margin = "5dp",
            layout_gravity = "right|bottom",
            text = "未知",
            textSize = "10sp",
            Typeface = Typeface.DEFAULT_BOLD,
            textColor = "#ffffff"
        }
    },
    {
        LinearLayout,
        orientation = "vertical",
        layout_gravity = "center",
        layout_width = "fill",
        layout_marginLeft = "7dp",
        layout_marginRight = "8dp",
        layout_height = "11%h",
        {
            LinearLayout,
            orientation = "horizontal",
            layout_width = "fill",
            layout_height = "4%h",
            {
                TextView,
                text = "影片名",
                id = "titleout",
                textSize = "12.5dp",
                textColor = 0xff000000,
                Typeface = Typeface.DEFAULT_BOLD,
                ellipsize = "end",
                singleLine = true,
                layout_weight = "1"
            }
        },
        {
            LinearLayout,
            orientation = "vertical",
            layout_width = "fill",
            layout_height = "-1",
            {
                TextView,
                id = "subtitleout",
                text = "",
                layout_weight = "1",
                textSize = "11dp",
                -- textColor = 专辑未选中颜色,
                Typeface = Typeface.DEFAULT_BOLD
            },
            {
                TextView,
                id = "hotnumout",
                layout_weight = "1",
                text = "热度:未知",
                textSize = "11dp",
                textColor = "0xFFFF99D3",
                layout_marginTop = "3dp",
                Typeface = Typeface.DEFAULT_BOLD,
                ellipsize = "end",
                singleLine = true
            }
        }
    }
}
