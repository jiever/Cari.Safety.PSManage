var labelTotle                = 0;
var menuTotle                 = 0;
var loadSrcT                  = 0;
var loadSrcP                  = 50;
var alphaR                    = Math.ceil(100 / step);
var lResetSpeed               = SPEED;
var sResetSpeed               = SPEED;
var globalOB                  = null; 
var imgA                      = null;
var st                        = null;
var s_resize_st               = null;
var l_resize_st               = null; 
var smallResetFuncActived     = false;
var largeResetFuncActived     = false; 
var scrollbarsIsEnabled       = false; 
var menuOB                    = new Array(); 
var smallResetList            = new Array();
var largeResetList            = new Array();
var resetList                 = new Array();   
var ImgOb                     = new Array();
if(null != ifTopToUrl&&self == top)
     location.href=ifTopToUrl;



function srcPreLoad(icons)
{
     var info = '<BR>' +
                '<div style="width:170px;height:50px;border:1px solid ' + linkColor + ';background-color:' + itemsTopBgColor + ';font:bold 12px verdana;color:' + linkOverColor + ';padding-top:3px;padding-bottom:3px">' +
                   '<center>Loading Resource <BR>Please Wait...' +
                   '<table cellspacing=0 cellpadding=0 style="padding:0px;border:1px solid;border-color:#808080 #ffffff #808080 #ffffff;width:120px;height:7px">' +
                       '<tr>' +
                       '<td style="width:100%">' +
                             '<table cellpadding=0 cellspacing=0 id=loadInfo style="height:5px;border-width:0px;width:0%;background-color:' + linkOverColor + '">' +
                                  '<tr>' +
                                  '<td width=100%></td>' +
                                  '</tr>' +
                             '</table>' +
                       '</td>' +
                       '</tr>' +
                   '</table>' +
                   '</center>' +
                '</div>';

     document.body.style.backgroundColor = bgColor;
     document.body.innerHTML             = info;
     if(null == icons||"" == icons)
          return true; 
     imgA = icons;  
     var imgAs = imgA.split(",");
          for(i in imgAs)
          {  
               ImgOb[i]     = new Image();
               ImgOb[i].src = imgPath +imgAs[i];
          }
}

function srcIsReady()
{
     loadSrcT      += loadSrcP;
     var isReady    = true;
     var isLoadn    = 0;
     var loadingSrc = undefined;
     for(i in ImgOb)
     {
          
          if(ImgOb[i].readyState != "complete")
          {
               isReady              = false;

               if(undefined == loadingSrc)
                    loadingSrc      = ImgOb[i].src;
               
               parent.window.status = '正在载入资源:' + loadingSrc + ',请稍候......';
          }
          else
          {
               var percentL         = Math.floor(++isLoadn/ImgOb.length*100);
               loadInfo.style.width = percentL + ' %';
                
          }
     }
     loadingSrc = undefined;
     if(true == isReady||loadSrcT >= (waitForImgSrc*1000))  
     {
          document.body.style.backgroundColor = bgColor;
          parent.window.status                = '资源载入完毕!'; 
          isReady = true;
     }
     return isReady;
}  

function documentIsChanged()
{

     var tempScrollbarsEnabled; 
     if(document.body.scrollHeight > document.body.clientHeight) 
         tempScrollbarsEnabled = true;
     else
         tempScrollbarsEnabled = false;
     if(tempScrollbarsEnabled != scrollbarsIsEnabled)
     {    ////////////////如果滚动条的状态发生变化////////////////
          scrollbarsIsEnabled = tempScrollbarsEnabled;
          ResizeDocument();
     }
}

function ResizeDocument()
{   
     var instForDocumentsChange = 0;

     if(true == scrollbarsIsEnabled)
          instForDocumentsChange = 170;

     else
          instForDocumentsChange = 185;

     for(i=0;i<document.getElementsByTagName("DIV").length;i++)
     {
         var DIVob         = document.getElementsByTagName("DIV")[i];
         DIVob.style.width = instForDocumentsChange;
     }
 
     setTimeout("ResetAllMenu()",10);

}
function ResetAllMenu()
{
  
     for(obj_i=0;obj_i<menuTotle;obj_i++)
     {
         menuOB[obj_i].ResetItems();

     } 
}
 
