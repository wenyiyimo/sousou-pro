require "import"
-- 导入函数库

import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.view.View$OnFocusChangeListener"
import "android.content.Context"
import "android.graphics.Typeface"
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
import "android.graphics.Color"
import "android.graphics.drawable.ColorDrawable"
import "android.view.GestureDetector"
import "android.net.Uri"
import "android.text.Html"

import "androidx.viewpager.widget.ViewPager"
import "androidx.viewpager.widget.PagerAdapter"
import "androidx.viewpager2.widget.ViewPager2"

import "androidx.recyclerview.widget.StaggeredGridLayoutManager"
import "androidx.recyclerview.widget.RecyclerView"
import "androidx.recyclerview.widget.LinearLayoutManager"
import "androidx.cardview.widget.CardView"
import "androidx.cardview.widget.CardView"

import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.button.MaterialButton"

import "com.lua.custrecycleradapter.LuaCustRecyclerAdapter"
import "com.lua.custrecycleradapter.LuaCustRecyclerHolder"
import "com.lua.custrecycleradapter.AdapterCreator"
import "com.bywx.adapter.BasePagerAdapter"
--import "com.dingyi.adapter.LuaRecyclerAdapter"

import "com.bumptech.glide.Glide"
import "java.io.File"
import "cjson"
import "com.sousou.R"

import "utils.util"
import "utils.FlashUtil"
import "utils.HttpUtil"
import "common.ThemeStyles"
import "utils.SimpleDataStore"
import "utils.SystemUtil"
import "utils.SiteUtil"
import "utils.DataUtil"
import "utils.FileUtil"
import"utils.LuaRecyclerAdapter"
import "utils.Threading"
import "utils.SettingUtil"


systemUtil = SystemUtil()
--systemUtil.hideTitleBar()
--systemUtil.setStatusBarColor(ColorStyles().white)
--systemUtil.setStatusBarDark()
--systemUtil.hideNavigationBar()

width = activity.width
height = activity.height

isMobile = systemUtil.judgeMobile(width,height)



siteUtil = SiteUtil()
httpUtil = HttpUtil()
reUtil = ReUtil()
cmsUtil = CmsUtil()
dataUtil = DataUtil()
settingUtil=SettingUtil()
setting=settingUtil.getSetting()


--[=[function TextView()
  return luajava.bindClass("android.widget.TextView")()
  .setTextColor(0xff888888)
end
function EditText()
  return luajava.bindClass("android.widget.EditText")()
  .setTextColor(0xff555555)
end]=]