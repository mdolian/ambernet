$(function() {
  jQuery(document).ready(function($) {
	  $("tr[id*='search_']").hide();	
    $('a[rel*=facebox]').facebox(); 
    $("#showTable").tablesorter();
    $("a[class*='filter']").click(function() {
	    test = $("select[id*='search_filter']").val();
	    $("select[id*='search_filter'] option:selected").remove();
	    $("#" + test).toggle();
	  });
    $("#remove_label").click(function() {
	    $("#search_label").hide();
	    $("select[id*='search_filter']").addOption("search_label", "Label");
	  });
    $("#remove_taper").click(function() {
	    $("#search_taper").hide();
	    $("select[id*='search_filter']").addOption("search_taper", "Taper");
	  });		
    $("#remove_source").click(function() {
	    $("#search_source").hide();
	    $("select[id*='search_filter']").addOption("search_source", "Source");
	  });
    $("#remove_venue_name").click(function() {
	    $("#search_venue_name").hide();
	    $("select[id*='search_filter']").addOption("search_venue_name", "Venue Search");
	  });
    $("#remove_year").click(function() {
	    $("#search_year").hide();
	    $("select[id*='search_filter']").addOption("search_year", "Year");
	  });
    $("#remove_venue_city").click(function() {
	    $("#search_venue_city").hide();
	    $("select[id*='search_filter']").addOption("search_venue_city", "City");
	  });
    $("#remove_venue_state").click(function() {
	    $("#search_venue_state").hide();
	    $("select[id*='search_filter']").addOption("search_venue_state", "State");
	  });
    $("#remove_lineage").click(function() {
	    $("#search_lineage").hide();
	    $("select[id*='search_filter']").addOption("search_lineage", "Lineage");
	  });
    $("#remove_type").click(function() {
	    $("#search_type").hide();
	    $("select[id*='search_filter']").addOption("search_type", "Recording Type");
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