function MenuItem(cmt,img,url)
{
     if(arguments.length < 1)
     {
          alert("MenuItem 创建对象失败!错误的参数个数");
          return false;
     }

     this.id            = labelTotle++;
     this.name          = this; 
     this.length        = 1;     
     this[0]            = this; 
     this.tagName       = "MENUITEM";
     this.imgSrc        = (null == img)? '':img;
     this.iconId        = (null == img)? null:'icon' + this.id;
     this.icon;
     this.iconHTML      = (null ==img)? '':'<img id="' + this.iconId + '" src="' + imgPath + this.imgSrc +'">';
     this.label         = cmt; 
     this.link          = url;
     this.labelId       = 'label' + this.id; 
     this.itemLabel;
     this.labelBehavior = (null == this.link)? '':' onclick="JavaScript:parent.' +friendFrame + '.location.href=\'' + this.link +'\'" onMouseOver="javascript:this.style.textDecoration=\'underline\';this.style.color=\'' + linkOverColor + '\';" onMouseOut="javascript:this.style.textDecoration=\'none\';this.style.color=\'' + linkColor + '\'"';
     var fontc          =(null == this.link)? textColor+';cursor:default':linkColor + ';cursor:hand';
     this.labelHTML     = '<FONT id="' + this.labelId + '"' + this.labelBehavior + 'style="color:' + fontc + '">' +this.label + '</FONT>';

     this.partHTML      = (null == img)? '<tr><td width=* valign=top colspan=2>' + this.labelHTML + '</td>':'<tr><td width=25 valign=top>' + this.iconHTML + '</td><td width=* valign=top>' + this.labelHTML + '</td>';
     this.innerHTML     = '<table cellspacing=0 cellpadding=0 id="item' + this.id + '" style="width:100%;height:21px">' + 
                              this.partHTML + 
                              '</tr>' +
                          '</table>'; 
   
     return true;
}

