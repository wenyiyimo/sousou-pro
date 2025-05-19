require("import");
import("common.BaseActivity");
import "pages.heart.layout"
import "utils.HeartUtil"
import "android.text.Html"
activity.setContentView(layout);
heartUtil = HeartUtil()
hearts = heartUtil.getHearts()

bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))

adapter = LuaCustRecyclerAdapter(AdapterCreator({

    getItemCount = function()
        return #hearts
    end,

    getItemViewType = function(position)
        return 0
    end,

    onCreateViewHolder = function(parent, viewType)
        local views = {}
        holder = LuaCustRecyclerHolder(loadlayout(itemout, views))
        holder.view.setTag(views)
        return holder
    end,
    onBindViewHolder = function(holder, position)
        -- print(hearts[position+1][1])
        view = holder.view.getTag()
        view.nameout.text = "来源：" .. hearts[position + 1][1].name
        view.titleout.text = Html.fromHtml(hearts[position + 1][2]['标题'])
        view.stateout.text = "状态：" .. hearts[position + 1][2]['状态']
        local url = hearts[position + 1][2]['图片']

        glideImg(view.picout, url)

        -- 子项目点击事件

        -- 为Item设置点击事件
        view.singleItem.onClick = function()
            -- setting.saveString("search", cjson.encode(bodyhearts))
            -- getSameTitle(hearts[position + 1]["标题"],hearts[position + 1]["地址"])
            activity.newActivity("pages/play/play", {hearts[position + 1]})
        end;
        view.singleItem.onLongClick = function()

            dialog = AlertDialog.Builder(this) -- .setTitle("提示")
            .setMessage("你想对此条收藏记录？").setPositiveButton("删除", {
                onClick = function(v)
                    hearts = heartUtil.removeHeart(hearts[position + 1])
                    adapter.notifyDataSetChanged()
                end
            }).setNeutralButton("置顶", {
                onClick = function(v)
                    hearts = heartUtil.setTopHeart(hearts[position + 1])
                    adapter.notifyDataSetChanged()
                end
            }).setNegativeButton("取消", nil).show()
            dialog.create()

            -- 更改Button颜色
            import "android.graphics.Color"
            dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(ColorStyles().blue)
            dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(ColorStyles().blue)
            dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(ColorStyles().blue)
        end
    end
}))

-- RecyclerView绑定适配器
bodyout.setAdapter(adapter)

clearout.onClick = function()
    dialog = AlertDialog.Builder(this) -- .setTitle("提示")
    .setMessage("确定清空所有收藏记录吗？").setPositiveButton("确定", {
        onClick = function(v)
            hearts = heartUtil.clearHearts()
            adapter.notifyDataSetChanged()
        end
    }) --  .setNeutralButton("取消",nil)
    .setNegativeButton("取消", nil).show()
    dialog.create()

    -- 更改Button颜色
    import "android.graphics.Color"
    dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(ColorStyles().blue)
    dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(ColorStyles().blue)
    dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(ColorStyles().blue)

end

function onResume()
    hearts = heartUtil.getHearts()
    adapter.notifyDataSetChanged()
end
