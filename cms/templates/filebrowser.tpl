<html>
<head>
<link rel="stylesheet" href="{foreach from=$css.norm item=cssUrl}{$cssUrl},{/foreach}/css/tiny_mce_filebrowser.css,/css/protomenu.css" type="text/css" />
{if $css.print|@count > 0}
	<link rel="stylesheet" href="{foreach from=$css.print item=cssUrl}{$cssUrl}{if $css.print|@key < $css.print|@count},{/if}{/foreach}" type="text/css" media="print" />
{/if}
{if $css.screen|@count > 0}
	<link rel="stylesheet" href="{foreach from=$css.screen item=cssUrl}{$cssUrl}{if $css.screen|@key < $css.screen|@count},{/if}{/foreach}" type="text/css" media="screen" />
{/if}
<script type="text/javascript" src="/js/prototype.js,/js/scriptaculous.js,/js/protomenu.js"></script>
{foreach from=$js item=jsUrl}
<script type="text/javascript" src="{$jsUrl}"></script>
{/foreach}

<script>{literal}
var win = tinyMCEPopup.getWindowArg("window");

function doSubmit(id, type) {
	if(type == 'image'){
		win.document.getElementById(tinyMCEPopup.getWindowArg("input")).value = '/images/image.php?id=' + id;
	
	    // for image browsers: update image dimensions
	    if (win.ImageDialog.getImageData) win.ImageDialog.getImageData();
	    if (win.ImageDialog.showPreviewImage) win.ImageDialog.showPreviewImage('/images/image.php?id=' + id);
	} else {
		win.document.getElementById(tinyMCEPopup.getWindowArg("input")).value = '/file/'+id;
	}

    // close popup window
    tinyMCEPopup.close();

}

var fileInfo = function(el) {
	var info = $(el).down('div.fileinfo');
	$('fileInfoShow').update(info.innerHTML);
}
var myMenuItems = [
  {
    name: 'Delete',
    className: 'delete',
    callback: function(event) {
      var el = event.element().up('div');
      new Ajax.Request('/core/DataStorage.php', {
      	method: 'post',
      	parameters: {id: el.identify(), action: 'delete'},
      	onSuccess: function(transport) {
      		Effect.Fade(el);
      	}
      });
    }
  }
]


{/literal}
</script>
</head>

<body>
<table cellpadding="0" cellspacing="0">

<tr>
<td valign="top" rowspan="2" class="fileOps">
<form method="post" target="" name="filebrowser_select">
	<select name="type" style="float: left;">
		<option value="image" {if $type == 'image'}SELECTED{/if}>Images</option>
		<option value="file" {if $type != 'image'}SELECTED{/if}>Files</option>
	</select>
	<input type="submit" value="Select" name="submit" style="float: left;">
</form>
<div style="clear: both;" id="fileInfoShow">
</div>
</td>
<td valign="top" colspan="2" align="left" style="padding-left: 5px;">
<form method="post" target="" name="filebrowser_upload" enctype="multipart/form-data">
	Upload a file: <input name="filebrowser_uploadedfile" type="file" />
	<input type="hidden" value="{$type}" name="uploadtype" />
	<input type="submit" value="Upload" name="uploadsubmit">
</form>
</td>
</tr>
<td valign="top">
	{if $type == 'image'}
		{foreach from=$images item=image}
			<div onclick="doSubmit({$image.id}, 'image');" onmouseover="fileInfo(this);" class="filebrowsericon" id="{$image.id}" />
				<img src="/images/image.php?id={$image.id}&clipw=48" />
				<br />
				{math equation="x / 1024" x=$image.filesize assign=size}
				{$image->content_type}
				<br />
				{$size|string_format:"%.1f"} KB
				<div class="fileinfo">
				
				<img src="/images/image.php?id={$image.id}&w=125" /> <br />
				<strong>Name:</strong> {$image.filename}<br />
				<strong>Type:</strong> {$image.content_type}<br />
				<strong>Size:</strong> {$image.filesize} bytes<br />
				</div>
			</div>
		{/foreach}
	{else}
		{foreach from=$files item=file}
			<div onclick="doSubmit({$file->getId()}, 'file');" class="filebrowsericon">
				{if $file->getFileIcon()}
					<img src="/images/filebrowser/{$file->getFileIcon()}" />
				{else}
					<img src="/images/filebrowser/default.png" width="48" height="48"  />
				{/if}
				<br />
				{$file->getName()}
				{math equation="x / 1024" x=$file->getSize() assign=size}
				{$file->content_type}
				<br />
				{$size|string_format:"%.1f"} KB
			</div>
		{/foreach}
	{/if}
</td>
</tr>
</table>
{literal}
<script type="text/javascript">
new Proto.Menu({
  selector: '.filebrowsericon', // context menu will be shown when element with id of "contextArea" is clicked
  className: 'menu desktop', // this is a class which will be attached to menu container (used for css styling)
  menuItems: myMenuItems // array of menu items
})
</script>
{/literal}


</body>

</html>
