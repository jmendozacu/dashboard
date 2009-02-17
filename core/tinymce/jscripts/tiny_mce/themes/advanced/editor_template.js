(function(){var d=tinymce.DOM,b=tinymce.dom.Event,g=tinymce.extend,e=tinymce.each,a=tinymce.util.Cookie,f,c=tinymce.explode;tinymce.ThemeManager.requireLangPack("advanced");tinymce.create("tinymce.themes.AdvancedTheme",{sizes:[8,10,12,14,18,24,36],controls:{bold:["bold_desc","Bold"],italic:["italic_desc","Italic"],underline:["underline_desc","Underline"],strikethrough:["striketrough_desc","Strikethrough"],justifyleft:["justifyleft_desc","JustifyLeft"],justifycenter:["justifycenter_desc","JustifyCenter"],justifyright:["justifyright_desc","JustifyRight"],justifyfull:["justifyfull_desc","JustifyFull"],bullist:["bullist_desc","InsertUnorderedList"],numlist:["numlist_desc","InsertOrderedList"],outdent:["outdent_desc","Outdent"],indent:["indent_desc","Indent"],cut:["cut_desc","Cut"],copy:["copy_desc","Copy"],paste:["paste_desc","Paste"],undo:["undo_desc","Undo"],redo:["redo_desc","Redo"],link:["link_desc","mceLink"],unlink:["unlink_desc","unlink"],image:["image_desc","mceImage"],cleanup:["cleanup_desc","mceCleanup"],help:["help_desc","mceHelp"],code:["code_desc","mceCodeEditor"],hr:["hr_desc","InsertHorizontalRule"],removeformat:["removeformat_desc","RemoveFormat"],sub:["sub_desc","subscript"],sup:["sup_desc","superscript"],forecolor:["forecolor_desc","ForeColor"],forecolorpicker:["forecolor_desc","mceForeColor"],backcolor:["backcolor_desc","HiliteColor"],backcolorpicker:["backcolor_desc","mceBackColor"],charmap:["charmap_desc","mceCharMap"],visualaid:["visualaid_desc","mceToggleVisualAid"],anchor:["anchor_desc","mceInsertAnchor"],newdocument:["newdocument_desc","mceNewDocument"],blockquote:["blockquote_desc","mceBlockQuote"]},stateControls:["bold","italic","underline","strikethrough","bullist","numlist","justifyleft","justifycenter","justifyright","justifyfull","sub","sup","blockquote"],init:function(i,j){var k=this,l,h,m;k.editor=i;k.url=j;k.onResolveName=new tinymce.util.Dispatcher(this);k.settings=l=g({theme_advanced_path:true,theme_advanced_toolbar_location:"bottom",theme_advanced_buttons1:"bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect",theme_advanced_buttons2:"bullist,numlist,|,outdent,indent,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code",theme_advanced_buttons3:"hr,removeformat,visualaid,|,sub,sup,|,charmap",theme_advanced_blockformats:"p,address,pre,h1,h2,h3,h4,h5,h6",theme_advanced_toolbar_align:"center",theme_advanced_fonts:"Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Trebuchet MS=trebuchet ms,geneva;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats",theme_advanced_more_colors:1,theme_advanced_row_height:23,theme_advanced_resize_horizontal:1,theme_advanced_resizing_use_cookie:1,theme_advanced_font_sizes:"1,2,3,4,5,6,7",readonly:i.settings.readonly},i.settings);if(!l.font_size_style_values){l.font_size_style_values="8pt,10pt,12pt,14pt,18pt,24pt,36pt"}if(tinymce.is(l.theme_advanced_font_sizes,"string")){l.font_size_style_values=tinymce.explode(l.font_size_style_values);l.font_size_classes=tinymce.explode(l.font_size_classes||"");m={};i.settings.theme_advanced_font_sizes=l.theme_advanced_font_sizes;e(i.getParam("theme_advanced_font_sizes","","hash"),function(p,o){var n;if(o==p&&p>=1&&p<=7){o=p+" ("+k.sizes[p-1]+"pt)";if(i.settings.convert_fonts_to_spans){n=l.font_size_classes[p-1];p=l.font_size_style_values[p-1]||(k.sizes[p-1]+"pt")}}if(/^\s*\./.test(p)){n=p.replace(/\./g,"")}m[o]=n?{"class":n}:{fontSize:p}});l.theme_advanced_font_sizes=m}if((h=l.theme_advanced_path_location)&&h!="none"){l.theme_advanced_statusbar_location=l.theme_advanced_path_location}if(l.theme_advanced_statusbar_location=="none"){l.theme_advanced_statusbar_location=0}i.onInit.add(function(){i.onNodeChange.add(k._nodeChanged,k);if(i.settings.content_css!==false){i.dom.loadCSS(i.baseURI.toAbsolute("themes/advanced/skins/"+i.settings.skin+"/content.css"))}});i.onSetProgressState.add(function(p,n,q){var r,s=p.id,o;if(n){k.progressTimer=setTimeout(function(){r=p.getContainer();r=r.insertBefore(d.create("DIV",{style:"position:relative"}),r.firstChild);o=d.get(p.id+"_tbl");d.add(r,"div",{id:s+"_blocker","class":"mceBlocker",style:{width:o.clientWidth+2,height:o.clientHeight+2}});d.add(r,"div",{id:s+"_progress","class":"mceProgress",style:{left:o.clientWidth/2,top:o.clientHeight/2}})},q||0)}else{d.remove(s+"_blocker");d.remove(s+"_progress");clearTimeout(k.progressTimer)}});d.loadCSS(l.editor_css?i.documentBaseURI.toAbsolute(l.editor_css):j+"/skins/"+i.settings.skin+"/ui.css");if(l.skin_variant){d.loadCSS(j+"/skins/"+i.settings.skin+"/ui_"+l.skin_variant+".css")}},createControl:function(k,h){var i,j;if(j=h.createControl(k)){return j}switch(k){case"styleselect":return this._createStyleSelect();case"formatselect":return this._createBlockFormats();case"fontselect":return this._createFontSelect();case"fontsizeselect":return this._createFontSizeSelect();case"forecolor":return this._createForeColorMenu();case"backcolor":return this._createBackColorMenu()}if((i=this.controls[k])){return h.createButton(k,{title:"advanced."+i[0],cmd:i[1],ui:i[2],value:i[3]})}},execCommand:function(j,i,k){var h=this["_"+j];if(h){h.call(this,i,k);return true}return false},_importClasses:function(i){var h=this.editor,j=h.controlManager.get("styleselect");if(j.getLength()==0){e(h.dom.getClasses(),function(k){j.add(k["class"],k["class"])})}},_createStyleSelect:function(l){var i=this,h=i.editor,j=h.controlManager,k=j.createListBox("styleselect",{title:"advanced.style_select",onselect:function(m){if(k.selectedValue===m){h.execCommand("mceSetStyleInfo",0,{command:"removeformat"});k.select();return false}else{h.execCommand("mceSetCSSClass",0,m)}}});if(k){e(h.getParam("theme_advanced_styles","","hash"),function(n,m){if(n){k.add(i.editor.translate(m),n)}});k.onPostRender.add(function(m,o){if(!k.NativeListBox){b.add(o.id+"_text","focus",i._importClasses,i);b.add(o.id+"_text","mousedown",i._importClasses,i);b.add(o.id+"_open","focus",i._importClasses,i);b.add(o.id+"_open","mousedown",i._importClasses,i)}else{b.add(o.id,"focus",i._importClasses,i)}})}return k},_createFontSelect:function(){var j,i=this,h=i.editor;j=h.controlManager.createListBox("fontselect",{title:"advanced.fontdefault",cmd:"FontName"});if(j){e(h.getParam("theme_advanced_fonts",i.settings.theme_advanced_fonts,"hash"),function(m,l){j.add(h.translate(l),m,{style:m.indexOf("dings")==-1?"font-family:"+m:""})})}return j},_createFontSizeSelect:function(){var l=this,j=l.editor,m,k=0,h=[];m=j.controlManager.createListBox("fontsizeselect",{title:"advanced.font_size",onselect:function(i){if(i.fontSize){j.execCommand("FontSize",false,i.fontSize)}else{e(l.settings.theme_advanced_font_sizes,function(o,n){if(o["class"]){h.push(o["class"])}});j.editorCommands._applyInlineStyle("span",{"class":i["class"]},{check_classes:h})}}});if(m){e(l.settings.theme_advanced_font_sizes,function(n,i){var o=n.fontSize;if(o>=1&&o<=7){o=l.sizes[parseInt(o)-1]+"pt"}m.add(i,n,{style:"font-size:"+o,"class":"mceFontSize"+(k++)+(" "+(n["class"]||""))})})}return m},_createBlockFormats:function(){var j,h={p:"advanced.paragraph",address:"advanced.address",pre:"advanced.pre",h1:"advanced.h1",h2:"advanced.h2",h3:"advanced.h3",h4:"advanced.h4",h5:"advanced.h5",h6:"advanced.h6",div:"advanced.div",blockquote:"advanced.blockquote",code:"advanced.code",dt:"advanced.dt",dd:"advanced.dd",samp:"advanced.samp"},i=this;j=i.editor.controlManager.createListBox("formatselect",{title:"advanced.block",cmd:"FormatBlock"});if(j){e(i.editor.getParam("theme_advanced_blockformats",i.settings.theme_advanced_blockformats,"hash"),function(m,l){j.add(i.editor.translate(l!=m?l:h[m]),m,{"class":"mce_formatPreview mce_"+m})})}return j},_createForeColorMenu:function(){var l,i=this,j=i.settings,k={},h;if(j.theme_advanced_more_colors){k.more_colors_func=function(){i._mceColorPicker(0,{color:l.value,func:function(m){l.setColor(m)}})}}if(h=j.theme_advanced_text_colors){k.colors=h}if(j.theme_advanced_default_foreground_color){k.default_color=j.theme_advanced_default_foreground_color}k.title="advanced.forecolor_desc";k.cmd="ForeColor";k.scope=this;l=i.editor.controlManager.createColorSplitButton("forecolor",k);return l},_createBackColorMenu:function(){var l,i=this,j=i.settings,k={},h;if(j.theme_advanced_more_colors){k.more_colors_func=function(){i._mceColorPicker(0,{color:l.value,func:function(m){l.setColor(m)}})}}if(h=j.theme_advanced_background_colors){k.colors=h}if(j.theme_advanced_default_background_color){k.default_color=j.theme_advanced_default_background_color}k.title="advanced.backcolor_desc";k.cmd="HiliteColor";k.scope=this;l=i.editor.controlManager.createColorSplitButton("backcolor",k);return l},renderUI:function(j){var l,k,m,u=this,q=u.editor,v=u.settings,r,i,h;l=i=d.create("span",{id:q.id+"_parent","class":"mceEditor "+q.settings.skin+"Skin"+(v.skin_variant?" "+q.settings.skin+"Skin"+u._ufirst(v.skin_variant):"")});if(!d.boxModel){l=d.add(l,"div",{"class":"mceOldBoxModel"})}l=r=d.add(l,"table",{id:q.id+"_tbl","class":"mceLayout",cellSpacing:0,cellPadding:0});l=m=d.add(l,"tbody");switch((v.theme_advanced_layout_manager||"").toLowerCase()){case"rowlayout":k=u._rowLayout(v,m,j);break;case"customlayout":k=q.execCallback("theme_advanced_custom_layout",v,m,j,i);break;default:k=u._simpleLayout(v,m,j,i)}l=j.targetNode;h=d.stdMode?r.getElementsByTagName("tr"):r.rows;d.addClass(h[0],"mceFirst");d.addClass(h[h.length-1],"mceLast");e(d.select("tr",m),function(o){d.addClass(o.firstChild,"mceFirst");d.addClass(o.childNodes[o.childNodes.length-1],"mceLast")});if(d.get(v.theme_advanced_toolbar_container)){d.get(v.theme_advanced_toolbar_container).appendChild(i)}else{d.insertAfter(i,l)}b.add(q.id+"_path_row","click",function(n){n=n.target;if(n.nodeName=="A"){u._sel(n.className.replace(/^.*mcePath_([0-9]+).*$/,"$1"));return b.cancel(n)}});if(!q.getParam("accessibility_focus")){b.add(d.add(i,"a",{href:"#"},"<!-- IE -->"),"focus",function(){tinyMCE.get(q.id).focus()})}if(v.theme_advanced_toolbar_location=="external"){j.deltaHeight=0}u.deltaHeight=j.deltaHeight;j.targetNode=null;return{iframeContainer:k,editorContainer:q.id+"_parent",sizeContainer:r,deltaHeight:j.deltaHeight}},getInfo:function(){return{longname:"Advanced theme",author:"Moxiecode Systems AB",authorurl:"http://tinymce.moxiecode.com",version:tinymce.majorVersion+"."+tinymce.minorVersion}},resizeBy:function(h,i){var j=d.get(this.editor.id+"_tbl");this.resizeTo(j.clientWidth+h,j.clientHeight+i)},resizeTo:function(i,l){var j=this.editor,k=j.settings,n=d.get(j.id+"_tbl"),o=d.get(j.id+"_ifr"),m;i=Math.max(k.theme_advanced_resizing_min_width||100,i);l=Math.max(k.theme_advanced_resizing_min_height||100,l);i=Math.min(k.theme_advanced_resizing_max_width||65535,i);l=Math.min(k.theme_advanced_resizing_max_height||65535,l);m=n.clientHeight-o.clientHeight;d.setStyle(o,"height",l-m);d.setStyles(n,{width:i,height:l})},destroy:function(){var h=this.editor.id;b.clear(h+"_resize");b.clear(h+"_path_row");b.clear(h+"_external_close")},_simpleLayout:function(x,q,j,h){var w=this,r=w.editor,u=x.theme_advanced_toolbar_location,l=x.theme_advanced_statusbar_location,k,i,m,v;if(x.readonly){k=d.add(q,"tr");k=i=d.add(k,"td",{"class":"mceIframeContainer"});return i}if(u=="top"){w._addToolbars(q,j)}if(u=="external"){k=v=d.create("div",{style:"position:relative"});k=d.add(k,"div",{id:r.id+"_external","class":"mceExternalToolbar"});d.add(k,"a",{id:r.id+"_external_close",href:"javascript:;","class":"mceExternalClose"});k=d.add(k,"table",{id:r.id+"_tblext",cellSpacing:0,cellPadding:0});m=d.add(k,"tbody");if(h.firstChild.className=="mceOldBoxModel"){h.firstChild.appendChild(v)}else{h.insertBefore(v,h.firstChild)}w._addToolbars(m,j);r.onMouseUp.add(function(){var o=d.get(r.id+"_external");d.show(o);d.hide(f);var n=b.add(r.id+"_external_close","click",function(){d.hide(r.id+"_external");b.remove(r.id+"_external_close","click",n)});d.show(o);d.setStyle(o,"top",0-d.getRect(r.id+"_tblext").h-1);d.hide(o);d.show(o);o.style.filter="";f=r.id+"_external";o=null})}if(l=="top"){w._addStatusBar(q,j)}if(!x.theme_advanced_toolbar_container){k=d.add(q,"tr");k=i=d.add(k,"td",{"class":"mceIframeContainer"})}if(u=="bottom"){w._addToolbars(q,j)}if(l=="bottom"){w._addStatusBar(q,j)}return i},_rowLayout:function(v,l,j){var u=this,m=u.editor,r,w,h=m.controlManager,k,i,q,p;r=v.theme_advanced_containers_default_class||"";w=v.theme_advanced_containers_default_align||"center";e(c(v.theme_advanced_containers||""),function(s,o){var n=v["theme_advanced_container_"+s]||"";switch(n.toLowerCase()){case"mceeditor":k=d.add(l,"tr");k=i=d.add(k,"td",{"class":"mceIframeContainer"});break;case"mceelementpath":u._addStatusBar(l,j);break;default:p=(v["theme_advanced_container_"+s+"_align"]||w).toLowerCase();p="mce"+u._ufirst(p);k=d.add(d.add(l,"tr"),"td",{"class":"mceToolbar "+(v["theme_advanced_container_"+s+"_class"]||r)+" "+p||w});q=h.createToolbar("toolbar"+o);u._addControls(n,q);d.setHTML(k,q.renderHTML());j.deltaHeight-=v.theme_advanced_row_height}});return i},_addControls:function(i,h){var j=this,k=j.settings,l,m=j.editor.controlManager;if(k.theme_advanced_disable&&!j._disabled){l={};e(c(k.theme_advanced_disable),function(n){l[n]=1});j._disabled=l}else{l=j._disabled}e(c(i),function(p){var o;if(l&&l[p]){return}if(p=="tablecontrols"){e(["table","|","row_props","cell_props","|","row_before","row_after","delete_row","|","col_before","col_after","delete_col","|","split_cells","merge_cells"],function(q){q=j.createControl(q,m);if(q){h.add(q)}});return}o=j.createControl(p,m);if(o){h.add(o)}})},_addToolbars:function(w,k){var z=this,p,m,r=z.editor,A=z.settings,y,j=r.controlManager,u,l,q=[],x;x=A.theme_advanced_toolbar_align.toLowerCase();x="mce"+z._ufirst(x);l=d.add(d.add(w,"tr"),"td",{"class":"mceToolbar "+x});if(!r.getParam("accessibility_focus")){q.push(d.createHTML("a",{href:"#",onfocus:"tinyMCE.get('"+r.id+"').focus();"},"<!-- IE -->"))}q.push(d.createHTML("a",{href:"#",accesskey:"q",title:r.getLang("advanced.toolbar_focus")},"<!-- IE -->"));for(p=1;(y=A["theme_advanced_buttons"+p]);p++){m=j.createToolbar("toolbar"+p,{"class":"mceToolbarRow"+p});if(A["theme_advanced_buttons"+p+"_add"]){y+=","+A["theme_advanced_buttons"+p+"_add"]}if(A["theme_advanced_buttons"+p+"_add_before"]){y=A["theme_advanced_buttons"+p+"_add_before"]+","+y}z._addControls(y,m);q.push(m.renderHTML());k.deltaHeight-=A.theme_advanced_row_height}q.push(d.createHTML("a",{href:"#",accesskey:"z",title:r.getLang("advanced.toolbar_focus"),onfocus:"tinyMCE.getInstanceById('"+r.id+"').focus();"},"<!-- IE -->"));d.setHTML(l,q.join(""))},_addStatusBar:function(l,i){var j,u=this,m=u.editor,v=u.settings,h,p,q,k;j=d.add(l,"tr");j=k=d.add(j,"td",{"class":"mceStatusbar"});j=d.add(j,"div",{id:m.id+"_path_row"},v.theme_advanced_path?m.translate("advanced.path")+": ":"&#160;");d.add(j,"a",{href:"#",accesskey:"x"});if(v.theme_advanced_resizing&&!tinymce.isOldWebKit){d.add(k,"a",{id:m.id+"_resize",href:"javascript:;",onclick:"return false;","class":"mceResize"});if(v.theme_advanced_resizing_use_cookie){m.onPostRender.add(function(){var n=a.getHash("TinyMCE_"+m.id+"_size"),r=d.get(m.id+"_tbl");if(!n){return}if(v.theme_advanced_resize_horizontal){r.style.width=Math.max(10,n.cw)+"px"}r.style.height=Math.max(10,n.ch)+"px";d.get(m.id+"_ifr").style.height=Math.max(10,parseInt(n.ch)+u.deltaHeight)+"px"})}m.onPostRender.add(function(){b.add(m.id+"_resize","mousedown",function(x){var z,t,o,s,y,r;z=d.get(m.id+"_tbl");o=z.clientWidth;s=z.clientHeight;miw=v.theme_advanced_resizing_min_width||100;mih=v.theme_advanced_resizing_min_height||100;maw=v.theme_advanced_resizing_max_width||65535;mah=v.theme_advanced_resizing_max_height||65535;t=d.add(d.get(m.id+"_parent"),"div",{"class":"mcePlaceHolder"});d.setStyles(t,{width:o,height:s});d.hide(z);d.show(t);h={x:x.screenX,y:x.screenY,w:o,h:s,dx:null,dy:null};p=b.add(d.doc,"mousemove",function(B){var n,A;h.dx=B.screenX-h.x;h.dy=B.screenY-h.y;n=Math.max(miw,h.w+h.dx);A=Math.max(mih,h.h+h.dy);n=Math.min(maw,n);A=Math.min(mah,A);if(v.theme_advanced_resize_horizontal){t.style.width=n+"px"}t.style.height=A+"px";return b.cancel(B)});q=b.add(d.doc,"mouseup",function(n){var w;b.remove(d.doc,"mousemove",p);b.remove(d.doc,"mouseup",q);z.style.display="";d.remove(t);if(h.dx===null){return}w=d.get(m.id+"_ifr");if(v.theme_advanced_resize_horizontal){z.style.width=Math.max(10,h.w+h.dx)+"px"}z.style.height=Math.max(10,h.h+h.dy)+"px";w.style.height=Math.max(10,w.clientHeight+h.dy)+"px";if(v.theme_advanced_resizing_use_cookie){a.setHash("TinyMCE_"+m.id+"_size",{cw:h.w+h.dx,ch:h.h+h.dy})}});return b.cancel(x)})})}i.deltaHeight-=21;j=l=null},_nodeChanged:function(k,r,j,o){var x=this,h,q=0,w,l,y=x.settings,u,i,m;if(y.readonly){return}tinymce.each(x.stateControls,function(n){r.setActive(n,k.queryCommandState(x.controls[n][1]))});r.setActive("visualaid",k.hasVisual);r.setDisabled("undo",!k.undoManager.hasUndo()&&!k.typing);r.setDisabled("redo",!k.undoManager.hasRedo());r.setDisabled("outdent",!k.queryCommandState("Outdent"));h=d.getParent(j,"A");if(l=r.get("link")){if(!h||!h.name){l.setDisabled(!h&&o);l.setActive(!!h)}}if(l=r.get("unlink")){l.setDisabled(!h&&o);l.setActive(!!h&&!h.name)}if(l=r.get("anchor")){l.setActive(!!h&&h.name);if(tinymce.isWebKit){h=d.getParent(j,"IMG");l.setActive(!!h&&d.getAttrib(h,"mce_name")=="a")}}h=d.getParent(j,"IMG");if(l=r.get("image")){l.setActive(!!h&&j.className.indexOf("mceItem")==-1)}if(l=r.get("styleselect")){if(j.className){x._importClasses();l.select(j.className)}else{l.select()}}if(l=r.get("formatselect")){h=d.getParent(j,d.isBlock);if(h){l.select(h.nodeName.toLowerCase())}}if(k.settings.convert_fonts_to_spans){k.dom.getParent(j,function(p){if(p.nodeName==="SPAN"){if(!u&&p.className){u=p.className}if(!i&&p.style.fontSize){i=p.style.fontSize}if(!m&&p.style.fontFamily){m=p.style.fontFamily.replace(/[\"\']+/g,"").replace(/^([^,]+).*/,"$1").toLowerCase()}}return false});if(l=r.get("fontselect")){l.select(function(n){return n.replace(/^([^,]+).*/,"$1").toLowerCase()==m})}if(l=r.get("fontsizeselect")){l.select(function(n){if(n.fontSize&&n.fontSize===i){return true}if(n["class"]&&n["class"]===u){return true}})}}else{if(l=r.get("fontselect")){l.select(k.queryCommandValue("FontName"))}if(l=r.get("fontsizeselect")){w=k.queryCommandValue("FontSize");l.select(function(n){return n.fontSize==w})}}if(y.theme_advanced_path&&y.theme_advanced_statusbar_location){h=d.get(k.id+"_path")||d.add(k.id+"_path_row","span",{id:k.id+"_path"});d.setHTML(h,"");k.dom.getParent(j,function(z){var p=z.nodeName.toLowerCase(),s,v,t="";if(z.nodeType!=1||z.nodeName==="BR"||(d.hasClass(z,"mceItemHidden")||d.hasClass(z,"mceItemRemoved"))){return}if(w=d.getAttrib(z,"mce_name")){p=w}if(tinymce.isIE&&z.scopeName!=="HTML"){p=z.scopeName+":"+p}p=p.replace(/mce\:/g,"");switch(p){case"b":p="strong";break;case"i":p="em";break;case"img":if(w=d.getAttrib(z,"src")){t+="src: "+w+" "}break;case"a":if(w=d.getAttrib(z,"name")){t+="name: "+w+" ";p+="#"+w}if(w=d.getAttrib(z,"href")){t+="href: "+w+" "}break;case"font":if(y.convert_fonts_to_spans){p="span"}if(w=d.getAttrib(z,"face")){t+="font: "+w+" "}if(w=d.getAttrib(z,"size")){t+="size: "+w+" "}if(w=d.getAttrib(z,"color")){t+="color: "+w+" "}break;case"span":if(w=d.getAttrib(z,"style")){t+="style: "+w+" "}break}if(w=d.getAttrib(z,"id")){t+="id: "+w+" "}if(w=z.className){w=w.replace(/(webkit-[\w\-]+|Apple-[\w\-]+|mceItem\w+|mceVisualAid)/g,"");if(w&&w.indexOf("mceItem")==-1){t+="class: "+w+" ";if(d.isBlock(z)||p=="img"||p=="span"){p+="."+w}}}p=p.replace(/(html:)/g,"");p={name:p,node:z,title:t};x.onResolveName.dispatch(x,p);t=p.title;p=p.name;v=d.create("a",{href:"javascript:;",onmousedown:"return false;",title:t,"class":"mcePath_"+(q++)},p);if(h.hasChildNodes()){h.insertBefore(d.doc.createTextNode(" \u00bb "),h.firstChild);h.insertBefore(v,h.firstChild)}else{h.appendChild(v)}},k.getBody())}},_sel:function(h){this.editor.execCommand("mceSelectNodeDepth",false,h)},_mceInsertAnchor:function(j,i){var h=this.editor;h.windowManager.open({url:tinymce.baseURL+"/themes/advanced/anchor.htm",width:320+parseInt(h.getLang("advanced.anchor_delta_width",0)),height:90+parseInt(h.getLang("advanced.anchor_delta_height",0)),inline:true},{theme_url:this.url})},_mceCharMap:function(){var h=this.editor;h.windowManager.open({url:tinymce.baseURL+"/themes/advanced/charmap.htm",width:550+parseInt(h.getLang("advanced.charmap_delta_width",0)),height:250+parseInt(h.getLang("advanced.charmap_delta_height",0)),inline:true},{theme_url:this.url})},_mceHelp:function(){var h=this.editor;h.windowManager.open({url:tinymce.baseURL+"/themes/advanced/about.htm",width:480,height:380,inline:true},{theme_url:this.url})},_mceColorPicker:function(j,i){var h=this.editor;i=i||{};h.windowManager.open({url:tinymce.baseURL+"/themes/advanced/color_picker.htm",width:375+parseInt(h.getLang("advanced.colorpicker_delta_width",0)),height:250+parseInt(h.getLang("advanced.colorpicker_delta_height",0)),close_previous:false,inline:true},{input_color:i.color,func:i.func,theme_url:this.url})},_mceCodeEditor:function(i,j){var h=this.editor;h.windowManager.open({url:tinymce.baseURL+"/themes/advanced/source_editor.htm",width:parseInt(h.getParam("theme_advanced_source_editor_width",720)),height:parseInt(h.getParam("theme_advanced_source_editor_height",580)),inline:true,resizable:true,maximizable:true},{theme_url:this.url})},_mceImage:function(i,j){var h=this.editor;if(h.dom.getAttrib(h.selection.getNode(),"class").indexOf("mceItem")!=-1){return}h.windowManager.open({url:tinymce.baseURL+"/themes/advanced/image.htm",width:355+parseInt(h.getLang("advanced.image_delta_width",0)),height:275+parseInt(h.getLang("advanced.image_delta_height",0)),inline:true},{theme_url:this.url})},_mceLink:function(i,j){var h=this.editor;h.windowManager.open({url:tinymce.baseURL+"/themes/advanced/link.htm",width:310+parseInt(h.getLang("advanced.link_delta_width",0)),height:200+parseInt(h.getLang("advanced.link_delta_height",0)),inline:true},{theme_url:this.url})},_mceNewDocument:function(){var h=this.editor;h.windowManager.confirm("advanced.newdocument",function(i){if(i){h.execCommand("mceSetContent",false,"")}})},_mceForeColor:function(){var h=this;this._mceColorPicker(0,{color:h.fgColor,func:function(i){h.fgColor=i;h.editor.execCommand("ForeColor",false,i)}})},_mceBackColor:function(){var h=this;this._mceColorPicker(0,{color:h.bgColor,func:function(i){h.bgColor=i;h.editor.execCommand("HiliteColor",false,i)}})},_ufirst:function(h){return h.substring(0,1).toUpperCase()+h.substring(1)}});tinymce.ThemeManager.add("advanced",tinymce.themes.AdvancedTheme)}());