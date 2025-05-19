require("import");
import("common.BaseActivity");
import("pages.search.SearchUtil");
import("pages.search.home.homeout");
activity.setContentView(homeout);
local searchUtil = SearchUtil(setting,settingUtil);
local searchhistory = searchUtil.searchHistory;

function sethistoryitem(key, value)
  return {
    LinearLayout,
    orientation = "vertical",
    layout_width = "fill",
    layout_height = "wrap",
    {
      LinearLayout,
      layout_width = "match_parent",
      orientation = "horizontal",
      layout_height = "wrap",
      {
        ImageView,
        layout_gravity = "left|center",
        layout_height = "20dp",
        src = "static/img/search/search.png",
        layout_margin = "10dp",
        layout_width = "21dp",
        colorFilter = "#757575"
      },
      {
        TextView,
        ellipsize = "marquee",
        singleLine = true,
        selected = true,
        layout_margin = "10dp",
        layout_marginLeft = "0dp",
        textSize = "13dp",
        text = value,
        layout_weight = 1,
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf")),
        onClick = function()
          searchtext.text = value;
          if searchtext.text == "" then
            return;
          end;
          activity.newActivity("pages/search/search/search", {
            searchtext.Text
          });
        end
      },
      {
        ImageView,
        layout_gravity = "center|right",
        layout_height = "20dp",
        src = "static/img/search/delete.png",
        layout_margin = "10dp",
        layout_width = "21dp",
        colorFilter = "#757575",
        onClick = function()
          searchhistory=searchUtil.removeSearchHistory(key)
          searchhistoryitemout.removeAllViews();
          if #searchhistory == 0 then
            searchhistoryout.setVisibility(View.GONE);
           else
            for k, v in pairs(searchhistory) do
              searchhistoryitemout.addView(loadlayout(sethistoryitem(k, v)));
            end;
          end;
        end
      }
    }
  };
end;
if #searchhistory > 0 then
  searchhistoryout.setVisibility(View.VISIBLE);
  for k, v in pairs(searchhistory) do
    searchhistoryitemout.addView(loadlayout(sethistoryitem(k, v)));
  end;
end;
function setitem(key, value)
  return {
    LinearLayout,
    orientation = "vertical",
    layout_width = "fill",
    layout_height = "wrap",
    {
      LinearLayout,
      layout_width = "match_parent",
      orientation = "horizontal",
      layout_height = "wrap",
      {
        TextView,
        ellipsize = "marquee",
        singleLine = true,
        selected = true,
        layout_margin = "10dp",
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf")),
        textSize = "13dp",
        text = tostring(key) .. ". " .. value,
        onClick = function()
          searchtext.text = value;
          if searchtext.text == "" then
            return;
          end;
          activity.newActivity("pages/search/search/search", {
            searchtext.Text
          });
        end
      }
    }
  };
end;
function setsearchhistory(key)
  searchUtil.setSearchHistory(key)
  searchhistory = searchUtil.getSearchHistory();
  for k, v in pairs(searchhistory) do
    searchhistoryitemout.addView(loadlayout(sethistoryitem(k, v)));
  end;
end;
function settipitem(key, value)
  return {
    LinearLayout,
    orientation = "vertical",
    layout_width = "fill",
    layout_height = "wrap",
    {
      LinearLayout,
      layout_width = "match_parent",
      orientation = "horizontal",
      layout_height = "wrap",
      {
        ImageView,
        layout_gravity = "left|center",
        layout_height = "20dp",
        src = "static/img/search/search.png",
        layout_margin = "10dp",
        layout_width = "21dp",
        colorFilter = "#757575"
      },
      {
        TextView,
        ellipsize = "marquee",
        singleLine = true,
        selected = true,
        layout_margin = "10dp",
        layout_marginLeft = "0dp",
        textSize = "13dp",
        text = value,
        Typeface = Typeface.createFromFile(File(activity.getLuaDir() .. "/static/font/font.ttf")),
        layout_weight = 1,
        onClick = function()
          searchtext.text = value;
          if searchtext.text == "" then
            return;
          end;
          activity.newActivity("pages/search/search/search", {
            searchtext.Text
          });
        end
      }
    }
  };