function TaskMenu(tit,items)
{    
     if(arguments.length < 1)
     {
          alert("taskMenu(), 错误的参数个数!");  return false;
     }

     if("string" != typeof(tit))
     {
          alert("taskMenu(), 错误的参数类型!");  return false;
     }

     if(undefined != items)
     {
          var itemslen = (0 == items.length)? 1:items.length;
          try
          {
                 for(ci=0;ci<itemslen;ci++)
                 {
                       if("MENUITEM" != items[ci].tagName)
                       {
                             alert("taskMenu(),错误的参数类型!"); return false;
                       }
                 }                    
          }   
          catch(e)
          {
               alert("taskMenu(), 错误的参数类型!");  return false;               
          }            
     }
     this.id             = menuTotle++;
     menuOB[this.id]     = this;
     this.items          = items;
     this.menuId         = "menuOB["+this.id+"]";
     this.tagName        = "MENU";
     this.tit            = tit.substr(0,30);
     this.innerHTML      = "";
     this.inst           = 0;
     this.sResetStep     = 0;
     this.sResetSteped   = 0;
     this.sResetInstance = 0; 
     this.lResetStep     = 0; 
     this.lResetSteped   = 0; 
     this.lResetInstance = 0;
     this.stepForOp      = 0;
     this.opSpeed        = SPEED;
     this.stat           = true;
     this.TopClaName     = (0 == this.id)? "menuLabelTop":"menuLabel";
     this.BodyClaName    = (0 == this.id)? "menuListTop":"menuList";
     this.labelHeight    = 40;
     this.Clr            = (0 == this.id)? "W":"B";
     this.parent         = (0 == this.id)? eval("document.body"):eval("npkg"+(this.id-1)); 
     this.menuItems      = new Array();
     this.ConvStat       = ConvStat;     
     this.MenuOp         = MenuOp;
     this.MenuUpMove     = MenuUpMove;
     this.MenuDownMove   = MenuDownMove;
     this.AddItems       = AddItems;
     this.ResetItems     = ResetItems;
     this.ResetTitle     = ResetTitle;
     this.ImgAddBorder   = ImgAddBorder;
     this.ImgTrimBorder  = ImgTrimBorder;
     this.CloseMenu      = CloseMenu;

     if(null != items)  
     {
          for(i=0;i<items.length;i++)
          {
               this.menuItems[i] = items[i].name;
               this.innerHTML   += this.menuItems[i].innerHTML;
          }
     }


      var rbg       = (0 == this.id)? "bg_r_top.gif" :"bg_r.gif";
      var mbg       = (0 == this.id)? "bg_m_top.gif" :"bg_m.gif"; 
      var lfc       = (0 == this.id)? labelTopColor  :labelColor; 
      var arrbg     = (0 == this.id)? arrTopColor    :arrColor;
      var bc        = (0 == this.id)? borderTopColor :borderColor;
      var preLoadBc = (0 == this.id)? preLoadTopColor:preLoadColor;
      var itemsBc   = (0 == this.id)? itemsTopBgColor:itemsBgColor;

      var part1 = '<div class="menuBlank" style="background-color:' + bgColor + '"></div>' +
    '<div class="' +this.TopClaName + '" style="background-color:' + preLoadBc + '" onClick="' + this.menuId + '.MenuOp()" onMouseOver="' + this.menuId + '.ImgAddBorder(this)" onMouseOut="' + this.menuId + '.ImgTrimBorder(this)" title="' +this.tit + '">' +
          '<table cellpadding=0 cellspacing=0 width=100% style="table-layout:fixed">' + 
              '<tr height=25><td style="width:3px;background-image:url(' + imgPath + rbg +');"></td><td width=* id="bgi' + this.id + '" style="word-break:keep-all;background-image:url(' + imgPath + mbg + ');padding-left:12px">' +
                   '<span style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap;width:100%;color:' + lfc +'">' +
                       '<font id="menuTitle' + this.id + '" class="' + this.Clr + '">' + this.tit + '</font>' +
                   '</span>' +
              '</td>'+
              '<td id="arrBg' + this.id + '" width=27 align=right style="background-color:' + arrbg + '"><img id="img' + this.id + '" src="' + imgPath + 'Arr' + this.Clr + '.gif" align=absmiddle class=ArrOut>' +
              '</td></tr>' +
          '</table>' +
    '</div>'+
    '<div id="pkg' +this.id + '" class="menuPkg">';

     var part2 = '<div id="menu' +this.id + '" class=' + this.BodyClaName + '>' +this.innerHTML + '</div>';
 
     this.parent.innerHTML = part2; 

     this.menu = eval("menu" + this.id.toString());
     this.inst = this.menu.offsetHeight; 

     part2 = '<div id="menu' + this.id + '" class=' + this.BodyClaName + ' style="height:' + this.inst + 'px;border-color:' + bc + ';background-color:' + itemsBc + '">' +this.innerHTML + '</div>';
     this.parent.innerHTML=part2;        
  
    var part3 = '<div id="npkg' + this.id + '" style="top:' + (this.inst+this.labelHeight) + 'px"></div></div><!-- end pkg -->';
   
    if(null != this.menuItems)  
    {
          for(i=0;i<this.menuItems.length;i++)
          {
               this.menuItems[i].icon      = eval(this.menuItems[i].iconId);
               this.menuItems[i].itemLabel = eval(this.menuItems[i].labelId);
          }
    }
  
    this.parent.innerHTML = part1 + part2 + part3;         
    this.menu             = eval("menu" + this.id);             
    this.pkg              = eval("pkg"  + this.id);         
    this.npkg             = eval("npkg" + this.id);
    this.Arr              = eval("img"  + this.id);
    this.titBgi           = eval("bgi"  + this.id);
  
    this.menu.style.overflowY = "hidden"; 

    documentIsChanged();  


    if(scrollbarsIsEnabled)   ResizeDocument(); 
    return true; 
      
}

function MenuOp()
{
     if(null != globalOB)
          return ;

     this.opSpeed          = SPEED;
     this.InstForOp = Math.floor((this.menu.scrollHeight + 2) / step);
     
     if(true == this.stat)
     {
          globalOB                          = this;      
          this.menu.style.borderBottomColor = bgColor;

               if(0 == this.id)

                     this.Arr.src = imgPath + 'ArrWV.gif';
               else

                     this.Arr.src = imgPath + 'ArrBV.gif';

          this.MenuUpMove();
     }
     else
     {
          this.ResetItems();

          globalOB = this;//占用全局操控对象
               if(0 == this.id)

                     this.Arr.src = imgPath + 'ArrW.gif';
               else

                     this.Arr.src = imgPath + 'ArrB.gif';

          this.MenuDownMove();
     }
}

function MenuUpMove()
{

          if((this.stepForOp + this.InstForOp) < this.menu.offsetHeight)
          {
               this.pkg.style.top               =  (this.pkg.offsetTop - this.InstForOp) + "px";
               this.stepForOp                  += this.InstForOp;
               this.menu.filters.alpha.opacity -= alphaR;

               var ns = ((this.opSpeed+srd) < srd*step)? (this.opSpeed += srd):this.opSpeed;
               st     = setTimeout("globalOB.MenuUpMove()",ns);
          }
          else
          {
               clearTimeout(st);
               tempInst                 = this.menu.offsetHeight - this.stepForOp;//步长的剩余
               this.pkg.style.top       = (this.pkg.offsetTop - tempInst) + "px";
               this.stepForOp           = 0;
               globalOB                 = null;
               this.ConvStat();             
               
          }

     documentIsChanged();
}

