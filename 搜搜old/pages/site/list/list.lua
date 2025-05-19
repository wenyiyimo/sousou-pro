require("import");
import("common.BaseActivity");
import("pages.site.list.layout");
activity.setContentView(layout);

local siteIndex,flag= ...

local sites = siteUtil.getSites()

bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))

adapter = LuaCustRecyclerAdapter(AdapterCreator({

  getItemCount = function()
    return #sites[siteIndex].SITE
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
    -- print(data[position+1][1])
    view = holder.view.getTag()
    view.title.text = sites[siteIndex].SITE[position + 1].name
    if sites[siteIndex].SITE[position + 1].type then
      view.type.text = sites[siteIndex].SITE[position + 1].type
     else
      view.type.text = "html"
    end

    view.classSwitch.checked = sites[siteIndex].SITE[position + 1].isClass
    view.searchSwitch.checked = sites[siteIndex].SITE[position + 1].isSearch

    view.classSwitch.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xff227CEA, PorterDuff.Mode.SRC_ATOP))
    view.classSwitch.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xff227CEA, PorterDuff.Mode.SRC_ATOP))
    view.searchSwitch.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xff227CEA, PorterDuff.Mode.SRC_ATOP))
    view.searchSwitch.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xff227CEA, PorterDuff.Mode.SRC_ATOP))
    --  view.classSwitch.setOnCheckedChangeListener({
    -- onCheckedChanged = function(buttonView, isChecked)
    --  sites[siteIndex].SITE[position + 1].isClass = isChecked
    -- siteUtil.setSites(sites)
    -- end
    -- })
    view.classSwitch.onClick=function()
      if flag then
        sites[siteIndex].SITE[position + 1].isClass = not sites[siteIndex].SITE[position + 1].isClass
        siteUtil.setSites(sites)
       else

        showToast("订阅源不支持编辑！")
      end
    end
    view.searchSwitch.onClick=function()
      if flag then
        sites[siteIndex].SITE[position + 1].isSearch = not sites[siteIndex].SITE[position + 1].isSearch
        siteUtil.setSites(sites)
       else
        showToast("订阅源不支持编辑！")

      end
    end

    -- view.searchSwitch.setOnCheckedChangeListener({
    --onCheckedChanged = function(buttonView, isChecked)
    -- sites[siteIndex].SITE[position + 1].isSearch = isChecked
    -- siteUtil.setSites(sites)
    -- end
    --})
    view.title.onClick = function()
      -- activity.finish()--关闭当前页面
      if flag then activity.newActivity("pages/site/edit/edit", {siteIndex, position + 1, sites[siteIndex].SITE[position + 1].type})
       else
        showToast("订阅源不支持编辑！")
      end


    end

    view.setTop.onClick = function()
      if flag then
        table.insert(sites[siteIndex].SITE, 1, table.remove(sites[siteIndex].SITE, position + 1))
        siteUtil.setSites(sites)
        adapter.notifyDataSetChanged()

       else
        showToast("订阅源不支持编辑！")
      end

    end
    view.setBottom.onClick = function()
      if flag then
        table.insert(sites[siteIndex].SITE, table.remove(sites[siteIndex].SITE, position + 1))
        siteUtil.setSites(sites)
        adapter.notifyDataSetChanged()
       else
        showToast("订阅源不支持编辑！")
      end
    end
    view.share.onClick = function()
      local temp={}
      temp.type="SITE"
      temp.datas={}
      table.insert(temp.datas,sites[siteIndex].SITE[position + 1])
      File("/sdcard/搜搜/share/").mkdirs()

      local fileName="/sdcard/搜搜/share/"..sites[siteIndex].SITE[position + 1].name.."_"..tostring(os.time())..".sousou"
      io.open(fileName, "w"):write(cjson.encode(temp)):close()
     -- showToast("已导出至"..fileName.."!")
      systemUtil.copyContent(fileName,false)
      systemUtil.shareFile(fileName)
      --[[local tipout={

        LinearLayout;
        background="#ffffffff";
        layout_height="fill";
        orientation="vertical";
        layout_width="fill";
        gravity='center',
        {
          TextView,--文本框控件
          textSize="16dp",
          text="请选择操作",--文本内容
          layout_width='fill',
          layout_height='wrap',
          layout_margin='15dp',--布局边距
          textColor="#227CEA";
          --Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/static/font.ttf"));
        },
        {
          LinearLayout,--线性布局
          layout_width='fill',
          layout_height='wrap',
          orientation='horizontal',
          gravity='right',
          -- layout_margin='15dp',--布局边距
          {
            TextView,--文本框控件;
            text='导出',--文本内容
            textSize="16dp",
            layout_margin='15dp',--布局边距
            textColor="#227CEA";
            onClick=function ()
              local temp={}
              temp.type="SITE"
              temp.datas={}
              table.insert(temp.datas,sites[siteIndex].SITE[position + 1])
              File("/sdcard/搜搜/share/").mkdirs()

              local fileName="/sdcard/搜搜/share/"..sites[siteIndex].SITE[position + 1].name.."_"..tostring(os.time())..".sousou"
              io.open(fileName, "w"):write(cjson.encode(temp)):close()
              showToast("已导出至"..fileName.."!")
              systemUtil.copyContent(fileName,false)
              dialogsiteplay.dismiss()
            end
          },
          {
            TextView,--文本框控件
            text='复制',--文本内容
            textSize="16dp",
            textColor="#227CEA";
            layout_margin='15dp',--布局边距
            onClick=function ()
              systemUtil.copyContent(cjson.encode(sites[siteIndex].SITE[position + 1]))
              dialogsiteplay.dismiss()
            end
          },
          {
            TextView,--文本框控件;
            text='取消',--文本内容
            textSize="16dp",
            layout_margin='15dp',--布局边距
            textColor="#227CEA";
            onClick=function ()
              dialogsiteplay.dismiss()
            end
          },

        }

      }
      dialogsiteplay=Dialog(activity)

      --设置弹窗布局
      dialogsiteplay.setContentView(loadlayout(tipout))
      --设置弹窗位置

      dialogsiteplay.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
      --设置触摸弹窗外部隐藏弹窗

      dialogsiteplay.setCanceledOnTouchOutside(true);
      local p=dialogsiteplay.getWindow().getAttributes()
      p.dimAmount=0
      p.width=activity.width*0.8

      --p.height=activity.Height*0.74;
      dialogsiteplay.getWindow().setAttributes(p);
      --dialog.getWindow().getDecorView().setPadding(0,0,0,0)

      dialogsiteplay.show()

]]






    end
    view.delete.onClick = function()
      if flag then
        dialog = AlertDialog.Builder(this).setTitle("确定删除该站源吗？").setPositiveButton("确定", {
          onClick = function(v)
            table.remove(sites[siteIndex].SITE, position + 1)
            siteUtil.setSites(sites)
            adapter.notifyDataSetChanged()
            showToast("站源删除成功！")
          end
        }).setNegativeButton("取消", nil).show()
        dialog.create()
        -- 更改Button颜色
        import "android.graphics.Color"
        dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff227CEA)
        dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff227CEA)
        dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff227CEA)

       else
        showToast("订阅源不支持编辑！")
      end

    end
  end
}))