end;
function popmenu()
  Http.get("https://suggest.video.iqiyi.com/?if=mobile&key=" .. searchtext.text, nil, nil, function(a, b)
    if a == 200 then
      searchtipout.removeAllViews();
      searchtip.setVisibility(View.VISIBLE);
      for k, v in pairs((cjson.decode(b)).data) do
        searchtipout.addView(loadlayout(settipitem(k, v.name)));
      end;
    end;
  end);
end;
searchtip.setVisibility(View.GONE);
searchtext.addTextChangedListener({
  onTextChanged = function(s)
    if #s > 0 then
      if startswith(searchtext.Text,"http") or startswith(searchtext.Text,"magnet") or startswith(searchtext.Text,"ftp") or startswith(searchtext.Text,"ed2k") or startswith(searchtext.Text,"thunder") then
        searcheventtext.setVisibility(View.VISIBLE);
        searchevent.setVisibility(View.GONE);

       else
        searcheventtext.setVisibility(View.GONE);
        searchevent.setVisibility(View.VISIBLE);

        searchdelete.setVisibility(View.VISIBLE);
        bodyout.setVisibility(View.GONE);
        popmenu();
      end
     else
      bodyout.setVisibility(View.VISIBLE);
      searchdelete.setVisibility(View.GONE);
      searchtip.setVisibility(View.GONE);
    end;
  end
});
searchtext.setOnEditorActionListener({
  onEditorAction = function(a, b)
    if b == 3 then
      if a.text == "" then
        bodyout.setVisibility(View.VISIBLE);
        searchdelete.setVisibility(View.GONE);
        searchtip.setVisibility(View.GONE);
        return;
       else
        if startswith(searchtext.Text,"http") or startswith(searchtext.Text,"magnet") or startswith(searchtext.Text,"ftp") or startswith(searchtext.Text,"ed2k") or startswith(searchtext.Text,"thunder") then
          local site={}
          site.name="temp"
          site.type="temp"
          activity.newActivity("pages/play/play", {{site, {["标题"]="未知",["地址"]=searchtext.Text}}})
          searchtext.Text=""
          searcheventtext.setVisibility(View.GONE);
          searchevent.setVisibility(View.VISIBLE);

         else
          bodyout.setVisibility(View.VISIBLE);
          setsearchhistory(searchtext.text);
          searchhistoryout.setVisibility(View.VISIBLE);
          searchdelete.setVisibility(View.GONE);
          searchtip.setVisibility(View.GONE);
          activity.newActivity("pages/search/search/search", {
            searchtext.Text
          });
        end
      end;
    end;
  end
});
searchevent.onClick = function()
  if searchtext.text == "" then
    return;
  end;
  bodyout.setVisibility(View.VISIBLE);
  setsearchhistory(searchtext.text);
  searchhistoryout.setVisibility(View.VISIBLE);
  searchtip.setVisibility(View.GONE);
  activity.newActivity("pages/search/search/search", {
    searchtext.Text
  });
end;
searcheventtext.onClick = function()
  local site={}
  site.name="temp"
  site.type="temp"
  activity.newActivity("pages/play/play", {{site, {["标题"]="未知",["地址"]=searchtext.Text}}})
  searchtext.Text=""
  searcheventtext.setVisibility(View.GONE);
  searchevent.setVisibility(View.VISIBLE);

end


searchdelete.onClick = function()
  searchtext.text = "";
end;
goback.onClick = function()
  activity.finish();
end;
resertsearchhistory.onClick = function()
  searchhistoryitemout.removeAllViews();
  searchhistoryout.setVisibility(View.GONE);
  searchhistory = searchUtil.clearSearchHistory()
end;
function gethotsearch()
  Http.get("https://node.video.qq.com/x/api/hot_search", nil, nil, function(a, b)
    if a == 200 then
      for k, v in pairs((cjson.decode(b)).data.mapResult["0"].listInfo) do
        hotdataout.addView(loadlayout(setitem(k, v.title)));
      end;
    end;
  end);
end;
gethotsearch();

