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
	  $(".search_song").click(function() {
		  $("#search_song").toggle();
	  });	
    $("#remove_song").click(function() {
	    $("#search_song").hide();
	  });			
    $("table") 
      .tablesorter({widthFixed: true, widgets: ['zebra']}) 
      .tablesorterPager({container: $("#pager")
    });
		$("#venue_name").james("/venues/list");
		$("#venue_city").james("/venues/city_list");
    $.fn.select_show = function(show_id){
	    $.facebox.close();
	    $("#show_id").val(show_id);
		}
		$.fn.get_setlist = function(show_id){
			$("#dialog").dialog();
			$("#dialog").load("/shows/setlist/" + show_id);								
		}
		$("#show_link").click(this.select_show);
		$('#show_date_played').datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,			
			onSelect: function(){
				$.getJSON("/shows/list", {q: $('#show_date_played').val()}, function(json){
					html = "";
					$.each(json, function(i, item) {
					  html += "<a href='#' id='show_link' onclick='$.select_show(" + item.id + ")'>";
					  html += item.label;
					  html += "</a>";
					});
					$.facebox(html);
				});			
			}
		});		
  });		
});