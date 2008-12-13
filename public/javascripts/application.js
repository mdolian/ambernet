$(function() {
  jQuery(document).ready(function($) {
    $('a[rel*=facebox]').facebox(); 
    $("#showTable").tablesorter();
    $("table") 
      .tablesorter({widthFixed: true, widgets: ['zebra']}) 
      .tablesorterPager({container: $("#pager")});
		$("input#showSearch").autocomplete("/shows/list",
			{
				ajax:"/shows/list",
				delay:10,
				minChars:2,
				matchSubset:1,
				matchContains:1,
				cacheLength:10,
				autoFill:true
			}  
		);
  });		
});