function MenuDownMove()
{

          if((this.stepForOp + this.InstForOp) < this.menu.offsetHeight)
          {
               this.pkg.style.top              = (this.pkg.offsetTop + this.InstForOp) + "px";
               this.stepForOp                  += this.InstForOp;
               this.menu.filters.alpha.opacity += alphaR;

               var ns = ((this.opSpeed+srd) < srd*step)? (this.opSpeed += srd):this.opSpeed;
               st     = setTimeout("globalOB.MenuDownMove()",ns);
          }
          else
          {
               clearTimeout(st);
               tempInst                 = this.menu.offsetHeight - this.stepForOp;
               this.pkg.style.top       = this.pkg.offsetTop     + tempInst;
               this.stepForOp           = 0;
               globalOB                 = null;
               this.ConvStat();

                    if(this.id != 0)

                          this.menu.style.borderBottomColor = borderColor;
                    else

                          this.menu.style.borderBottomColor = borderTopColor;                  
          }

     documentIsChanged();
}

function ConvStat()
{ 
     this.stat = !this.stat;
}


function ImgAddBorder(obj)
{   
     var tempLabelColor;
     var tempArrColor;

     if(0 == this.id)
     {
          tempLabelColor = labelTopOverColor;
          tempArrColor   = arrTopOverColor;
     }
     else 
     {
          tempLabelColor = labelOverColor;
          tempArrColor   = arrOverColor;
     }
 
 

     eval("arrBg" + this.id + ".style.backgroundColor='" + tempArrColor + "'");
          
     eval("menuTitle" + this.id + ".style.color='" + tempLabelColor + "'");
}

function ImgTrimBorder(obj)
{   
     var tempLabelColor;
     var tempArrColor;

     if(0 == this.id)
     {
          tempLabelColor = labelTopColor;
          tempArrColor   = arrTopColor;
     }
     else 
     {
          tempLabelColor = labelColor;
          tempArrColor   = arrColor;
     }
 
 

     eval("arrBg" + this.id + ".style.backgroundColor='" + tempArrColor + "'");
          
     eval("menuTitle" + this.id + ".style.color='" + tempLabelColor + "'");
}
     
function AddItems(nItems)
{    
     if(null == nItems||0 == arguments.length)
    
           return;         

     this.sResetStep     = 0;
     this.sResetSteped   = 0;
     this.sResetInstance = 0; 
     this.lResetStep     = 0; 
     this.lResetSteped   = 0; 
     this.lResetInstance = 0;

     var tempItems = null;
     if(undefined != this.items)
     {
          if(this.items.length > 1)
          {
               tempItems = this.items.concat(nItems);
          }
          else
               if(nItems.length > 1)
               {      
                    tempItems = nItems.concat(this.items)
               }
               else
           
                    tempItems = new Array(this.items,nItems);

          this.items = tempItems;
     }
     else
 
          this.items=nItems;
 
     oMenuHTML      = this.menu.innerHTML;  
     oMenuInnerHTML = this.menu.innerHTML;
     oMenuDst       = this.menu.offsetHeight;
     oItemLength    = this.menuItems.length; 
   
     nMenuHTML      = "";

     for(i=0;i<nItems.length;i++)
     {
          this.menuItems[(oItemLength+i)] = nItems[i].name;
          nMenuHTML                      += this.menuItems[(oItemLength+i)].innerHTML;
     }

     this.menu.style.overflowY = "hidden";
     this.menu.innerHTML      += nMenuHTML;
     this.lResetInstance       = this.menu.scrollHeight-oMenuDst;
   
     for(i=0;i<nItems.length;i++) 
     {  
          this.menuItems[oItemLength+i].icon      = eval(nItems.iconId);
          this.menuItems[oItemLength+i].itemLabel = eval(nItems.labelId);
     }
    
     if(0 ==  this.lResetInstance)  
 
          return; 

   
     this.lResetStep         = Math.floor(this.lResetInstance / step); 
     largeResetList[this.id] = this;
     lResetSpeed             = 0;

     if(false == largeResetFuncActived)
     { 
          MenuLargeResize();
     }                      
}