-- RecyclerView绑定适配器
bodyout.setAdapter(adapter)
if not flag
  popaddsite.setVisibility(View.GONE)
end



popaddsite.onClick = function()
  pop = PopupWindow(activity)
  pop.setContentView(loadlayout(popMenuout))
  -- pop.setWidth(width / 3)
  pop.setWidth(-2)
  pop.setHeight(-2)
  pop.setOutsideTouchable(true)
  pop.setBackgroundDrawable(ColorDrawable(0))
  function pop.onDismiss()

  end
  writeHtml.onClick = function()
    -- activity.finish()--关闭当前页面
    activity.newActivity("pages/site/edit/edit", {siteIndex, #sites[siteIndex].SITE + 1, "html"})
  end
  writeCms.onClick = function()
    -- activity.finish()--关闭当前页面
    activity.newActivity("pages/site/edit/edit", {siteIndex, #sites[siteIndex].SITE + 1, "cms"})
  end

  writeMiru.onClick = function()
    -- activity.finish()--关闭当前页面
    activity.newActivity("pages/site/edit/edit", {siteIndex, #sites[siteIndex].SITE + 1, "miru"})
  end

  exportSite.onClick=function()
    systemUtil.copyContent(cjson.encode(siteUtil.getSites()[siteIndex]))
  end

  importSite.onClick = function()
    dialog =
    AlertDialog.Builder(this).setTitle("导入站源").setView(loadlayout(addsiteitem)) -- .setMessage("消息")
    .setPositiveButton("添加", {
      onClick = function(v)
        if sitetext.Text == "" then
          return
         elseif startswith(sitetext.Text, "{") and endswith(sitetext.Text, "}") then
          local jsondata = cjson.decode(sitetext.Text)
          local copydata=jsondata
          if jsondata.name then
            local flag = true
            for k, v in pairs(sites[siteIndex].SITE) do
              if v.name == jsondata.name then
                flag = false
                break
              end
            end
            if flag then
              table.insert(sites[siteIndex].SITE, jsondata)
              siteUtil.setSites(sites)
              adapter.notifyDataSetChanged()
              showToast("站源添加成功！")
             else
              showToast("站源名称已存在！")
            end

           elseif copydata.URL and copydata.URL=="自定义数据" and copydata.SITE then


            local siteIndex=siteUtil.getMySiteIndex()
            for k,v in pairs(copydata.SITE)do
              if v.name and #v.name>=2 then

                local flag = true
                for m, n in pairs(sites[siteIndex].SITE) do
                  if v.name == n.name then
                    flag = false
                    break
                  end
                end
                if flag then
                  table.insert(sites[siteIndex].SITE,v)
                  siteUtil.setSites(sites)
                end
              end
            end
            showToast("站源添加成功！")

           else
            showToast("数据格式错误！")
          end
         else
          showToast("数据格式错误！")
        end
      end
    }) --  .setNeutralButton("取消",nil)
    .setNegativeButton("取消", nil).show()
    dialog.create()

    -- 更改Button颜色
    import "android.graphics.Color"
    dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(0xff227CEA)
    dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(0xff227CEA)
    dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(0xff227CEA)

    -- 更改Title颜色
    import "android.text.SpannableString"
    import "android.text.style.ForegroundColorSpan"
    import "android.text.Spannable"
    sp = SpannableString("导入站源")
    sp.setSpan(ForegroundColorSpan(0xff227CEA), 0, #sp, Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
    dialog.setTitle(sp)
  end
  pop.showAsDropDown(popaddsite)

end


function onStart()
  sites = siteUtil.getSites()

  adapter.notifyDataSetChanged()

end
