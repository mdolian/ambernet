$(function() {
  jQuery(document).ready(function($) {
	  $("tr[class*='search_']").hide();	
    $('a[rel*=facebox]').facebox(); 
    $("#showTable").tablesorter();
    $("a[class*='filter']").click(function() {
	    test = $("select[class*='search_filter']").val();
	    $("tr[class*='" + test +"']").toggle();
	  });
    $("a[class*='remove']").click(function(name) {
	    $(name).toggle();
	  });	
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