function ResetTitle(nTitle)
{
     if("string" != typeof(nTitle))
     {
          alert("ResetTitle() 错误的参数类型!");
          return false;
     }
     
     var tempMenuOb       = eval("menuTitle" + this.id);
     tempMenuOb.innerHTML = nTitle; 
     tempMenuOb.parentElement.parentElement.parentElement.title = nTitle;
     return true;
} 

function ResetItems(items,nTitle)
{ 
             
     if(undefined != items) 
     {
          var itemslen = (0 == items.length)? 1:items.length;
          try
          {
                 for(ci=0;ci<itemslen;ci++)
                 {
                       if("MENUITEM" != items[ci].tagName)
                       {
                             alert("ResetItems,错误的参数类型!"); return false;
                       }
                 }                    
          }   
          catch(e)
          {
               alert("ResetItems, 错误的参数类型!");  return false;               
          } 
     }
    
     if(undefined != nTitle)
          this.ResetTitle(nTitle); 
       
     if(0 == arguments.length)
          items = this.items;
 
     if(null == this.items)
          return;

     this.sResetStep     = 0;
     this.sResetSteped   = 0;
     this.sResetInstance = 0; 
     this.lResetStep     = 0; 
     this.lResetSteped   = 0; 
     this.lResetInstance = 0;
   
     this.items = items;
     oMenuDst   = (this.menu.offsetHeight-2);
     oMenuHTML  = this.menu.innerHTML;
    
     var nMenuHTML = "";
     for(i=0;i<items.length;i++)
     {
          this.menuItems[i] = items[i].name;
          nMenuHTML        += this.menuItems[i].innerHTML;
     }
   
     this.menu.style.overflowY = "hidden";
     this.menu.innerHTML       = nMenuHTML;
     tempResetInstance         = this.menu.scrollHeight-oMenuDst;
    
     for(i=0;i<items.length;i++)
     {  
          this.menuItems[i].icon      = eval(this.menuItems[i].iconId);
          this.menuItems[i].itemLabel = eval(this.menuItems[i].labelId);
     }

     if(0 == tempResetInstance)
      
            return ;

     tempResetStep = (tempResetInstance > 0)? Math.floor(tempResetInstance / step):Math.ceil(tempResetInstance / step); 

     if(tempResetInstance > 0)
     {
          if(0 == tempResetStep) 
               tempResetStep      = 1;
          this.lResetStep         = tempResetStep; 
          this.lResetInstance     = tempResetInstance;
          largeResetList[this.id] = this;
          lResetSpeed             = SPEED;          

          if(false == largeResetFuncActived)
          { 
               MenuLargeResize();
          }
     }
     else
          if(tempResetInstance < 0) 
          {
               if(0 == tempResetStep) 
                    tempResetStep      = -1;
               this.sResetStep         = tempResetStep;
               this.sResetInstance     = tempResetInstance; 
               smallResetList[this.id] = this; 
               sResetSpeed             = SPEED;

               if(false == smallResetFuncActived)
               {   
                    MenuSmallResize();
               }         
             
          }
     return true;
   
}

function MenuLargeResize()
{ 
     largeResetFuncActived = true;
    
     for(i in largeResetList)
     {  
          try
          {
               if(undefined == largeResetList[i])
                    continue;

               var tempResetObj = largeResetList[i];

               if(0 == tempResetObj.lResetInstance)
               {
                    largeResetList[i] = undefined;
                    continue;
               }
              
               if(false == tempResetObj.stat)
               {   
                    tempResetObj.menu.style.height = tempResetObj.menu.offsetHeight + tempResetObj.lResetInstance;
                    tempResetObj.menu.style.top    = tempResetObj.menu.offsetTop    - tempResetObj.lResetInstance;
              
                    largeResetList[i]              = undefined; 
                   
                    continue;
               }
             
               if((tempResetObj.lResetSteped + tempResetObj.lResetStep) < tempResetObj.lResetInstance)
               {             
                    tempResetObj.lResetSteped     += tempResetObj.lResetStep;   
                    tempResetObj.menu.style.height = tempResetObj.menu.offsetHeight + tempResetObj.lResetStep;
                    tempResetObj.npkg.style.top    = tempResetObj.npkg.offsetTop    + tempResetObj.lResetStep;       
               }
               else
               {           
                 
                    tempDst                        = tempResetObj.lResetInstance    - tempResetObj.lResetSteped;
                    tempResetObj.menu.style.height = tempResetObj.menu.offsetHeight + tempDst;
                    tempResetObj.npkg.style.top    = tempResetObj.npkg.offsetTop    + tempDst;  
                    largeResetList[i]              = undefined;
                            
               }
          }   
          catch(e)
          {
             
          }
     } 
 
     documentIsChanged();
   
     var tempN = 0;
     for(i in largeResetList)
     {
            if(undefined != largeResetList[i])
                 tempN++;
     }
    
 
     if(tempN > 0)
     {
          var lns      = ((lResetSpeed + srd) < srd*step)? (lResetSpeed += srd):lResetSpeed;

          l_resize_st = setTimeout("MenuLargeResize()",lns);
     }
     else
     {
          clearTimeout(l_resize_st);
          lResetSpeed           = SPEED;
          largeResetFuncActived = false;
     }     

}

