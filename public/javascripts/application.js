$(function() {
  jQuery(document).ready(function($) {
	  $("tr[class*='search_']").hide();	
    $('a[rel*=facebox]').facebox(); 
    $("#showTable").tablesorter();
    $("a[class*='filter']").click(function() {
	    test = $("select[class*='search_filter']").val();
	    $("select[class*='search_filter'] option:selected").remove();
	    $("." + test).toggle();
	  });
    $(".search_label").hide(function() {
	    $("select[class*='search_filter'] option:selected").add("test");
	  });	
    $(".remove").click(function() {
	    alert("test");
	    $(".source_label").hide();
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