$(function() {
  jQuery(document).ready(function($) {
	  $("tr[id*='search_']").hide();	
    $('a[rel*=facebox]').facebox(); 
    $("#showTable").tablesorter();
	  $(".search_label").click(function() {
		  $("#search_label").toggle();
	  });
    $("#remove_label").click(function() {
	    $("#search_label").hide();
	  });
	  $(".search_taper").click(function() {
		  $("#search_taper").toggle();
	  });
    $("#remove_taper").click(function() {
	    $("#search_taper").hide();
	  });
	  $(".search_source").click(function() {
      $("#search_source").toggle();
    });			
    $("#remove_source").click(function() {
	    $("#search_source").hide();
	  });
	  $(".search_venue_name").click(function() {
		  $("#search_venue_name").toggle();
	  });	
    $("#remove_venue_name").click(function() {
	    $("#search_venue_name").hide();
	  });
	  $(".search_year").click(function() {
		  $("#search_year").toggle();
	  });	
    $("#remove_year").click(function() {
	    $("#search_year").hide();
	  });
	  $(".search_venue_city").click(function() {
		  $("#search_venue_city").toggle();
	  });	
    $("#remove_venue_city").click(function() {
	    $("#search_venue_city").hide();
	  });
	  $(".search_venue_state").click(function() {
		  $("#search_venue_state").toggle();
	  });	
    $("#remove_venue_state").click(function() {
	    $("#search_venue_state").hide();
	  });
	  $(".search_lineage").click(function() {
		  $("#search_lineage").toggle();
	  });	
    $("#remove_lineage").click(function() {
	    $("#search_lineage").hide();
	  });
	  $(".search_type").click(function() {
		  $("#search_type").toggle();
	  });	
    $("#remove_type").click(function() {
	    $("#search_type").hide();
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