function MenuSmallResize()
{ 
     smallResetFuncActived = true;

    
     for(i in smallResetList)
     {  
          try
          {
               if(undefined == smallResetList[i])
                    continue;

               var tempResetObj = smallResetList[i];

               if(0 == tempResetObj.sResetInstance)
               { 
                    smallResetList[i] = undefined;
                    continue;
               }
           
               if(false == tempResetObj.stat)
               {
                    tempResetObj.menu.style.height = tempResetObj.menu.offsetHeight + tempResetObj.sResetInstance;
                    tempResetObj.menu.style.top    = tempResetObj.menu.offsetTop    - tempResetObj.sResetInstance;
                
                    smallResetList[i]              = undefined; 
                  
                    continue;
               }
             
               if((tempResetObj.sResetSteped + tempResetObj.sResetStep) > tempResetObj.sResetInstance)
               {                 
                    tempResetObj.sResetSteped     += tempResetObj.sResetStep;  
                    tempResetObj.menu.style.height = tempResetObj.menu.offsetHeight + tempResetObj.sResetStep;
                    tempResetObj.npkg.style.top    = tempResetObj.npkg.offsetTop    + tempResetObj.sResetStep;  
               }
               else
               {           
             
                    tempDst                        = tempResetObj.sResetInstance    - tempResetObj.sResetSteped;
                    tempResetObj.menu.style.height = tempResetObj.menu.offsetHeight + tempDst;
                    tempResetObj.npkg.style.top    = tempResetObj.npkg.offsetTop    + tempDst;                 
                    smallResetList[i]              = undefined;
                                         
               }   
          }
          catch(e)
          {
              
          }               
     }    
 
     documentIsChanged();
  
     var tempN = 0;
     for(i in smallResetList)
     {
            if(undefined != smallResetList[i])
                 tempN++;            
     }
    
     if(tempN > 0)
     {
          var sns      = ((sResetSpeed + srd) < srd*step)? (sResetSpeed += srd):sResetSpeed;
          s_resize_st = setTimeout("MenuSmallResize()",sns);
     }
     else
     {
          clearTimeout(s_resize_st);
          sResetSpeed           = SPEED;
          smallResetFuncActived = false;
     }
     
}

function ResetDocument()
{
     labelTotle                 = 0;
     menuTotle                  = 0;
     globalOB                   = null; 
     st                         = null;
     s_resize_st                = null;
     l_resize_st                = null; 
     smallResetFuncActived      = false;
     largeResetFuncActived      = false; 
     scrollbarsIsEnabled        = false;
     friendFrame                = "content"; 
     ResetArray(menuOB);
     ResetArray(smallResetList);
     ResetArray(largeResetList);
     ResetArray(resetList);
     document.body.innerHTML    ="";
}

function CloseMenu()
{
     if(null != globalOB||undefined != resetList[this.id])
          return;
     globalOB = this;
     this.pkg.style.top=this.pkg.offsetTop-this.inst;
     this.menu.filters.alpha.opacity=0;
     this.menu.style.borderBottomColor=bgColor;

               if(0 == this.id)

                     this.Arr.src = imgPath + 'ArrWV.gif';
               else

                     this.Arr.src = imgPath + 'ArrBV.gif';
     this.stat = false;
     globalOB = null;
     documentIsChanged();
} 

function ResetArray(oArray)
{
     for(ri in oArray)
     {
          oArray[ri] = undefined;
     }
     return true;
}


window.onresize = function() {
    documentIsChanged();
};

document.onselectstart = function() {
    return docSelectEnabled;
};

document.oncontextmenu = function() {
    return true;
};